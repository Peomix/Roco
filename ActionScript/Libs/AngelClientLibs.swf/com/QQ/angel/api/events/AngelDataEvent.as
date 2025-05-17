package com.QQ.angel.api.events
{
   import com.QQ.angel.api.net.protocol.ADF;
   import flash.events.Event;
   
   public class AngelDataEvent extends BaseEvent
   {
      
      public static const TRYSENDADF:String = "trySendADF";
      
      public static const RECEIVEADF:String = "receiveADF";
      
      public var tcpID:int = -1;
      
      public var hasSerNum:Boolean = false;
      
      public var dataType:int;
      
      public function AngelDataEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function getADF() : ADF
      {
         return data as ADF;
      }
      
      override public function clone() : Event
      {
         var _loc1_:AngelDataEvent = super.clone() as AngelDataEvent;
         _loc1_.tcpID = this.tcpID;
         _loc1_.hasSerNum = this.hasSerNum;
         _loc1_.dataType = this.dataType;
         return _loc1_;
      }
   }
}

