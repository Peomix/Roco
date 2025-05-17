package com.QQ.angel.api.display
{
   import com.QQ.angel.api.events.IRenderListener;
   import flash.display.DisplayObject;
   
   public interface IDisplay extends IRenderListener
   {
      
      function get visible() : Boolean;
      
      function set visible(param1:Boolean) : void;
      
      function get x() : Number;
      
      function set x(param1:Number) : void;
      
      function get y() : Number;
      
      function set y(param1:Number) : void;
      
      function get width() : Number;
      
      function get height() : Number;
      
      function get mouseX() : Number;
      
      function get mouseY() : Number;
      
      function get display() : DisplayObject;
      
      function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean;
      
      function hitTestObject(param1:DisplayObject) : Boolean;
      
      function addChild(param1:DisplayObject) : DisplayObject;
      
      function addChildAt(param1:DisplayObject, param2:int) : DisplayObject;
      
      function contains(param1:DisplayObject) : Boolean;
      
      function getChildAt(param1:int) : DisplayObject;
      
      function getChildByName(param1:String) : DisplayObject;
      
      function getChildIndex(param1:DisplayObject) : int;
      
      function removeChild(param1:DisplayObject) : DisplayObject;
      
      function removeChildAt(param1:int) : DisplayObject;
      
      function setChildIndex(param1:DisplayObject, param2:int) : void;
      
      function swapChildren(param1:DisplayObject, param2:DisplayObject) : void;
      
      function swapChildrenAt(param1:int, param2:int) : void;
      
      function unload() : void;
   }
}

