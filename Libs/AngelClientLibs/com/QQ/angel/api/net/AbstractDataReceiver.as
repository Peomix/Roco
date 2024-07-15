package com.QQ.angel.api.net
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.api.events.AngelDataEvent;
   import flash.events.EventDispatcher;
   
   public class AbstractDataReceiver extends EventDispatcher implements IDataReceiver, IAngelSysAPIAware
   {
       
      
      protected var sendevent:AngelDataEvent;
      
      protected var sysApi:IAngelSysAPI;
      
      public var serNum:int = 0;
      
      public function AbstractDataReceiver()
      {
         this.sendevent = new AngelDataEvent(AngelDataEvent.TRYSENDADF);
         super();
      }
      
      public function catchTrySendDataError(param1:int, param2:int, param3:Object) : void
      {
         trace("[AbstractDataReceiver] cmdType:0x" + param1.toString(16) + ",tcpID:" + param2 + "发送失败!");
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.sysApi = param1;
      }
      
      public function initialize() : void
      {
      }
      
      public function finalize() : void
      {
      }
      
      public function onDataReceive(param1:int, param2:Object) : void
      {
         throw new AngelError(AngelError.METHOD_NOT_IMPL,this);
      }
      
      public function sendDataToServer(param1:int, param2:Object) : void
      {
         this.sendevent.dataType = param1;
         this.sendevent.hasSerNum = false;
         this.serNum = 0;
         this.sendevent.data = param2;
         dispatchEvent(this.sendevent);
      }
      
      public function sendDataWithSerNum(param1:int, param2:Object) : void
      {
         this.sendevent.dataType = param1;
         this.sendevent.data = param2;
         this.sendevent.hasSerNum = true;
         this.serNum = 0;
         dispatchEvent(this.sendevent);
      }
      
      public function getAcceptTypes() : Array
      {
         throw new AngelError(AngelError.METHOD_NOT_IMPL,this);
      }
   }
}
