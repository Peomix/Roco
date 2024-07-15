package com.QQ.angel.ui.core.textfield
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class ImageTextField extends Sprite
   {
      
      public static const REG_VIP:RegExp = /\[vip].*?\[\/vip]/ig;
      
      private static var regImg:RegExp = /#\d{2}/ig;
       
      
      protected var _textField:TextField;
      
      public var channel:int;
      
      private var _width:Number;
      
      private var _align:String;
      
      private var _htmlTxt:String;
      
      private var _maxHeight:Number = 2147483647;
      
      private var _multiline:Boolean;
      
      private var _bold:Boolean;
      
      private var _filters:Array;
      
      private var _autoSize:String = "none";
      
      private var _color:uint;
      
      private var _defaultTextFormat:TextFormat;
      
      public function ImageTextField(param1:int = 1, param2:Number = 7)
      {
         super();
         this._align = TextFormatAlign.LEFT;
         this._width = 150;
         this._multiline = true;
         this.initTxt(param1,param2);
         this._textField.text = " ";
      }
      
      private function initTxt(param1:int = 1, param2:Number = 7) : void
      {
         if(null == this._textField)
         {
            this._textField = new TextField();
         }
         this._textField.mouseEnabled = true;
         this._textField.multiline = this._multiline;
         this._textField.wordWrap = this._multiline;
         this._textField.selectable = false;
         this._textField.autoSize = this._autoSize;
         this._textField.width = this._width;
         this._textField.filters = this._filters;
         if(this._defaultTextFormat)
         {
            this._textField.defaultTextFormat = this._defaultTextFormat;
         }
         TextHelper.font(this._textField,"SimSun");
         TextHelper.letterSpacing(this._textField,param1);
         TextHelper.align(this._textField,this._align);
         TextHelper.leading(this._textField,param2);
         TextHelper.color(this._textField,this._color);
         TextHelper.bold(this._textField,this._bold);
      }
      
      override public function get width() : Number
      {
         return this._textField.textWidth;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
      }
      
      override public function get height() : Number
      {
         var _loc1_:Number = NaN;
         if(null != this._textField)
         {
            _loc1_ = this._textField.height;
         }
         return _loc1_;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._textField != null)
         {
            this._textField.height = param1;
         }
      }
      
      public function get superWidth() : Number
      {
         return super.width;
      }
      
      public function get numLines() : int
      {
         return this._textField.numLines;
      }
      
      public function set align(param1:String) : void
      {
         TextHelper.align(this._textField,param1);
         this._align = param1;
      }
      
      override public function set filters(param1:Array) : void
      {
         this._filters = param1;
      }
      
      public function set autoSize(param1:String) : void
      {
         this._autoSize = param1;
      }
      
      public function get textFiled() : TextField
      {
         return this._textField;
      }
      
      public function set color(param1:uint) : void
      {
         this._color = param1;
      }
      
      public function get htmlText() : String
      {
         return this._textField.htmlText;
      }
      
      public function set maxHeight(param1:Number) : void
      {
         this._maxHeight = param1;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         this._multiline = param1;
      }
      
      public function set bold(param1:Boolean) : void
      {
         this._bold = param1;
      }
      
      public function set htmlText(param1:String) : void
      {
         this._htmlTxt = param1;
         this.dispose();
         this.initTxt();
         this._textField.htmlText = param1;
         this.height = this._textField.textHeight + 14;
         this.checkVip();
         this.checkImg();
         if(this._textField.numLines == 1)
         {
            if(this._textField.textHeight + 10 > this._maxHeight)
            {
               this.height = this._maxHeight;
            }
            else
            {
               this.height = this._textField.textHeight + 10;
            }
         }
         else if(this._textField.textHeight + 14 > this._maxHeight)
         {
            this.height = this._maxHeight;
         }
         else
         {
            this.height = this._textField.textHeight + 14;
         }
         addChildAt(this._textField,0);
      }
      
      private function checkVip() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc1_:String = this._textField.text;
         var _loc2_:Array = [];
         while((_loc4_ = REG_VIP.exec(_loc1_)) != null)
         {
            _loc4_.index -= _loc3_ * 10;
            _loc2_[_loc2_.length] = _loc4_;
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            this._htmlTxt = this._htmlTxt.replace(REG_VIP,"　 ");
            this._textField.htmlText = this._htmlTxt;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               if((_loc5_ = _loc2_[_loc6_]) != null)
               {
                  this.CaculatVipContent(_loc5_.index,_loc5_[0]);
               }
               _loc6_++;
            }
         }
      }
      
      private function CaculatVipContent(param1:int, param2:String) : void
      {
         var _loc3_:String = param2.slice(5,param2.length - 6);
         var _loc4_:Sprite;
         if((_loc4_ = Reflection.createMovieClipInstance("VipIconUI") as Sprite) == null)
         {
            return;
         }
         var _loc5_:Rectangle;
         if((_loc5_ = this._textField.getCharBoundaries(param1)) != null)
         {
            _loc4_.x = _loc5_.x;
            _loc4_.y = _loc5_.y - 4;
            addChild(_loc4_);
         }
      }
      
      private function checkImg() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc1_:String = this._textField.text;
         var _loc2_:Array = [];
         while((_loc4_ = regImg.exec(_loc1_)) != null)
         {
            _loc4_.index -= _loc3_ * 1;
            _loc2_[_loc2_.length] = _loc4_;
            _loc3_++;
         }
         if(_loc2_.length > 0)
         {
            this._htmlTxt = this._htmlTxt.replace(regImg,"　 ");
            this._textField.htmlText = this._htmlTxt;
            _loc6_ = 0;
            while(_loc6_ < _loc2_.length)
            {
               if((_loc5_ = _loc2_[_loc6_]) != null)
               {
                  this.CaculatContent(_loc5_.index,_loc5_[0]);
               }
               _loc6_++;
            }
         }
      }
      
      private function CaculatContent(param1:int, param2:String) : void
      {
         var _loc6_:Number = NaN;
         var _loc3_:String = param2.slice(1,param2.length);
         var _loc4_:Sprite;
         if((_loc4_ = Reflection.createMovieClipInstance("Movie" + int(_loc3_)) as Sprite) == null)
         {
            return;
         }
         var _loc5_:Rectangle;
         if((_loc5_ = this._textField.getCharBoundaries(param1)) != null)
         {
            _loc4_.scaleX = 0.5;
            _loc4_.scaleY = 0.5;
            _loc4_.x = _loc5_.x;
            _loc4_.y = _loc5_.y - 6;
            if((_loc6_ = _loc5_.y + _loc5_.height) <= this._maxHeight)
            {
               addChild(_loc4_);
            }
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:DisplayObject = null;
         if(this._textField != null)
         {
            this._textField.mouseEnabled = false;
            if(this._textField.parent != null)
            {
               this._textField.parent.removeChild(this._textField);
            }
         }
         var _loc1_:int = numChildren - 1;
         while(_loc1_ > -1)
         {
            _loc2_ = this.removeChildAt(_loc1_);
            if(_loc2_.parent != null)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc1_--;
         }
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         this._defaultTextFormat = param1;
      }
      
      public function copyTextStyle(param1:TextField) : void
      {
         this.autoSize = param1.autoSize;
         this.multiline = param1.multiline;
         this.filters = param1.filters;
         this.defaultTextFormat = param1.defaultTextFormat;
         var _loc2_:Array = param1.htmlText.match(/#[\d\w]{6}/g);
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            this.color = parseInt(_loc2_[0].substr(1),16);
         }
      }
   }
}
