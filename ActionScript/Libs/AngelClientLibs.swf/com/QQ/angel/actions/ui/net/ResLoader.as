package com.QQ.angel.actions.ui.net
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class ResLoader
   {
      
      public var url:String;
      
      public var dataHandler:Function;
      
      public var errorHandler:Function;
      
      private var loader:Loader;
      
      public function ResLoader()
      {
         super();
      }
      
      public function load() : void
      {
         if(this.url == null)
         {
            return;
         }
         this.loader = new Loader();
         this.addEvent();
         this.loader.load(new URLRequest(this.url));
      }
      
      private function handleError(param1:IOErrorEvent) : void
      {
         if(this.errorHandler != null)
         {
            this.errorHandler(param1);
         }
      }
      
      private function completeFun(param1:Event) : void
      {
         if(this.dataHandler != null)
         {
            this.dataHandler(this.loader.content);
         }
      }
      
      private function progressFun(param1:ProgressEvent) : void
      {
      }
      
      private function addEvent() : void
      {
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.progressFun);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeFun);
      }
      
      private function delEvent() : void
      {
         this.loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.handleError);
         this.loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.progressFun);
         this.loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.completeFun);
      }
      
      public function dispose() : void
      {
         if(this.loader != null)
         {
            this.loader.unload();
            this.delEvent();
         }
      }
   }
}

