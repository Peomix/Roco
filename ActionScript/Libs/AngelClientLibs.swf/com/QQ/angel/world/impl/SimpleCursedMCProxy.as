package com.QQ.angel.world.impl
{
   import com.QQ.angel.api.world.role.ICursedDisplay;
   import com.QQ.angel.utils.LocalFile;
   import flash.display.DisplayObject;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SimpleCursedMCProxy extends EventDispatcher implements ICursedDisplay
   {
      
      protected var target:MovieClip;
      
      protected var currentLabel:String = "1";
      
      protected var allLabels:Array;
      
      public function SimpleCursedMCProxy(param1:MovieClip)
      {
         super();
         this.target = param1;
         this.target.stop();
         var _loc2_:Array = param1.currentLabels;
         this.allLabels = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            this.allLabels.push((_loc2_[_loc3_] as FrameLabel).name);
            _loc3_++;
         }
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         var _loc3_:String = param1 + "-" + param2;
         if(this.target == null || this.currentLabel == _loc3_)
         {
            return;
         }
         if(this.allLabels.indexOf(_loc3_) != -1)
         {
            this.target.gotoAndStop(_loc3_);
         }
         else
         {
            _loc3_ = "0-" + param2;
            this.target.gotoAndStop(_loc3_);
         }
         this.currentLabel = _loc3_;
      }
      
      public function hasRender() : Boolean
      {
         return false;
      }
      
      public function get visible() : Boolean
      {
         if(this.target != null)
         {
            this.target.visible;
         }
         return false;
      }
      
      public function onRender(param1:Event) : void
      {
      }
      
      public function set visible(param1:Boolean) : void
      {
         if(this.target != null)
         {
            this.target.visible = param1;
         }
      }
      
      public function get x() : Number
      {
         if(this.target != null)
         {
            return this.target.x;
         }
         return 0;
      }
      
      public function set x(param1:Number) : void
      {
         if(this.target != null)
         {
            this.target.x = param1;
         }
      }
      
      public function get y() : Number
      {
         if(this.target != null)
         {
            return this.target.y;
         }
         return 0;
      }
      
      public function set y(param1:Number) : void
      {
         if(this.target != null)
         {
            this.target.y = param1;
         }
      }
      
      public function get width() : Number
      {
         if(this.target != null)
         {
            return this.target.width;
         }
         return 0;
      }
      
      public function get height() : Number
      {
         if(this.target != null)
         {
            return this.target.height;
         }
         return 0;
      }
      
      public function get mouseX() : Number
      {
         if(this.target != null)
         {
            return this.target.mouseX;
         }
         return 0;
      }
      
      public function get mouseY() : Number
      {
         if(this.target != null)
         {
            return this.target.mouseY;
         }
         return 0;
      }
      
      public function get display() : DisplayObject
      {
         return this.target;
      }
      
      public function hitTestPoint(param1:Number, param2:Number, param3:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function hitTestObject(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public function addChild(param1:DisplayObject) : DisplayObject
      {
         return null;
      }
      
      public function addChildAt(param1:DisplayObject, param2:int) : DisplayObject
      {
         return null;
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public function getChildAt(param1:int) : DisplayObject
      {
         return null;
      }
      
      public function getChildByName(param1:String) : DisplayObject
      {
         return null;
      }
      
      public function getChildIndex(param1:DisplayObject) : int
      {
         return 0;
      }
      
      public function removeChild(param1:DisplayObject) : DisplayObject
      {
         return null;
      }
      
      public function removeChildAt(param1:int) : DisplayObject
      {
         return null;
      }
      
      public function setChildIndex(param1:DisplayObject, param2:int) : void
      {
      }
      
      public function swapChildren(param1:DisplayObject, param2:DisplayObject) : void
      {
      }
      
      public function swapChildrenAt(param1:int, param2:int) : void
      {
      }
      
      public function unload() : void
      {
         if(this.target != null)
         {
            LocalFile.STOPContainer(this.target);
         }
      }
   }
}

