package com.QQ.angel.world.vo
{
   import com.QQ.angel.data.entity.world.RefreshItem;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class RefreshSpiritVo extends RefreshItem
   {
      
      public var isRare:uint;
      
      public var isBoss:Boolean = false;
      
      public var isNPCBoss:Boolean = false;
      
      public function RefreshSpiritVo()
      {
         super();
      }
      
      public function createData(param1:int, param2:Rectangle) : SpiritData
      {
         var _loc4_:Point = null;
         var _loc3_:SpiritData = new SpiritData();
         _loc3_.id = _loc3_.uin = param1;
         _loc3_.typeID = id;
         _loc3_.avatarType = id;
         _loc3_.spiritDes = spiritDes;
         _loc3_.motionType = spiritDes.mType;
         _loc3_.speed = spiritDes.mSpeed;
         _loc3_.direction = int(Math.random() * 4);
         if(position == null)
         {
            _loc4_ = new Point();
            _loc4_.x = int(param2.x + Math.random() * param2.width);
            _loc4_.y = int(param2.y + Math.random() * param2.height);
            _loc3_.locXY = _loc4_;
         }
         else
         {
            _loc3_.locXY = position.clone();
         }
         _loc3_.sceneKey = sceneKey;
         if(sceneKey != null)
         {
            _loc3_.headType = sceneKey.headIcon;
            _loc3_.headTxt = sceneKey.headTxt;
            _loc3_.words = sceneKey.words;
         }
         return _loc3_;
      }
   }
}

