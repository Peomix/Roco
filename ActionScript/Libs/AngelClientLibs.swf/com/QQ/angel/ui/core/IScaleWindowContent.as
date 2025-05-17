package com.QQ.angel.ui.core
{
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   
   public interface IScaleWindowContent extends IWindowContent
   {
      
      function getDisplay() : DisplayObject;
      
      function getBGRect() : Point;
      
      function getCloseBtnPos() : Point;
      
      function addCloseHandler(param1:Function) : void;
      
      function getDragArea() : InteractiveObject;
   }
}

