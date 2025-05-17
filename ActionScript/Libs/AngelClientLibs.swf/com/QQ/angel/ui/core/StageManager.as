package com.QQ.angel.ui.core
{
   import flash.display.Stage;
   
   public class StageManager
   {
      
      private static var _stage:Stage;
      
      public function StageManager()
      {
         super();
      }
      
      public static function setup(param1:Stage) : void
      {
         _stage = param1;
      }
      
      public static function get stage() : Stage
      {
         return _stage;
      }
   }
}

