package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IAUIComponent;
   import flash.display.DisplayObject;
   
   public interface IAngelUIComponent extends IAUIComponent
   {
      
      function addAngelUICom(param1:IAngelUIComponent) : IAUIComponent;
      
      function removeAngelUICom(param1:IAngelUIComponent) : Boolean;
      
      function getComDisplay() : DisplayObject;
   }
}

