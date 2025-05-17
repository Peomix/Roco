package com.QQ.angel.data.entity.combatsys
{
   public class SpiritDetailInfo
   {
      
      public var id:uint;
      
      public var name:String;
      
      public var level:int;
      
      public var exp:int;
      
      public var temper:int;
      
      public var state:Array;
      
      public var skills:Array;
      
      public var features:Array;
      
      public var basicProperties:SpiritProperties;
      
      public var talentProperties:SpiritProperties;
      
      public var growthProperties:SpiritProperties;
      
      public function SpiritDetailInfo()
      {
         super();
      }
   }
}

