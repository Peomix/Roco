package com.QQ.angel.data.entity.combatsys
{
   public class SpiritEquipmentDes
   {
       
      
      public var id:uint;
      
      public var type:uint;
      
      public var level:uint;
      
      public var cdtLevel:uint;
      
      public var name:String;
      
      public var getFrom:String;
      
      public var price:Array;
      
      public var src:String;
      
      public function SpiritEquipmentDes()
      {
         this.price = [];
         super();
      }
   }
}
