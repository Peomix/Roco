package com.QQ.angel.api.events
{
   public class AngelNetSysEvent extends BaseEvent
   {
      
      public static const ON_STATE_CHANGE:String = "onStateChange";
      
      public static const NS_CONNETED:String = "nsConneted";
      
      public static const NS_CLOSED:String = "nsClosed";
      
      public static const NS_ERROR:String = "nsError";
       
      
      public var currState:String;
      
      public function AngelNetSysEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function getTcpID() : int
      {
         return data as int;
      }
   }
}
