package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IBubble;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class Bubble extends Sprite implements IBubble
   {
      
      public static const TEXT_MAX_WIDTH:int = 150;
       
      
      private var _message:TextField;
      
      private var _messageBG:Shape;
      
      private var _content:DisplayObject;
      
      private var _skin:IBubbleSkin;
      
      private var _container:DisplayObjectContainer;
      
      public function Bubble(param1:IBubbleSkin = null)
      {
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.setSkin(param1);
         this.initMessage();
      }
      
      public function setContainer(param1:DisplayObjectContainer) : void
      {
         this._container = param1;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this._container == null)
         {
            return;
         }
         if(param1 && !this._container.contains(this))
         {
            this._container.addChild(this);
         }
         else if(!param1 && this._container.contains(this))
         {
            this._container.removeChild(this);
         }
      }
      
      public function getVisible() : Boolean
      {
         if(this._container == null)
         {
            return false;
         }
         return this._container.contains(this);
      }
      
      public function dispose() : void
      {
         this.clearContent();
         if(this._message != null)
         {
            removeChild(this._message);
            this._message = null;
         }
         if(this._content != null)
         {
            removeChild(this._content);
            this._content = null;
         }
         this.setVisible(false);
         this._container = null;
      }
      
      public function setContent(param1:*) : void
      {
         var _loc2_:Rectangle = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         if(param1 == null)
         {
            return;
         }
         this.clearContent();
         if(param1 is String)
         {
            if((_loc5_ = param1 as String).substr(0,6) == "#text#")
            {
               _loc5_ = _loc5_.substr(6);
               this._message.text = _loc5_;
            }
            else
            {
               this._message.htmlText = _loc5_;
            }
            _loc3_ = this._message.textWidth + this._skin.borderWidth;
            _loc4_ = this._message.textHeight + this._skin.borderHeight;
            this._skin.setSize(_loc3_,_loc4_);
            _loc2_ = this._skin.contentRect;
            _loc2_ = this._skin.contentRect;
            this._message.x = _loc2_.x + (this._skin.borderWidth >> 1) - 2;
            this._message.y = _loc2_.y + (this._skin.borderHeight >> 1) - 2;
         }
         else if(param1 is Sprite)
         {
            this._content = param1 as Sprite;
            addChild(this._content);
            _loc3_ = this._content.width + this._skin.borderWidth;
            _loc4_ = this._content.height + this._skin.borderHeight;
            this._skin.setSize(_loc3_,_loc4_);
            _loc2_ = this._skin.contentRect;
            _loc2_ = this._skin.contentRect;
            this._content.x = _loc2_.x + (this._skin.borderWidth >> 1);
            this._content.y = _loc2_.y + (this._skin.borderHeight >> 1);
         }
      }
      
      public function clearContent() : void
      {
         this._message.text = "";
         if(this._content != null)
         {
            removeChild(this._content);
            this._content = null;
         }
      }
      
      public function getType() : int
      {
         return 0;
      }
      
      public function setSkin(param1:*) : void
      {
         if(this._skin != null)
         {
            removeChild(this._skin.display);
            this._skin = null;
         }
         if(param1 == null)
         {
            this._skin = new BubbleRoundRectWithArrowSkin();
         }
         else
         {
            this._skin = param1;
         }
         addChildAt(this._skin.display,0);
      }
      
      public function onRender(param1:Event) : void
      {
      }
      
      public function hasRender() : Boolean
      {
         return false;
      }
      
      public function get display() : DisplayObject
      {
         return this;
      }
      
      public function unload() : void
      {
         this.dispose();
      }
      
      override public function get x() : Number
      {
         if(this._skin != null)
         {
            return super.x + this._skin.contentRect.x;
         }
         return super.x;
      }
      
      override public function get y() : Number
      {
         if(this._skin != null)
         {
            return super.y + this._skin.contentRect.y;
         }
         return super.y;
      }
      
      override public function get width() : Number
      {
         if(this._skin != null)
         {
            return this._skin.contentRect.width - this._skin.contentRect.x;
         }
         return 0;
      }
      
      override public function get height() : Number
      {
         if(this._skin != null)
         {
            return this._skin.contentRect.height - this._skin.contentRect.y;
         }
         return 0;
      }
      
      private function initMessage() : void
      {
         this._messageBG = new Shape();
         addChild(this._messageBG);
         this._message = new TextField();
         this._message.selectable = false;
         this._message.multiline = true;
         this._message.wordWrap = true;
         this._message.autoSize = TextFieldAutoSize.LEFT;
         this._message.width = TEXT_MAX_WIDTH;
         var _loc1_:TextFormat = new TextFormat("SimSun");
         _loc1_.color = 0;
         _loc1_.size = 12;
         _loc1_.underline = false;
         _loc1_.align = TextFormatAlign.LEFT;
         this._message.defaultTextFormat = _loc1_;
         addChild(this._message);
      }
   }
}
