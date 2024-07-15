package com.QQ.angel.api.events
{
   import flash.events.Event;
   
   public class BaseEvent extends Event
   {
      
      public static const ON_ERROR:String = "onError";
      
      public static const ON_SUCCESS:String = "onSuccess";
      
      public static const ON_TIMEOUT:String = "onTimeOut";
       
      
      public var message:String;
      
      public var data:Object;
      
      public function BaseEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:Class = this["constructor"];
         var _loc2_:BaseEvent = new _loc1_(this.type,bubbles,cancelable);
         _loc2_.data = this.data;
         _loc2_.message = this.message;
         return _loc2_;
      }
   }
}
