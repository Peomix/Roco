package com.QQ.angel.api
{
   import flash.geom.Point;
   
   public interface IExternalAPI
   {
      
      function mapAbsPath(param1:String) : String;
      
      function getHTMLVars() : Object;
      
      function getFlashVar(param1:String) : Object;
      
      function reflashHTML() : void;
      
      function setFrameRate(param1:int = -1) : void;
      
      function ccGC(param1:int = 0) : void;
      
      function openASWindow(param1:String, param2:String, param3:Boolean = false, param4:Point = null, param5:Function = null, param6:Object = null, param7:Boolean = true, param8:Boolean = false, param9:Object = null) : Boolean;
      
      function openHTMLWindow(param1:String, param2:String) : Object;
      
      function openHTMLJSWindow(param1:String, param2:String) : Object;
   }
}

