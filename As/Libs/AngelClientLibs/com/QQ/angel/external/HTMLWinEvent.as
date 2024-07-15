package com.QQ.angel.external
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class HTMLWinEvent extends BaseEvent
   {
      
      public static const ON_WIN_OPEN:String = "onWinOpen";
      
      public static const ON_WIN_CLOSED:String = "onWinClosed";
      
      public static const ON_WIN_EVENT:String = "onWinEvent";
       
      
      public var winEventType:String;
      
      public function HTMLWinEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
