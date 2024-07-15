package com.QQ.angel.ui.core
{
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.core.Dialog")]
   public class Dialog extends Window
   {
       
      
      public var bg:Sprite;
      
      public var closeButton:SimpleButton;
      
      public var content:DialogContent;
      
      public function Dialog(param1:DisplayObjectContainer, param2:Boolean = false, param3:String = "")
      {
         super();
         initialize(param1,this.bg,this.closeButton,this.content,param2);
         this.content.message = param3;
      }
   }
}
