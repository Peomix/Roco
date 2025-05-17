package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.display.IDisplay;
   import flash.geom.Rectangle;
   
   public interface IBubbleSkin extends IDisplay
   {
      
      function setSize(param1:int, param2:int) : void;
      
      function get contentRect() : Rectangle;
      
      function get borderWidth() : int;
      
      function get borderHeight() : int;
   }
}

