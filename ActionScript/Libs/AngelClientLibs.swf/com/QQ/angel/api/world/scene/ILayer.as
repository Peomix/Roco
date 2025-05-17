package com.QQ.angel.api.world.scene
{
   import com.QQ.angel.api.events.IRenderListener;
   import flash.display.DisplayObjectContainer;
   
   public interface ILayer extends IRenderListener
   {
      
      function initialize(... rest) : void;
      
      function finalize() : void;
      
      function getLayerID() : int;
      
      function addElement(param1:IElement) : void;
      
      function removeElement(param1:IElement) : Boolean;
      
      function getElement(param1:int) : IElement;
      
      function getElement2(param1:String) : IElement;
      
      function removeElement2(param1:int) : void;
      
      function removeAll() : void;
      
      function getContainer() : DisplayObjectContainer;
   }
}

