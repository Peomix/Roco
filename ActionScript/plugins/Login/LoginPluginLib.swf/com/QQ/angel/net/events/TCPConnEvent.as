package com.QQ.angel.net.events
{
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.api.net.protocol.ADF;
   import flash.events.Event;
   
   public class TCPConnEvent extends BaseEvent
   {
      
      public static const TCPCONN_CONNECTED:String = "tcpConnConnected";
      
      public static const TCPCONN_CLOSED:String = "tcpConnClosed";
      
      public static const TCPCONN_ERROR:String = "tcpConnError";
      
      public static const TCPCONN_ONADF:String = "tcpConnOnADF";
      
      public static const TCPCONN_TIMEOUT:String = "tcpConnTimeOut";
      
      private var __tcpID:int = 0;
      
      public var dataType:int;
      
      public function TCPConnEvent(param1:String, param2:int = 0, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this.__tcpID = param2;
      }
      
      public function getTCPID() : int
      {
         return this.__tcpID;
      }
      
      public function getADF() : ADF
      {
         return data as ADF;
      }
      
      override public function clone() : Event
      {
         var _loc1_:TCPConnEvent = super.clone() as TCPConnEvent;
         _loc1_.dataType = this.dataType;
         return _loc1_;
      }
   }
}

