package com.QQ.angel.plugs.Login.ui2.components
{
   import flash.display.*;
   import flash.events.*;
   import flash.filters.ColorMatrixFilter;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.plugs.Login.ui2.components.PageNavigation")]
   public class PageNavigation extends MovieClip
   {
       
      
      private var txt:Array;
      
      private var txtWidth:Number = 55;
      
      private var txtGap:Number = 0;
      
      private var buttonGap:Number = 8;
      
      private var buttonWidth:Number = 20;
      
      private var index:int = 0;
      
      private var w:Number = 0;
      
      private var _total:uint = 0;
      
      private var _pageSize:uint = 0;
      
      private var _num:uint = 0;
      
      private var _page:uint = 0;
      
      private var _left:SimpleButton;
      
      private var _right:SimpleButton;
      
      public function PageNavigation()
      {
         txt = [];
         init();
         total = 0;
         page = 1;
         num = 0;
         super();
      }
      
      private function init() : void
      {
         addChild(left);
         addChild(right);
         left.addEventListener(MouseEvent.CLICK,click);
         right.addEventListener(MouseEvent.CLICK,click);
         draw();
      }
      
      private function click(param1:MouseEvent) : void
      {
         showText(param1.currentTarget == left ? index - num : index + num);
      }
      
      protected function draw() : void
      {
         showText(index);
      }
      
      override public function set width(param1:Number) : void
      {
         w = param1;
         draw();
      }
      
      private function showText(param1:int) : void
      {
         var _loc4_:PageNavigationPageText = null;
         index = Math.min(Math.max(param1,0),Math.max(0,pageTotal - num));
         removeAllText();
         var _loc2_:Number = int(buttonWidth + buttonGap);
         var _loc3_:uint = 0;
         while(_loc3_ < num)
         {
            if(txt[_loc3_] == null)
            {
               txt[_loc3_] = new PageNavigationPageText();
            }
            (_loc4_ = txt[_loc3_]).addEventListener(MouseEvent.CLICK,tClick);
            addChild(_loc4_);
            _loc4_.x = _loc2_;
            _loc4_.y = 0;
            _loc4_.text = (index + _loc3_ + 1).toString();
            _loc4_.selected = index + _loc3_ + 1 == page;
            _loc4_.enabled = _loc3_ <= pageTotal - 1;
            _loc2_ += txtWidth + txtGap;
            _loc2_ = int(_loc2_);
            _loc3_++;
         }
         _loc2_ -= txtGap;
         _loc2_ += buttonGap;
         _loc2_ = int(_loc2_);
         right.x = _loc2_;
         setEnabled(left,index > 0);
         setEnabled(right,index < pageTotal - num);
         this.graphics.clear();
         this.graphics.beginFill(0,0);
         this.graphics.drawRect(0,0,width,height);
         this.graphics.endFill();
      }
      
      private function tClick(param1:MouseEvent) : void
      {
         var _loc2_:PageNavigationPageText = param1.currentTarget as PageNavigationPageText;
         if(page == int(_loc2_.text))
         {
            return;
         }
         page = int(_loc2_.text);
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function get range() : Array
      {
         return [(page - 1) * pageSize + 1,page * pageSize];
      }
      
      private function removeAllText() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < txt.length)
         {
            if(txt[_loc1_].parent)
            {
               txt[_loc1_].parent.removeChild(txt[_loc1_]);
            }
            _loc1_++;
         }
      }
      
      public function get total() : uint
      {
         return _total;
      }
      
      public function set total(param1:uint) : void
      {
         _total = param1;
         page = page;
      }
      
      public function get pageSize() : uint
      {
         return _pageSize;
      }
      
      public function set pageSize(param1:uint) : void
      {
         _pageSize = param1;
         page = page;
      }
      
      private function get pageTotal() : uint
      {
         return Math.max(Math.ceil(total / pageSize),1);
      }
      
      public function get num() : uint
      {
         return _num;
      }
      
      public function set num(param1:uint) : void
      {
         _num = param1;
         draw();
      }
      
      public function get page() : uint
      {
         return _page;
      }
      
      public function set page(param1:uint) : void
      {
         _page = Math.min(Math.max(1,param1),pageTotal);
         draw();
      }
      
      public function get left() : SimpleButton
      {
         if(!_left)
         {
            _left = new PageNavigationLeftButton();
         }
         return _left;
      }
      
      public function get right() : SimpleButton
      {
         if(!_right)
         {
            _right = new PageNavigationRightButton();
         }
         return _right;
      }
      
      private function setEnabled(param1:DisplayObject, param2:Boolean) : void
      {
         param1.filters = param2 ? [] : [new ColorMatrixFilter([0.1,0.6,0,0,0,0.1,0.6,0,0,0,0.1,0.6,0,0,0,0,0,0,1,0])];
         if(param1 is InteractiveObject)
         {
            InteractiveObject(param1).mouseEnabled = param2;
         }
         if(param1 is DisplayObjectContainer)
         {
            DisplayObjectContainer(param1).mouseChildren = param2;
         }
      }
      
      public function dispose() : void
      {
         var _loc2_:PageNavigationPageText = null;
         var _loc1_:uint = 0;
         while(_loc1_ < txt.length)
         {
            _loc2_ = txt[_loc1_];
            _loc2_.removeEventListener(MouseEvent.CLICK,tClick);
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
            _loc2_.dispose();
            _loc1_++;
         }
         txt = null;
         left.removeEventListener(MouseEvent.CLICK,click);
         right.removeEventListener(MouseEvent.CLICK,click);
         removeChild(left);
         removeChild(right);
      }
   }
}
