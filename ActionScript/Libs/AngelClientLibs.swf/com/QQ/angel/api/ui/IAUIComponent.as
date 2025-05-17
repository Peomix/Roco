package com.QQ.angel.api.ui
{
   import flash.events.IEventDispatcher;
   
   public interface IAUIComponent extends IEventDispatcher
   {
      
      function setVisible(param1:Boolean) : void;
      
      function getVisible() : Boolean;
      
      function setEnabled(param1:Boolean) : void;
      
      function getEnabled() : Boolean;
      
      function getComponetName() : String;
   }
}

