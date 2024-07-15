package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   
   public class NpcFuncDes
   {
       
      
      public var visible:XML;
      
      public var label:String;
      
      public var icon:int;
      
      public var close:String;
      
      public var handler:CFunction;
      
      public var fun:CFunction;
      
      public var nextID:int = -1;
      
      public var tState:TaskState;
      
      public var clickDes:NPCCDConvert;
      
      public function NpcFuncDes(param1:XML = null, param2:int = 0, param3:String = "")
      {
         super();
         this.analyse(param1,param2,param3);
      }
      
      public static function ProcessClickXML(param1:XML, param2:int = 0, param3:String = "") : NPCCDConvert
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc4_:String = param1.@event;
         var _loc5_:NPCCDConvert;
         (_loc5_ = __global.createNPCCD(_loc4_)).event = _loc4_;
         _loc5_.npcID = param2;
         _loc5_.npcname = param3;
         _loc5_.tranNPCClickDes(param1);
         return _loc5_;
      }
      
      public function analyse(param1:XML, param2:int = 0, param3:String = "") : void
      {
         if(param1 == null)
         {
            return;
         }
         this.visible = param1.Visible[0];
         this.label = param1.@label;
         this.icon = -2;
         if(param1.@icon != undefined)
         {
            this.icon = int(param1.@icon);
            if(this.icon == -1 || this.icon == 0)
            {
               this.tState = new TaskState(10000,this.icon + 2);
            }
         }
         else if(param1.@iconType != undefined)
         {
            this.icon = int(param1.@iconType);
         }
         this.close = String(param1.@close);
         if(param1.@nextID != undefined)
         {
            this.nextID = int(param1.@nextID);
         }
         this.clickDes = ProcessClickXML(param1.Click[0],param2,param3);
      }
   }
}
