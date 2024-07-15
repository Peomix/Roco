package com.QQ.angel.world.scene.data
{
   import com.QQ.angel.data.entity.world.IMapModel;
   import com.QQ.angel.world.scene.AngelMapArea;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   import com.QQ.angel.world.scene.IMapArea;
   import com.QQ.angel.world.scene.impl.AbstractSceneLogic;
   import com.QQ.angel.world.utils.AStarTitleMap;
   import com.QQ.angel.world.utils.Astar1;
   import com.QQ.angel.world.utils.IMapTileModel;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AngelSceneMapModel implements IMapModel
   {
       
      
      protected var pathFinding:Astar1;
      
      public function AngelSceneMapModel(param1:IAngelSceneLogic)
      {
         var _loc3_:Class = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super();
         var _loc2_:Array = param1.getWalkData();
         if(param1 is AbstractSceneLogic && _loc2_ != null)
         {
            _loc4_ = int(_loc2_.length);
            _loc5_ = int(_loc2_[0].length);
            (param1 as AbstractSceneLogic).setClickArea(_loc4_ * 10,_loc5_ * 10);
         }
         if(_loc2_ == null)
         {
            _loc3_ = param1.getWalkAreaAsset();
         }
         if(_loc3_ != null || _loc2_ != null)
         {
            this.pathFinding = new Astar1(new AStarTitleMap(_loc3_,_loc2_,param1 as Sprite));
         }
      }
      
      public function findPath(param1:Point, param2:Point, param3:int = 0) : Array
      {
         var _loc4_:IMapTileModel = null;
         var _loc5_:Point = null;
         var _loc6_:Point = null;
         var _loc7_:Array = null;
         if(this.pathFinding != null && param3 == 0)
         {
            if((_loc4_ = this.pathFinding.getMapModel()).isWalkable2(param2) == false)
            {
               return null;
            }
            if(_loc4_.isLineConnected(param1,param2))
            {
               return [param1,param2];
            }
            _loc5_ = _loc4_.toTilePos(param1);
            _loc6_ = _loc4_.toTilePos(param2);
            if((_loc7_ = this.pathFinding.find(_loc5_.x,_loc5_.y,_loc6_.x,_loc6_.y)) == null || _loc7_.length < 2)
            {
               return null;
            }
            return _loc4_.compressArrPoints(_loc7_);
         }
         return [param1,param2];
      }
      
      public function isWalkable(param1:Point) : Boolean
      {
         if(this.pathFinding == null)
         {
            return false;
         }
         var _loc2_:IMapTileModel = this.pathFinding.getMapModel();
         return _loc2_.isWalkable2(param1);
      }
      
      public function createMapArea(param1:Rectangle) : IMapArea
      {
         if(this.pathFinding == null)
         {
            return null;
         }
         return new AngelMapArea(param1,this.pathFinding.getMapModel());
      }
      
      public function dispose() : void
      {
         if(this.pathFinding != null && this.pathFinding.getMapModel() != null)
         {
            this.pathFinding.getMapModel().dispose();
         }
         this.pathFinding = null;
      }
   }
}
