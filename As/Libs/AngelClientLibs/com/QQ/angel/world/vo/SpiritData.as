package com.QQ.angel.world.vo
{
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.data.entity.world.SceneSpiritKey;
   import flash.geom.Point;
   
   public class SpiritData
   {
       
      
      public var id:int;
      
      public var skinID:int;
      
      public var typeID:uint;
      
      public var uin:uint;
      
      public var headType:int = -1;
      
      public var headTxt:String;
      
      public var avatarType:uint;
      
      public var avatarVersion:int = 0;
      
      public var direction:int = 0;
      
      public var motionType:int = 0;
      
      public var speed:Number = 1;
      
      public var locXY:Point;
      
      public var spiritDes:SpiritDes;
      
      public var words:Array;
      
      public var sceneKey:SceneSpiritKey;
      
      public function SpiritData()
      {
         super();
      }
   }
}
