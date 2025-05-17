package com.QQ.angel.utils
{
   public class DispatchManager
   {
      
      private static var _dispatcher:CustomEventDispatcher = new CustomEventDispatcher();
      
      public function DispatchManager()
      {
         super();
      }
      
      public static function addEventListener(param1:String, param2:Function) : void
      {
         _dispatcher.addEventListener(param1,param2);
      }
      
      public static function dispatch(param1:String, param2:* = null) : void
      {
         _dispatcher.dispatchEvent(param1,param2);
      }
      
      public static function removeListener(param1:String, param2:Function) : void
      {
         _dispatcher.removeEventListener(param1,param2);
      }
   }
}

