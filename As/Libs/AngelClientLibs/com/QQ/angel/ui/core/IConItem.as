package com.QQ.angel.ui.core
{
   import flash.display.Bitmap;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class IConItem extends AImage
   {
       
      
      public var numTxt:TextField;
      
      public var tooltip:String;
      
      protected var data:Object;
      
      public function IConItem(param1:Number = 0, param2:Number = 0, param3:Boolean = true)
      {
         super(param1,param2,param3);
         visible = false;
         this.numTxt = new TextField();
         this.numTxt.visible = false;
         this.numTxt.selectable = false;
         this.numTxt.filters = [new GlowFilter(16777215,1,2,2,4)];
         this.addChild(this.numTxt);
         var _loc4_:TextFormat;
         (_loc4_ = this.numTxt.defaultTextFormat).size = 14;
         _loc4_.bold = true;
         _loc4_.align = TextFormatAlign.RIGHT;
         this.numTxt.defaultTextFormat = _loc4_;
      }
      
      private function updateTxt() : void
      {
         this.numTxt.visible = true;
         this.numTxt.width = content.width;
         this.numTxt.y = content.height - this.numTxt.textHeight;
         this.setChildIndex(this.numTxt,numChildren - 1);
         this.numTxt.text = this.numTxt.text;
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
         if(this.data == null)
         {
            this.visible = false;
            this.unload();
         }
         else
         {
            this.visible = true;
            this.numTxt.text = param1.hasOwnProperty("level") ? "Lv." + param1.level : "";
            this.tooltip = param1.hasOwnProperty("tooltip") ? param1.tooltip : param1.tips;
            this.setPath(param1.hasOwnProperty("src") ? param1.src : param1.icon);
         }
      }
      
      public function getCount() : int
      {
         if(this.data == null)
         {
            return 0;
         }
         return int(this.data.hasOwnProperty("num") ? this.data.num : this.data.count);
      }
      
      override protected function addImage(param1:Bitmap) : void
      {
         content = param1;
         if(imgSize.x > 0)
         {
            content.height *= imgSize.x / param1.width;
            content.width = imgSize.x;
         }
         else if(imgSize.y > 0)
         {
            content.width *= imgSize.y / param1.height;
            content.height = imgSize.y;
         }
         content.smoothing = true;
         addChild(content);
         this.updateTxt();
      }
   }
}
