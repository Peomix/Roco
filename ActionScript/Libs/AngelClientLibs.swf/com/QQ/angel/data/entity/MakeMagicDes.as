package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.world.role.IRole;
   import flash.geom.Point;
   
   public class MakeMagicDes
   {
      
      public var aimPos:Point;
      
      public var userPos:Point;
      
      public var userUin:uint;
      
      public var aimRole:IRole;
      
      public var aimElement:Object;
      
      public var useMS:MagicSkillDes;
      
      public var isClient:Boolean = false;
      
      public var openMSDes:OpenMagicDes;
      
      public function MakeMagicDes()
      {
         super();
      }
   }
}

