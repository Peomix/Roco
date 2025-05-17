package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol122")]
   public class Alert extends Window
   {
      
      public var bg:Sprite;
      
      public var content:AlertContent;
      
      public function Alert(param1:DisplayObjectContainer, param2:String = "", param3:String = "", param4:int = 0, param5:CFunction = null)
      {
         super();
         this.content = new AlertContent();
         initialize(param1,this.bg,null,this.content,true);
         this.initContent(param2,param3,param4,param5);
         center();
      }
      
      private function initContent(param1:String = "", param2:String = "", param3:int = 0, param4:CFunction = null) : void
      {
         this.content.title = param1;
         this.content.message = param2;
         this.content.mode = param3;
         this.content.handler = param4;
      }
   }
}

