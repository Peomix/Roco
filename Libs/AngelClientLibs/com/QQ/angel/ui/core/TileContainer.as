package com.QQ.angel.ui.core
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class TileContainer extends UIBase
   {
       
      
      private var _paddingH:Number = 0;
      
      private var _paddingV:Number = 0;
      
      private var _columnCount:uint = 2147483647;
      
      private var _rowCount:uint = 2147483647;
      
      private var _autoVSize:Boolean = false;
      
      private var _scrollY:int = 0;
      
      private var _scrollX:int = 0;
      
      private var layoutMap:Dictionary;
      
      public var childBoundsSize:Boolean;
      
      private var _isShowBroad:Boolean = false;
      
      public function TileContainer(param1:Boolean = true)
      {
         this.layoutMap = new Dictionary(true);
         super();
         this.childBoundsSize = param1;
         this.init();
      }
      
      private function init() : void
      {
         width = int.MAX_VALUE;
      }
      
      public function removeAllChildren() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = numChildren;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            this.removeItemAt(0);
            _loc1_++;
         }
      }
      
      override protected function onDrawUI() : void
      {
         var _loc2_:int = 0;
         var _loc3_:DisplayObject = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         super.onDrawUI();
         if(this.isShowBroad)
         {
            graphics.clear();
            graphics.lineStyle(1);
            graphics.drawRect(0,0,_width,_heigth);
         }
         var _loc1_:Point = new Point();
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = 0;
         while(_loc2_ < numChildren)
         {
            _loc6_ = getChildAt(_loc2_);
            _loc7_ = this.getItemLayout(_loc6_);
            _loc3_ = _loc6_;
            if(_loc5_ >= this._rowCount && this._autoVSize == false)
            {
               _loc3_.visible = false;
            }
            else
            {
               _loc3_.visible = true;
            }
            _loc3_.x = _loc1_.x;
            _loc3_.y = _loc1_.y;
            _loc1_.x += _loc7_.width + _loc7_.paddingH;
            _loc4_++;
            if(_loc2_ + 1 < numChildren)
            {
               if((_loc8_ = this.getItemLayout(getChildAt(_loc2_ + 1))).width + _loc8_.paddingH + _loc1_.x > width || _loc4_ >= this._columnCount)
               {
                  _loc1_.y += _loc7_.height + _loc7_.paddingV;
                  _loc1_.x = 0;
                  _loc4_ = 0;
                  _loc5_++;
               }
            }
            _loc2_++;
         }
         if(this._autoVSize)
         {
            _heigth = contentHeight;
         }
      }
      
      public function get columnCount() : uint
      {
         return this._columnCount;
      }
      
      public function set columnCount(param1:uint) : void
      {
         this._columnCount = param1;
         commitChange();
      }
      
      public function get rowCount() : uint
      {
         return this._rowCount;
      }
      
      public function set rowCount(param1:uint) : void
      {
         this._rowCount = param1;
         commitChange();
      }
      
      override public function removeChild(param1:DisplayObject) : DisplayObject
      {
         delete this.layoutMap[param1];
         return super.removeChild(param1);
      }
      
      public function removeItemAt(param1:int) : void
      {
         this.removeItem(getChildAt(param1));
      }
      
      public function removeItem(param1:DisplayObject) : void
      {
         delete this.layoutMap[param1];
         this.removeChild(param1);
         commitChange();
      }
      
      public function addItem(param1:DisplayObject) : void
      {
         this.addItem2(param1);
      }
      
      public function addItem2(param1:DisplayObject, param2:Object = null) : void
      {
         if(param2)
         {
            this.layoutMap[param1] = param2;
         }
         else
         {
            this.layoutMap[param1] = new Object();
         }
         addChild(param1);
         commitChange();
      }
      
      private function getItemLayout(param1:DisplayObject) : Object
      {
         var _loc4_:Rectangle = null;
         var _loc2_:Object = new Object();
         var _loc3_:Object = this.layoutMap[param1];
         if(this.childBoundsSize)
         {
            _loc4_ = param1.getBounds(this);
            _loc2_.width = _loc3_.width || _loc4_.width;
            _loc2_.height = _loc3_.height || _loc4_.height;
         }
         else
         {
            _loc2_.width = _loc3_.width || param1.width;
            _loc2_.height = _loc3_.height || param1.height;
         }
         _loc2_.paddingV = _loc3_.paddingV || this.paddingV;
         _loc2_.paddingH = _loc3_.paddingH || this.paddingH;
         return _loc2_;
      }
      
      override public function get height() : Number
      {
         if(this.autoVSize)
         {
            return contentHeight;
         }
         return super.height;
      }
      
      public function get paddingH() : Number
      {
         return this._paddingH;
      }
      
      public function set paddingH(param1:Number) : void
      {
         this._paddingH = param1;
         commitChange();
      }
      
      public function get paddingV() : Number
      {
         return this._paddingV;
      }
      
      public function set paddingV(param1:Number) : void
      {
         this._paddingV = param1;
         commitChange();
      }
      
      public function get autoVSize() : Boolean
      {
         return this._autoVSize;
      }
      
      public function set autoVSize(param1:Boolean) : void
      {
         if(this._autoVSize == param1)
         {
            return;
         }
         this._autoVSize = param1;
         commitChange();
      }
      
      public function get isShowBroad() : Boolean
      {
         return this._isShowBroad;
      }
      
      public function set isShowBroad(param1:Boolean) : void
      {
         this._isShowBroad = param1;
         commitChange();
      }
   }
}
