package com.QQ.angel.external
{
   import flash.events.EventDispatcher;
   import flash.events.StatusEvent;
   import flash.external.ExternalInterface;
   import flash.net.LocalConnection;
   
   public class HTMLWindow extends EventDispatcher implements IHTMLWindow
   {
       
      
      protected var lc:LocalConnection;
      
      protected var hostKey:String;
      
      protected var clientKey:String;
      
      protected var listener:Object;
      
      protected var proxySrc:String;
      
      protected var aimSrc:String;
      
      public function HTMLWindow(param1:String, param2:String, param3:String, param4:String)
      {
         var hostKey:String = param1;
         var clientKey:String = param2;
         var proxySrc:String = param3;
         var aimSrc:String = param4;
         super();
         this.hostKey = hostKey;
         this.clientKey = clientKey;
         this.proxySrc = proxySrc;
         this.aimSrc = aimSrc;
         this.lc = new LocalConnection();
         this.lc.client = this.listener = this;
         this.lc.addEventListener(StatusEvent.STATUS,this.onStatus);
         try
         {
            this.lc.connect(hostKey);
         }
         catch(error:ArgumentError)
         {
         }
      }
      
      protected function onStatus(param1:StatusEvent) : void
      {
      }
      
      public function lcCall(... rest) : void
      {
         var _loc2_:Function = this.lc.send;
         (rest as Array).splice(0,0,this.clientKey);
         _loc2_.apply(this.lc,rest);
      }
      
      public function setListener(param1:Object) : void
      {
         this.lc.client = this.listener = param1;
      }
      
      public function onWinEvent(param1:String, param2:Object = null) : void
      {
         switch(param1)
         {
            case "quit":
               this.close();
         }
      }
      
      public function open() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("openWindow",this.proxySrc,this.aimSrc,this.clientKey,this.hostKey);
         }
      }
      
      public function registerWinEvent(param1:Array) : void
      {
         this.lc.send(this.clientKey,"LC_Win_addWatch",param1);
      }
      
      public function LC_Win_DispatchEvent(param1:String, param2:Object = null) : void
      {
         if(this.listener != null && this.listener.hasOwnProperty("onWinEvent"))
         {
            this.listener["onWinEvent"](param1,param2);
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
         }
         this.lc.close();
      }
   }
}
