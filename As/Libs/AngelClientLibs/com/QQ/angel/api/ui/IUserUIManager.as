package com.QQ.angel.api.ui
{
   public interface IUserUIManager
   {
       
      
      function getUIComponent(param1:String) : IAUIComponent;
      
      function setAllComponentsVisible(param1:Boolean) : void;
      
      function setAllComponentsEnabled(param1:Boolean) : void;
      
      function getAllComponents() : Array;
   }
}
