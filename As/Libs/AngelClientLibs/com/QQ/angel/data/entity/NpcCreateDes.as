package com.QQ.angel.data.entity
{
   public class NpcCreateDes
   {
       
      
      public var taskIDs:XMLList;
      
      public var visible:XML;
      
      public var vNpcFuncs:Array;
      
      public var viewEvents:Array;
      
      public var npcFuncs:Array;
      
      public function NpcCreateDes(param1:XML = null, param2:int = 0, param3:String = "")
      {
         super();
         this.analyse(param1,param2,param3);
      }
      
      public function addNpcFuncDes(param1:NpcFuncDes) : void
      {
         if(param1.visible == null)
         {
            if(this.npcFuncs == null)
            {
               this.npcFuncs = [];
            }
            this.npcFuncs.push(param1);
            return;
         }
         if(this.vNpcFuncs == null)
         {
            this.vNpcFuncs = [];
         }
         this.vNpcFuncs.push(param1);
      }
      
      public function analyse(param1:XML, param2:int = 0, param3:String = "") : void
      {
         var _loc6_:int = 0;
         var _loc7_:XML = null;
         if(param1 == null)
         {
            return;
         }
         this.visible = param1.Visible[0];
         this.taskIDs = param1.Task;
         var _loc5_:int;
         var _loc4_:XMLList;
         if((_loc5_ = (_loc4_ = param1.ViewEvent).length()) > 0)
         {
            this.viewEvents = [];
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               this.viewEvents.push(new NpcViewEventDes(_loc4_[_loc6_],param2,param3));
               _loc6_++;
            }
         }
         if((_loc5_ = (_loc4_ = param1.NPCFun).length()) > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc7_ = _loc4_[_loc6_];
               if(String(_loc7_.@taskCall) == "")
               {
                  this.addNpcFuncDes(new NpcFuncDes(_loc7_,param2,param3));
               }
               _loc6_++;
            }
         }
      }
   }
}
