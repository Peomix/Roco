package com.QQ.angel.world.scene
{
   import com.QQ.angel.world.utils.IMapTileModel;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AngelMapArea implements IMapArea
   {
      
      protected var souceMapData:Array;
      
      protected var mapModel:IMapTileModel;
      
      protected var localRect:Rectangle;
      
      protected var titleLT:Point;
      
      protected var titleRB:Point;
      
      protected var isOpened:Boolean = true;
      
      public function AngelMapArea(param1:Rectangle, param2:IMapTileModel)
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         super();
         this.localRect = param1;
         this.mapModel = param2;
         this.titleLT = param2.toTilePos(new Point(param1.x,param1.y));
         this.titleRB = param2.toTilePos(new Point(param1.x + param1.width,param1.y + param1.height));
         this.souceMapData = [];
         var _loc3_:Array = param2.getMapData();
         if(_loc3_ != null)
         {
            _loc4_ = this.titleLT.x;
            while(_loc4_ < this.titleRB.x)
            {
               _loc5_ = [];
               _loc6_ = this.titleLT.y;
               while(_loc6_ < this.titleRB.y)
               {
                  _loc5_.push(_loc3_[_loc4_][_loc6_]);
                  _loc6_++;
               }
               this.souceMapData.push(_loc5_);
               _loc4_++;
            }
         }
      }
      
      protected function printMapData(param1:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         trace("====================map data begin=============");
         var _loc2_:int = 0;
         while(_loc2_ < 96)
         {
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < 56)
            {
               _loc3_ += "," + param1[_loc2_][_loc4_];
               _loc4_++;
            }
            trace(_loc3_);
            _loc2_++;
         }
         trace("====================map data end=============");
      }
      
      public function open() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(this.isOpened)
         {
            return;
         }
         this.isOpened = true;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = this.mapModel.getMapData();
         if(_loc3_ != null)
         {
            _loc4_ = this.titleLT.x;
            while(_loc4_ < this.titleRB.x)
            {
               _loc1_ = 0;
               _loc5_ = this.titleLT.y;
               while(_loc5_ < this.titleRB.y)
               {
                  _loc3_[_loc4_][_loc5_] = this.souceMapData[_loc2_][_loc1_];
                  _loc1_++;
                  _loc5_++;
               }
               _loc2_++;
               _loc4_++;
            }
         }
      }
      
      public function close() : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(!this.isOpened)
         {
            return;
         }
         this.isOpened = false;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = this.mapModel.getMapData();
         if(_loc3_ != null)
         {
            _loc4_ = this.titleLT.x;
            while(_loc4_ < this.titleRB.x)
            {
               _loc5_ = this.titleLT.y;
               while(_loc5_ < this.titleRB.y)
               {
                  _loc3_[_loc4_][_loc5_] = 0;
                  _loc5_++;
               }
               _loc4_++;
            }
         }
      }
      
      public function isOpen() : Boolean
      {
         return this.isOpened;
      }
      
      public function getLocalRect() : Rectangle
      {
         return this.localRect;
      }
      
      public function dispose() : void
      {
         this.souceMapData = null;
         this.mapModel = null;
         this.localRect = null;
         this.titleLT = null;
         this.titleRB = null;
      }
   }
}

