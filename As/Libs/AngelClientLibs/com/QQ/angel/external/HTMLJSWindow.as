package com.QQ.angel.external
{
   import flash.events.EventDispatcher;
   import flash.external.ExternalInterface;
   
   public class HTMLJSWindow extends EventDispatcher implements IHTMLWindow
   {
       
      
      protected var isConnect:Boolean;
      
      protected var hostKey:String;
      
      protected var clientKey:String;
      
      protected var listener:Object;
      
      protected var proxySrc:String;
      
      protected var aimSrc:String;
      
      public function HTMLJSWindow(param1:String, param2:String, param3:String, param4:String)
      {
         super();
         this.hostKey = param1;
         this.clientKey = param2;
         this.proxySrc = param3;
         this.aimSrc = param4;
      }
      
      public function open() : void
      {
         if(ExternalInterface.available)
         {
            this.isConnect = true;
            ExternalInterface.addCallback("openWinCallBack",this.openWinCallBack);
            ExternalInterface.call("openWindow",this.proxySrc,this.aimSrc,this.clientKey,this.hostKey);
         }
      }
      
      protected function openWinCallBack(param1:String = "", param2:Object = null) : void
      {
         this.LC_TEST("openWinCallBack+" + param1);
         if(param1 == "")
         {
            return;
         }
         if(this.listener != null && this.listener.hasOwnProperty(param1))
         {
            this.listener[param1](param2);
         }
      }
      
      public function lcCall(... rest) : void
      {
         var _loc2_:String = rest[0];
         var _loc3_:Object = null;
         if(rest.length > 1)
         {
            _loc3_ = rest[1];
         }
         if(ExternalInterface.available)
         {
            ExternalInterface.call("gameWatch",_loc2_,_loc3_);
         }
      }
      
      public function LC_TEST(param1:String) : void
      {
      }
      
      public function setListener(param1:Object) : void
      {
         this.listener = param1;
      }
      
      public function registerWinEvent(param1:Array) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("gameWatch","JS_Win_addWatch",param1);
         }
      }
      
      public function getState() : int
      {
         return 0;
      }
      
      public function close() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("closeWindow");
            this.isConnect = false;
         }
      }
   }
}
