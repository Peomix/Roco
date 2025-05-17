package com.tencent.fge.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public class SWFUtil
   {
      
      public function SWFUtil()
      {
         super();
      }
      
      public static function clearChildren(param1:DisplayObjectContainer, param2:int = 0) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         var _loc3_:int = param1.numChildren;
         var _loc4_:int = _loc3_ - 1;
         while(_loc4_ >= param2)
         {
            param1.removeChildAt(_loc4_);
            _loc4_--;
         }
         return param1.numChildren == 0;
      }
      
      public static function replaceDisplayObject(param1:DisplayObject, param2:DisplayObject, param3:Boolean = false) : void
      {
         var _loc4_:int = 0;
         var _loc5_:DisplayObjectContainer = null;
         _loc5_ = param1.parent;
         if(_loc5_)
         {
            _loc4_ = _loc5_.getChildIndex(param1);
            param2.x = param1.x;
            param2.y = param1.y;
            if(param3)
            {
               param2.width = param1.width;
               param2.height = param1.height;
            }
            _loc5_.removeChild(param1);
            _loc5_.addChildAt(param2,_loc4_);
         }
      }
      
      public static function safeAddChild(param1:DisplayObjectContainer, param2:DisplayObject) : void
      {
         if(null != param1 && null != param2)
         {
            if(!param1.contains(param2))
            {
               param1.addChild(param2);
            }
         }
      }
      
      public static function safeRemoveChild(param1:DisplayObjectContainer, param2:DisplayObject) : void
      {
         if(null != param1 && null != param2)
         {
            if(param1 == param2.parent)
            {
               param1.removeChild(param2);
            }
         }
      }
      
      public static function getMovieClipChildren(param1:MovieClip) : Array
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:int = 0;
         var _loc6_:DisplayObjectContainer = null;
         var _loc7_:MovieClip = null;
         var _loc2_:Array = new Array();
         _loc2_.push(param1);
         var _loc3_:Array = new Array();
         _loc3_.push(param1);
         while(_loc3_.length > 0)
         {
            _loc4_ = _loc3_.pop();
            _loc5_ = 0;
            while(_loc5_ < _loc4_.numChildren)
            {
               _loc6_ = _loc4_.getChildAt(_loc5_) as DisplayObjectContainer;
               _loc7_ = _loc4_.getChildAt(_loc5_) as MovieClip;
               if(_loc6_ != null)
               {
                  _loc3_.push(_loc6_);
               }
               if(_loc7_ != null)
               {
                  _loc2_.push(_loc7_);
               }
               _loc5_++;
            }
         }
         _loc3_.length = 0;
         return _loc2_;
      }
      
      public static function killAllAnimation(param1:MovieClip) : void
      {
         var _loc4_:MovieClip = null;
         var _loc2_:Array = getMovieClipChildren(param1);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc4_.stop();
            _loc3_++;
         }
      }
      
      public static function clearDisplayObject(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            _loc3_ = param1.numChildren;
            _loc4_ = _loc3_ - 1;
            while(_loc4_ >= 0)
            {
               param1.removeChildAt(_loc4_);
               _loc4_--;
            }
            if(param2 && Boolean(param1.parent))
            {
               param1.parent.removeChild(param1);
            }
         }
      }
      
      public static function applyVisualProperty(param1:Object, param2:DisplayObject) : void
      {
         if(param1.hasOwnProperty("alpha"))
         {
            param2.alpha = param1.alpha;
         }
         if(param1.hasOwnProperty("x"))
         {
            param2.x = param1.x;
         }
         if(param1.hasOwnProperty("y"))
         {
            param2.y = param1.y;
         }
         if(param1.hasOwnProperty("scaleX"))
         {
            param2.scaleX = param1.scaleX;
         }
         if(param1.hasOwnProperty("scaleY"))
         {
            param2.scaleY = param1.scaleY;
         }
         if(param1.hasOwnProperty("width"))
         {
            param2.width = param1.width;
         }
         if(param1.hasOwnProperty("height"))
         {
            param2.height = param1.height;
         }
         if(param1.hasOwnProperty("rotation"))
         {
            param2.rotation = param1.rotation;
         }
         if(param1.hasOwnProperty("visible"))
         {
            param2.visible = param1.visible;
         }
      }
   }
}

