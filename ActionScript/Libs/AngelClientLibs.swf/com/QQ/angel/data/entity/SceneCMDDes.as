package com.QQ.angel.data.entity
{
   public class SceneCMDDes extends NPCCDConvert
   {
      
      public static const WORK_CMD:int = 1;
      
      public static const EVENT_CMD:int = 2;
      
      public static const CHALLENGE_CMD:int = 3;
      
      public var cmd:int = 0;
      
      public var type:String;
      
      public var params:*;
      
      public function SceneCMDDes()
      {
         super();
      }
      
      public function getCMD() : int
      {
         return this.cmd;
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.cmd = int(param1.@cmd);
         this.type = String(param1.@type);
         this.params = String(param1.@params);
      }
   }
}

