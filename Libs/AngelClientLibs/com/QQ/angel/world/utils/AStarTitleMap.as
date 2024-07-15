package com.QQ.angel.world.utils
{
   import com.QQ.angel.common.__global;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class AStarTitleMap implements IMapTileModel
   {
       
      
      private var __mapWidth:Number = 960;
      
      private var __mapHeight:Number = 560;
      
      private var __titleWidth:Number = 10;
      
      private var __titleHeight:Number = 10;
      
      private var __title_DD:Number = 0.1;
      
      private var __titleMapW:int = 96;
      
      private var __titleMapH:int = 56;
      
      private var __wallSprite:DisplayObjectContainer;
      
      private var __roadStore:Array;
      
      private var __halfTW:Number;
      
      private var __halfTH:Number;
      
      public var roadLine:Sprite;
      
      public var myRoot:Sprite;
      
      public var walkAreaAsset:Class;
      
      public function AStarTitleMap(param1:Class, param2:Array = null, param3:Sprite = null)
      {
         super();
         this.__halfTW = this.__titleWidth * 0.5;
         this.__halfTH = this.__titleHeight * 0.5;
         this.myRoot = param3;
         if(param2 == null)
         {
            this.readyMap(new param1(this.__titleMapW,this.__titleMapH));
         }
         else
         {
            this.__roadStore = param2;
         }
      }
      
      private function addToStageHandler(param1:Event) : void
      {
         this.myRoot.removeEventListener(Event.ADDED_TO_STAGE,this.addToStageHandler);
         this.readyMap2(new this.walkAreaAsset());
         this.walkAreaAsset = null;
      }
      
      private function readyMap2(param1:Sprite) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.__titleMapW = Math.ceil(this.__mapWidth / this.__titleWidth);
         this.__titleMapH = Math.ceil(this.__mapHeight / this.__titleHeight);
         this.__roadStore = [];
         this.myRoot.addChild(this.__wallSprite = param1);
         var _loc2_:int = 0;
         while(_loc2_ < this.__titleMapW)
         {
            _loc3_ = this.__roadStore[_loc2_] = [];
            _loc4_ = 0;
            while(_loc4_ < this.__titleMapH)
            {
               _loc5_ = _loc2_ * this.__titleWidth;
               _loc6_ = _loc4_ * this.__titleHeight;
               if(this.checkHitTest(_loc5_,_loc6_))
               {
                  _loc3_[_loc4_] = 1;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         this.myRoot.removeChild(this.__wallSprite);
      }
      
      private function readyMap(param1:BitmapData) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         this.__roadStore = [];
         var _loc2_:int = 0;
         while(_loc2_ < this.__titleMapW)
         {
            _loc3_ = this.__roadStore[_loc2_] = [];
            _loc4_ = 0;
            while(_loc4_ < this.__titleMapH)
            {
               if(param1.getPixel32(_loc2_,_loc4_) >> 24)
               {
                  _loc3_[_loc4_] = 1;
               }
               _loc4_++;
            }
            _loc2_++;
         }
         param1.dispose();
         param1 = null;
      }
      
      private function checkHitTest(param1:Number, param2:Number) : Boolean
      {
         if(this.__wallSprite == null)
         {
            return false;
         }
         if(this.__wallSprite.hitTestPoint(param1,param2,true))
         {
            return true;
         }
         var _loc3_:Number = param1 + this.__titleWidth;
         var _loc4_:Number = param2 + this.__titleHeight;
         if(this.__wallSprite.hitTestPoint(_loc3_,param2,true))
         {
            return true;
         }
         if(this.__wallSprite.hitTestPoint(param1,_loc4_,true))
         {
            return true;
         }
         if(this.__wallSprite.hitTestPoint(_loc3_,_loc4_,true))
         {
            return true;
         }
         if(this.__wallSprite.hitTestPoint(param1 + this.__halfTW,param2 + this.__halfTH,true))
         {
            return true;
         }
         return false;
      }
      
      private function createTitleMc() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.lineStyle(1,16711680);
         _loc1_.graphics.drawRect(0,0,this.__titleWidth,this.__titleHeight);
         return _loc1_;
      }
      
      public function isWalkable(param1:int, param2:int) : Boolean
      {
         if(this.__roadStore == null)
         {
            return false;
         }
         return this.__roadStore[param1][param2] == 1;
      }
      
      public function isWalkable2(param1:Point) : Boolean
      {
         var _loc2_:Point = this.toTilePos(param1,true);
         return this.isWalkable(_loc2_.x,_loc2_.y);
      }
      
      public function isBlock(param1:int, param2:int, param3:int, param4:int) : Boolean
      {
         if(param3 < 0 || param3 >= this.__roadStore.length)
         {
            return false;
         }
         if(param4 < 0 || param4 >= (this.__roadStore[param3] as Array).length)
         {
            return false;
         }
         return this.__roadStore[param3][param4] == 1;
      }
      
      public function getMapData() : Array
      {
         return this.__roadStore;
      }
      
      public function getWidth() : int
      {
         return this.__titleMapW;
      }
      
      public function getHeight() : int
      {
         return this.__titleMapH;
      }
      
      public function compressArrPoints(param1:Array) : Array
      {
         var _loc7_:Point = null;
         var _loc8_:int = 0;
         var _loc2_:int = int(param1.length);
         var _loc3_:Array = [];
         var _loc4_:Point = this.toMapPos(param1[0]);
         _loc3_.push(_loc4_);
         var _loc5_:int = _loc2_ - 2;
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_ - 1)
         {
            _loc8_ = _loc5_;
            while(_loc8_ > _loc6_ + 1)
            {
               if(param1[_loc8_] is Array)
               {
                  _loc7_ = param1[_loc8_] = this.toMapPos(param1[_loc8_]);
               }
               else
               {
                  _loc7_ = param1[_loc8_];
               }
               if(this.isLineConnected(_loc4_,_loc7_))
               {
                  break;
               }
               _loc8_--;
            }
            if(param1[_loc8_] is Array)
            {
               _loc7_ = param1[_loc8_] = this.toMapPos(param1[_loc8_]);
            }
            else
            {
               _loc7_ = param1[_loc8_];
            }
            _loc3_.push(_loc7_);
            _loc4_ = _loc7_;
            _loc5_ = _loc2_ - 1;
            _loc6_ = _loc8_;
         }
         return _loc3_;
      }
      
      public function isLineConnected(param1:Point, param2:Point, param3:int = 1) : Boolean
      {
         var _loc9_:Point = null;
         if(param3 != 1)
         {
            param1 = this.toMapPosXY(param1.x,param1.y);
            param2 = this.toMapPosXY(param2.x,param2.y);
         }
         var _loc4_:Number = Point.distance(param1,param2);
         var _loc5_:Number = int(_loc4_ * this.__title_DD);
         var _loc6_:Number = (param2.x - param1.x) / _loc5_;
         var _loc7_:Number = (param2.y - param1.y) / _loc5_;
         var _loc8_:Point = param1.clone();
         while(_loc5_-- > 0)
         {
            _loc8_.x += _loc6_;
            _loc8_.y += _loc7_;
            _loc9_ = this.toTilePos(_loc8_,true);
            if(!this.isWalkable(_loc9_.x,_loc9_.y))
            {
               return false;
            }
         }
         return true;
      }
      
      public function toMapPos(param1:Array) : Point
      {
         return this.toMapPosXY(param1[0],param1[1]);
      }
      
      public function toMapPosXY(param1:Number, param2:Number) : Point
      {
         return new Point(param1 * this.__titleWidth + this.__halfTW,param2 * this.__titleHeight + this.__halfTH);
      }
      
      public function toTilePos(param1:Point, param2:Boolean = false) : Point
      {
         var _loc3_:Point = null;
         if(param2)
         {
            _loc3_ = new Point();
         }
         else
         {
            _loc3_ = param1;
         }
         _loc3_.x = int((param1.x - this.__halfTW) * this.__title_DD + 0.5);
         _loc3_.y = int((param1.y - this.__halfTH) * this.__title_DD + 0.5);
         return _loc3_;
      }
      
      public function screenToWorldPos(param1:Point, param2:Boolean = false) : Point
      {
         var _loc3_:Point = null;
         if(param2)
         {
            _loc3_ = new Point();
         }
         else
         {
            _loc3_ = param1;
         }
         _loc3_.x = param1.x + __global.SysAPI.getWorldAPI().getSceneAPI().getSceneLogic().getContainer().x;
         _loc3_.y = param1.y + __global.SysAPI.getWorldAPI().getSceneAPI().getSceneLogic().getContainer().y;
         return _loc3_;
      }
      
      public function arrToLocations(param1:Array, param2:Point = null, param3:Boolean = false) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:int = int(param1.length);
         var _loc6_:Point = param2;
         if(param3)
         {
            this.roadLine.graphics.clear();
            this.roadLine.graphics.lineStyle(3,16711680,0.3);
            this.roadLine.graphics.moveTo(_loc6_.x,_loc6_.y);
         }
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = param1[_loc7_];
            if(param3)
            {
               this.roadLine.graphics.lineTo(_loc6_.x,_loc6_.y);
            }
            _loc7_++;
         }
         return _loc4_;
      }
      
      public function dispose() : void
      {
         this.walkAreaAsset = null;
         this.myRoot = null;
      }
   }
}
