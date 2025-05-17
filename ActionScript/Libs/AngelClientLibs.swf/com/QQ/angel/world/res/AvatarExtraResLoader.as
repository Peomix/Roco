package com.QQ.angel.world.res
{
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   
   public class AvatarExtraResLoader
   {
      
      public var url:String;
      
      public var dataHandler:Function;
      
      public var errorHandler:Function;
      
      public var index:int;
      
      private var loader:Loader;
      
      public function AvatarExtraResLoader()
      {
         super();
      }
      
      public function load(param1:String) : void
      {
         this.url = param1;
         this.loader = new Loader();
         this.addEvent();
         this.loader.load(new URLRequest(param1));
      }
      
      private function handleError(param1:IOErrorEvent) : void
      {
         if(this.errorHandler != null)
         {
            this.errorHandler(param1,this);
         }
      }
      
      private function completeFun(param1:Event) : void
      {
         if(this.dataHandler != null)
         {
            this.dataHandler(param1,this);
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

