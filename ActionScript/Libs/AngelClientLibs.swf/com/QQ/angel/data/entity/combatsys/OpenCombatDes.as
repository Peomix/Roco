package com.QQ.angel.data.entity.combatsys
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.NPCCDConvert;
   
   public class OpenCombatDes extends NPCCDConvert
   {
      
      public var combatType:int;
      
      public var opponentID:uint;
      
      public var catchTime:uint = 0;
      
      public var oppoentName:String = "未知";
      
      public var isWait:Boolean = false;
      
      public var handler:CFunction;
      
      public var combatServerType:int;
      
      public var alertHandler:CFunction;
      
      public function OpenCombatDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.combatType = int(param1.@cType);
         if(param1.@params == undefined)
         {
            this.opponentID = npcID;
         }
         else
         {
            this.opponentID = int(param1.@params);
         }
         if(param1.@name != undefined)
         {
            this.oppoentName = param1.@name;
         }
         if(param1.@catchTime != undefined)
         {
            this.catchTime = uint(param1.@catchTime);
         }
      }
   }
}

