package com.QQ.angel.api.events
{
   public class WindowEvent extends BaseEvent
   {
      
      public static const INITIALIZING:String = "WindowInitializing";
      
      public static const INITIALIZED:String = "WindowInitialized";
      
      public static const CLOSING:String = "WindowClosing";
      
      public static const CLOSED:String = "WindowClosed";
      
      public static const SHOW:String = "WindowShow";
      
      public static const HIDE:String = "WindowHide";
       
      
      public function WindowEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
