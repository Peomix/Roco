package com.QQ.angel.actions.ui.net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class CGILoader02 extends EventDispatcher
   {
      
      protected var loader:URLLoader;
      
      protected var cgiRoot:String;
      
      public var url:String;
      
      public var dataHandler:Function;
      
      public var errorHandler:Function;
      
      public function CGILoader02(param1:String, param2:URLLoader)
      {
         super();
         this.cgiRoot = param1;
         this.loader = param2;
         this.loader.addEventListener(Event.COMPLETE,this.loadDataComplete);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.loadDataError);
      }
      
      protected function loadDataComplete(param1:Event) : void
      {
         if(this.dataHandler != null)
         {
            this.dataHandler(new XML(this.loader.data));
         }
      }
      
      protected function loadDataError(param1:IOErrorEvent) : void
      {
         if(this.errorHandler != null)
         {
            this.errorHandler(param1);
         }
      }
      
      public function send() : void
      {
         this.loader.load(new URLRequest(this.cgiRoot + this.url));
      }
      
      public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.removeEventListener(Event.COMPLETE,this.loadDataComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadDataError);
         }
         this.loader = null;
      }
   }
}

