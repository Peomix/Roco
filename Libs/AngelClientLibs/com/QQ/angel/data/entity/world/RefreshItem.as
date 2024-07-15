package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import flash.geom.Point;
   
   public class RefreshItem
   {
       
      
      public var id:uint;
      
      public var num:int;
      
      public var areaIndex:int;
      
      public var position:Point;
      
      public var visible:Boolean = true;
      
      public var spiritDes:SpiritDes;
      
      public var sceneKey:SceneSpiritKey;
      
      public function RefreshItem()
      {
         super();
      }
   }
}
