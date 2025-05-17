package com.QQ.angel.logging
{
   import flash.events.ErrorEvent;
   import flash.net.URLLoader;
   
   public class AngelLogger implements ILogger
   {
      
      private static var __instance:ILogger;
      
      protected var logFun:Function;
      
      protected var logClientFun:Function;
      
      protected var httpLoader:URLLoader;
      
      public function AngelLogger(param1:Function, param2:Function)
      {
         super();
         this.logFun = param1;
         this.logClientFun = param2;
      }
      
      public static function getLogger(param1:Function = null, param2:Function = null) : ILogger
      {
         if(__instance == null)
         {
            __instance = new AngelLogger(param1,param2);
         }
         return __instance;
      }
      
      protected function onHttpError(param1:ErrorEvent) : void
      {
         trace("[AngelLogger] error is " + param1.text);
      }
      
      protected function write(param1:int, param2:int) : void
      {
      }
      
      public function log(param1:int, param2:int = 1) : void
      {
         if(this.logFun != null)
         {
            this.logFun.call(null,param1,param2);
         }
      }
      
      public function logClient(param1:int, param2:String) : void
      {
         if(this.logClientFun != null)
         {
            param2 = param2.replace("\n","【】");
         }
         var _loc3_:String = param1 + "|" + param2;
         this.logClientFun(_loc3_);
      }
   }
}

