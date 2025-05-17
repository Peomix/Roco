package com.QQ.angel.world.utils
{
   public class Astar1
   {
      
      private const COST_STRAIGHT:int = 10;
      
      private const COST_DIAGONAL:int = 14;
      
      private const NOTE_ID:int = 0;
      
      private const NOTE_OPEN:int = 1;
      
      private const NOTE_CLOSED:int = 2;
      
      private var m_mapTileModel:IMapTileModel;
      
      private var m_maxTry:int;
      
      private var m_openList:Array;
      
      private var m_openCount:int;
      
      private var m_openId:int;
      
      private var m_xList:Array;
      
      private var m_yList:Array;
      
      private var m_pathScoreList:Array;
      
      private var m_movementCostList:Array;
      
      private var m_fatherList:Array;
      
      private var m_noteMap:Array;
      
      public function Astar1(param1:IMapTileModel, param2:int = 2000)
      {
         super();
         this.m_mapTileModel = param1;
         this.m_maxTry = param2;
      }
      
      public function getMapModel() : IMapTileModel
      {
         return this.m_mapTileModel;
      }
      
      public function get maxTry() : int
      {
         return this.m_maxTry;
      }
      
      public function set maxTry(param1:int) : void
      {
         this.m_maxTry = param1;
      }
      
      public function find(param1:int, param2:int, param3:int, param4:int) : Array
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:Array = null;
         this.initLists();
         this.m_openCount = 0;
         this.m_openId = -1;
         this.openNote(param1,param2,0,0,0);
         var _loc5_:int = 0;
         while(this.m_openCount > 0)
         {
            if(++_loc5_ > this.m_maxTry)
            {
               this.destroyLists();
               return null;
            }
            _loc6_ = int(this.m_openList[0]);
            this.closeNote(_loc6_);
            _loc7_ = int(this.m_xList[_loc6_]);
            _loc8_ = int(this.m_yList[_loc6_]);
            if(_loc7_ == param3 && _loc8_ == param4)
            {
               return this.getPath(param1,param2,_loc6_);
            }
            _loc9_ = this.getArounds(_loc7_,_loc8_);
            for each(_loc13_ in _loc9_)
            {
               _loc11_ = this.m_movementCostList[_loc6_] + (_loc13_[0] == _loc7_ || _loc13_[1] == _loc8_ ? this.COST_STRAIGHT : this.COST_DIAGONAL);
               _loc12_ = _loc11_ + (Math.abs(param3 - _loc13_[0]) + Math.abs(param4 - _loc13_[1])) * this.COST_STRAIGHT;
               if(this.isOpen(_loc13_[0],_loc13_[1]))
               {
                  _loc10_ = int(this.m_noteMap[_loc13_[1]][_loc13_[0]][this.NOTE_ID]);
                  if(_loc11_ < this.m_movementCostList[_loc10_])
                  {
                     this.m_movementCostList[_loc10_] = _loc11_;
                     this.m_pathScoreList[_loc10_] = _loc12_;
                     this.m_fatherList[_loc10_] = _loc6_;
                     this.aheadNote(this.getIndex(_loc10_));
                  }
               }
               else
               {
                  this.openNote(_loc13_[0],_loc13_[1],_loc12_,_loc11_,_loc6_);
               }
            }
         }
         this.destroyLists();
         return null;
      }
      
      private function openNote(param1:int, param2:int, param3:int, param4:int, param5:int) : void
      {
         ++this.m_openCount;
         ++this.m_openId;
         if(this.m_noteMap[param2] == null)
         {
            this.m_noteMap[param2] = [];
         }
         this.m_noteMap[param2][param1] = [];
         this.m_noteMap[param2][param1][this.NOTE_OPEN] = true;
         this.m_noteMap[param2][param1][this.NOTE_ID] = this.m_openId;
         this.m_xList.push(param1);
         this.m_yList.push(param2);
         this.m_pathScoreList.push(param3);
         this.m_movementCostList.push(param4);
         this.m_fatherList.push(param5);
         this.m_openList.push(this.m_openId);
         this.aheadNote(this.m_openCount);
      }
      
      private function closeNote(param1:int) : void
      {
         --this.m_openCount;
         var _loc2_:int = int(this.m_xList[param1]);
         var _loc3_:int = int(this.m_yList[param1]);
         this.m_noteMap[_loc3_][_loc2_][this.NOTE_OPEN] = false;
         this.m_noteMap[_loc3_][_loc2_][this.NOTE_CLOSED] = true;
         if(this.m_openCount <= 0)
         {
            this.m_openCount = 0;
            this.m_openList = [];
            return;
         }
         this.m_openList[0] = this.m_openList.pop();
         this.backNote();
      }
      
      private function aheadNote(param1:int) : void
      {
         var _loc2_:* = 0;
         var _loc3_:int = 0;
         while(param1 > 1)
         {
            _loc2_ = param1 >> 1;
            if(this.getScore(param1) >= this.getScore(_loc2_))
            {
               break;
            }
            _loc3_ = int(this.m_openList[param1 - 1]);
            this.m_openList[param1 - 1] = this.m_openList[_loc2_ - 1];
            this.m_openList[_loc2_ - 1] = _loc3_;
            param1 = _loc2_;
         }
      }
      
      private function backNote() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 1;
         while(true)
         {
            _loc2_ = _loc1_;
            _loc3_ = _loc2_ << 1;
            if(_loc3_ <= this.m_openCount)
            {
               if(this.getScore(_loc1_) > this.getScore(_loc3_))
               {
                  _loc1_ = _loc3_;
               }
               if(_loc3_ + 1 <= this.m_openCount)
               {
                  if(this.getScore(_loc1_) > this.getScore(_loc3_ + 1))
                  {
                     _loc1_ = _loc3_ + 1;
                  }
               }
            }
            if(_loc2_ == _loc1_)
            {
               break;
            }
            _loc4_ = int(this.m_openList[_loc2_ - 1]);
            this.m_openList[_loc2_ - 1] = this.m_openList[_loc1_ - 1];
            this.m_openList[_loc1_ - 1] = _loc4_;
         }
      }
      
      private function isOpen(param1:int, param2:int) : Boolean
      {
         if(this.m_noteMap[param2] == null)
         {
            return false;
         }
         if(this.m_noteMap[param2][param1] == null)
         {
            return false;
         }
         return this.m_noteMap[param2][param1][this.NOTE_OPEN];
      }
      
      private function isClosed(param1:int, param2:int) : Boolean
      {
         if(this.m_noteMap[param2] == null)
         {
            return false;
         }
         if(this.m_noteMap[param2][param1] == null)
         {
            return false;
         }
         return this.m_noteMap[param2][param1][this.NOTE_CLOSED];
      }
      
      private function getArounds(param1:int, param2:int) : Array
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = false;
         var _loc3_:Array = [];
         _loc4_ = param1 + 1;
         _loc5_ = param2;
         var _loc7_:* = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc7_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1;
         _loc5_ = param2 + 1;
         var _loc8_:* = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc8_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2;
         var _loc9_:* = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc9_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1;
         _loc5_ = param2 - 1;
         var _loc10_:* = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc10_) && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 + 1;
         _loc6_ = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc6_) && _loc7_ && _loc8_ && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 + 1;
         _loc6_ = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc6_) && _loc9_ && _loc8_ && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1 - 1;
         _loc5_ = param2 - 1;
         _loc6_ = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc6_) && _loc9_ && _loc10_ && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         _loc4_ = param1 + 1;
         _loc5_ = param2 - 1;
         _loc6_ = this.m_mapTileModel.isBlock(param1,param2,_loc4_,_loc5_) == 1;
         if((_loc6_) && _loc7_ && _loc10_ && !this.isClosed(_loc4_,_loc5_))
         {
            _loc3_.push([_loc4_,_loc5_]);
         }
         return _loc3_;
      }
      
      private function getPath(param1:int, param2:int, param3:int) : Array
      {
         var _loc4_:Array = [];
         var _loc5_:int = int(this.m_xList[param3]);
         var _loc6_:int = int(this.m_yList[param3]);
         while(_loc5_ != param1 || _loc6_ != param2)
         {
            _loc4_.unshift([_loc5_,_loc6_]);
            param3 = int(this.m_fatherList[param3]);
            _loc5_ = int(this.m_xList[param3]);
            _loc6_ = int(this.m_yList[param3]);
         }
         _loc4_.unshift([param1,param2]);
         this.destroyLists();
         return _loc4_;
      }
      
      private function getIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 1;
         for each(_loc3_ in this.m_openList)
         {
            if(_loc3_ == param1)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return -1;
      }
      
      private function getScore(param1:int) : int
      {
         return this.m_pathScoreList[this.m_openList[param1 - 1]];
      }
      
      private function initLists() : void
      {
         this.m_openList = [];
         this.m_xList = [];
         this.m_yList = [];
         this.m_pathScoreList = [];
         this.m_movementCostList = [];
         this.m_fatherList = [];
         this.m_noteMap = [];
      }
      
      private function destroyLists() : void
      {
         this.m_openList = null;
         this.m_xList = null;
         this.m_yList = null;
         this.m_pathScoreList = null;
         this.m_movementCostList = null;
         this.m_fatherList = null;
         this.m_noteMap = null;
      }
   }
}

