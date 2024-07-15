package com.QQ.angel.ui.sysicons
{
   import flash.geom.Point;
   
   public interface ISysIcon
   {
       
      
      function dispose() : void;
      
      function get enable() : Boolean;
      
      function set enable(param1:Boolean) : void;
      
      function get seat() : int;
      
      function set seat(param1:int) : void;
      
      function set data(param1:SysIconData) : void;
      
      function set onClick(param1:Function) : void;
      
      function get tooltip() : String;
      
      function get tooltipPos() : Point;
      
      function set tooltipPos(param1:Point) : void;
   }
}
