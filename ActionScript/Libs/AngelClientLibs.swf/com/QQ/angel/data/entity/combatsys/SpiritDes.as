package com.QQ.angel.data.entity.combatsys
{
   public class SpiritDes
   {
      
      public static const STATE_NORMAL:int = 0;
      
      public static const STATE_HOT:int = 1;
      
      public static const STATE_NEW:int = 2;
      
      public var id:uint;
      
      public var name:String;
      
      public var features:Array;
      
      public var src:String;
      
      public var avatar:String;
      
      public var iconSrc:String;
      
      public var previewSrc:String;
      
      public var linkName:String;
      
      public var mType:int = 0;
      
      public var mSpeed:int = 3;
      
      public var description:String;
      
      public var height:String;
      
      public var weight:String;
      
      public var color:String;
      
      public var interest:String;
      
      public var habitat:String;
      
      public var evolution:String;
      
      public var evolutionLevel:int = 0;
      
      public var evolutionID:int = 0;
      
      public var catchrate:int = 0;
      
      public var group:Array = [];
      
      public var bossPhyle:String;
      
      public var bossReward:String;
      
      public var sceneId:int;
      
      public var condition:String;
      
      public var requireLevel:String;
      
      public var wg:int;
      
      public var mg:int;
      
      public var mk:int;
      
      public var sm:int;
      
      public var sd:int;
      
      public var fy:int;
      
      public var EvolutionFormID:int;
      
      public var EvolutiontoIDs:Array;
      
      public var getForm:String;
      
      public var state:int;
      
      public var startTime:String = "";
      
      public var endTime:String = "";
      
      public var firstID:int;
      
      public var propoLevel:int = -1;
      
      public var isInBook:Boolean = true;
      
      public var skinnum:int;
      
      public var expType:int;
      
      public var reward:uint;
      
      public function SpiritDes()
      {
         super();
      }
   }
}

