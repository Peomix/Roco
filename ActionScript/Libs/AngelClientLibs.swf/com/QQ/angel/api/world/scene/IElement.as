package com.QQ.angel.api.world.scene
{
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   
   public interface IElement extends IEventDispatcher
   {
      
      function initialize(... rest) : void;
      
      function finalize() : void;
      
      function getID() : uint;
      
      function getName() : String;
      
      function get display() : DisplayObject;
      
      function getView() : *;
      
      function setData(param1:Object) : void;
      
      function getData() : Object;
      
      function attachView(param1:*) : void;
      
      function onDataChange(param1:Object) : void;
   }
}

