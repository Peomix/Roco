package com.QQ.angel.data.entity
{
   public class DealTaskDes extends NPCCDConvert
   {
      
      public static const ACCEPT:int = 1;
      
      public static const ACHIEVE:int = 2;
      
      public static const CDTN_UPDATA:int = 3;
       
      
      public var dealType:int = 1;
      
      public var taskID:int;
      
      public function DealTaskDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         var _loc2_:String = param1.@params;
         var _loc3_:Array = _loc2_.split("|");
         this.dealType = _loc3_[0] == "2" ? 2 : 1;
         this.taskID = int(_loc3_[1]);
      }
   }
}
