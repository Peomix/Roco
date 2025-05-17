package com.QQ.angel.actions.ui.net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class CGILoader extends EventDispatcher
   {
      
      protected var loader:URLLoader;
      
      protected var cgiRoot:String;
      
      protected var xevent:CGIEvent;
      
      public function CGILoader(param1:String, param2:URLLoader)
      {
         super();
         this.cgiRoot = param1;
         this.loader = param2;
         this.loader.addEventListener(Event.COMPLETE,this.loadDataComplete);
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.loadDataError);
      }
      
      protected function loadDataComplete(param1:Event) : void
      {
         this.xevent.data = new XML(this.loader.data);
         var _loc2_:Event = this.xevent;
         this.xevent = null;
         dispatchEvent(_loc2_);
      }
      
      protected function loadDataError(param1:IOErrorEvent) : void
      {
         var _loc2_:CGIEvent = new CGIEvent(CGIEvent.GOT_ERROR);
         _loc2_.msg = param1.text;
         this.xevent = null;
         dispatchEvent(_loc2_);
      }
      
      public function sendData(param1:String, param2:Object = null) : void
      {
         var _loc4_:* = undefined;
         if(this.xevent != null)
         {
            return;
         }
         this.xevent = new CGIEvent(Event.COMPLETE,param1,param2);
         var _loc3_:String = this.cgiRoot + param1;
         if(param2 != null)
         {
            for(_loc4_ in param2)
            {
               _loc3_ += "&" + _loc4_ + "=" + param2[_loc4_];
            }
         }
         this.loader.load(new URLRequest(_loc3_));
      }
      
      public function dispose() : void
      {
         if(this.loader)
         {
            this.loader.removeEventListener(Event.COMPLETE,this.loadDataComplete);
            this.loader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadDataError);
         }
         this.loader = null;
         this.xevent = null;
      }
   }
}

