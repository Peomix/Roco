package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.ui.core.textfield.ImageTextField;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public class TalkBubble extends Sprite implements IBubble
   {
      
      private static const TEXT_MAX_WIDTH:int = 150;
      
      private static const TEXT_MAX_HEIGHT:int = 140;
       
      
      private var _message:ImageTextField;
      
      private var _messageBG:Shape;
      
      private var _content:DisplayObject;
      
      private var _skin:IBubbleSkin;
      
      private var _container:DisplayObjectContainer;
      
      public function TalkBubble(param1:IBubbleSkin = null)
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
            _loc5_ = param1 as String;
            this._message.htmlText = _loc5_;
            if(this._message.width > TEXT_MAX_WIDTH)
            {
               _loc3_ = TEXT_MAX_WIDTH + this._skin.borderWidth;
            }
            else
            {
               _loc3_ = this._message.width + this._skin.borderWidth;
            }
            if(this._message.height > TEXT_MAX_HEIGHT)
            {
               _loc4_ = TEXT_MAX_HEIGHT + this._skin.borderHeight;
            }
            else
            {
               _loc4_ = this._message.height + this._skin.borderHeight;
            }
            this._skin.setSize(_loc3_,_loc4_);
            _loc2_ = this._skin.contentRect;
            _loc2_ = this._skin.contentRect;
            this._message.x = _loc2_.x + (this._skin.borderWidth >> 1) - 2;
            this._message.y = _loc2_.y + (this._skin.borderHeight >> 1) + 8;
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
         this._message.htmlText = "";
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
         this._message = new ImageTextField();
         this._message.width = TEXT_MAX_WIDTH;
         this._message.maxHeight = TEXT_MAX_HEIGHT;
         addChild(this._message);
      }
   }
}
