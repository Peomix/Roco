package com.QQ.angel.actions.ui.net
{
   import flash.events.Event;
   
   public class CGIEvent extends Event
   {
      
      public static const GOT_ERROR:String = "goterror";
       
      
      public var msg:String;
      
      public var data:*;
      
      public var sendData:Object;
      
      public var sendType:String;
      
      public function CGIEvent(param1:String, param2:String = null, param3:Object = null)
      {
         super(param1);
         this.sendType = param2;
         this.sendData = param3;
      }
   }
}
