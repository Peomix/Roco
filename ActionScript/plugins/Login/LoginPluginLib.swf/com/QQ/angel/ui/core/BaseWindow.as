package com.QQ.angel.ui.core
{
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class BaseWindow extends Window
   {
      
      public var bg:Sprite;
      
      public var closeButton:SimpleButton;
      
      public var content:Sprite;
      
      public function BaseWindow(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         initialize(param1,this.bg,this.closeButton,this.content,param2);
      }
   }
}

