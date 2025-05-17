package com.QQ.angel.plugs.Login.ui2.events
{
   import flash.events.Event;
   
   public class LoginUIEvent extends Event
   {
      
      public static const RECOMMAND_REQ:String = "recommandRequest";
      
      public static const RANGE_REQ:String = "rangeRequest";
      
      public static const LOGIN_REQ:String = "loginRequest";
      
      public static const SPEED_IN:String = "speedIn";
      
      public static const FAST_LOGIN:String = "fastLogin";
      
      public var data:Object;
      
      public function LoginUIEvent(param1:String, param2:Object = null)
      {
         super(param1,true);
         this.data = param2;
      }
   }
}

