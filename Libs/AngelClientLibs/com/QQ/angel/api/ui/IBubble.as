package com.QQ.angel.api.ui
{
   import com.QQ.angel.api.display.IDisplay;
   import flash.display.DisplayObjectContainer;
   
   public interface IBubble extends IDisplay
   {
       
      
      function setContainer(param1:DisplayObjectContainer) : void;
      
      function setVisible(param1:Boolean) : void;
      
      function getVisible() : Boolean;
      
      function setContent(param1:*) : void;
      
      function getType() : int;
      
      function setSkin(param1:*) : void;
   }
}
