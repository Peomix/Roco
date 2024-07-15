package com.QQ.angel.utils
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class LocalFileQueueLoader extends Loader
   {
       
      
      protected var files:Array;
      
      protected var loader:Loader;
      
      protected var isLoading:Boolean = false;
      
      protected var currFile:ILocalFile;
      
      public function LocalFileQueueLoader()
      {
         this.files = [];
         super();
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.OPEN,this.openHandler);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
      }
      
      public function addFile(param1:ILocalFile) : void
      {
         if(param1 == null || this.files.indexOf(param1) != -1)
         {
            return;
         }
         this.files.push(param1);
         this.nextLoadFile();
      }
      
      protected function openHandler(param1:Event) : void
      {
         this.currFile.onFileOpen(this.loader.content);
      }
      
      protected function errorHandler(param1:IOErrorEvent) : void
      {
         var event:IOErrorEvent = param1;
         try
         {
            this.currFile.onFileLoadError(event.text);
            this.loader.unload();
         }
         catch(error:Error)
         {
            trace("LocalFileQueueLoader 调用 errorHandler" + error.message);
         }
         this.currFile = null;
         this.isLoading = false;
         this.nextLoadFile();
      }
      
      protected function completeHandler(param1:Event) : void
      {
         var _loc2_:Object = this.loader.content;
         this.loader.unload();
         this.currFile.onFileLoaded(_loc2_);
         this.currFile = null;
         this.isLoading = false;
         this.nextLoadFile();
      }
      
      protected function nextLoadFile() : void
      {
         if(this.isLoading)
         {
            return;
         }
         if(this.files.length == 0)
         {
            return;
         }
         this.currFile = this.files.shift() as ILocalFile;
         if(this.currFile == null || this.currFile.isNull())
         {
            this.currFile = null;
            this.nextLoadFile();
            return;
         }
         this.loader.load(new URLRequest(this.currFile.getURL()),this.currFile.getContext());
         this.isLoading = true;
      }
   }
}
