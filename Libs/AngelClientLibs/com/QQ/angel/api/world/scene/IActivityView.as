package com.QQ.angel.api.world.scene
{
   import com.QQ.angel.api.ui.IBubble;
   
   public interface IActivityView extends IElementView
   {
       
      
      function setDepth(param1:int) : void;
      
      function getDepth() : int;
      
      function setMouseEnabled(param1:Boolean) : void;
      
      function getMouseEnabled() : Boolean;
      
      function setSelected(param1:Boolean) : void;
      
      function getSelected() : Boolean;
      
      function setBubble(param1:IBubble) : void;
      
      function getBubble() : IBubble;
   }
}
