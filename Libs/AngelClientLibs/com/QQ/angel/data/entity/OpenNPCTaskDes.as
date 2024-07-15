package com.QQ.angel.data.entity
{
   public class OpenNPCTaskDes extends NPCCDConvert
   {
       
      
      public var type:int = 0;
      
      public var dialog:String;
      
      public var taskIDs:Array;
      
      public var npcFuns:Array;
      
      public var params:String;
      
      public function OpenNPCTaskDes()
      {
         this.taskIDs = [];
         this.npcFuns = [];
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.dialog = words;
         words = "";
         if(param1.@params != undefined)
         {
            this.params = param1.@params;
         }
      }
   }
}
