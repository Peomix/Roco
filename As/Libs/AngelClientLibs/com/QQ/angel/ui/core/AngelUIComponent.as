package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IAUIComponent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class AngelUIComponent extends Sprite implements IAngelUIComponent
   {
       
      
      public function AngelUIComponent()
      {
         super();
      }
      
      public function setVisible(param1:Boolean) : void
      {
         this.visible = param1;
      }
      
      public function getVisible() : Boolean
      {
         return this.visible;
      }
      
      public function addAngelUICom(param1:IAngelUIComponent) : IAUIComponent
      {
         return null;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this.mouseEnabled = param1;
      }
      
      public function removeAngelUICom(param1:IAngelUIComponent) : Boolean
      {
         return false;
      }
      
      public function getEnabled() : Boolean
      {
         return this.mouseEnabled;
      }
      
      public function getComponetName() : String
      {
         return this.name;
      }
      
      public function getComDisplay() : DisplayObject
      {
         return this;
      }
   }
}
