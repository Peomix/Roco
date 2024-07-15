package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.NpcFuncDes;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   import com.QQ.angel.data.entity.world.CareTaskID;
   import com.QQ.angel.data.entity.world.INpcDataProxy;
   import com.QQ.angel.data.entity.world.INpcModel;
   import com.QQ.angel.data.entity.world.VisibleXML;
   import com.QQ.angel.data.entity.world.events.NpcModelEvent;
   import flash.events.EventDispatcher;
   
   public class AngelNPCModel extends EventDispatcher implements INpcModel
   {
       
      
      protected var xmlNPCDeses:Array;
      
      protected var vNPCDeses:Array;
      
      protected var vNPCFuncs:Array;
      
      protected var vCareStates:Array;
      
      protected var npcProxys:Array;
      
      public function AngelNPCModel(param1:Array)
      {
         super();
         this.initThis(param1);
      }
      
      protected function initThis(param1:Array) : void
      {
         var _loc3_:NpcDes = null;
         this.xmlNPCDeses = param1;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(_loc3_.createDes != null && _loc3_.createDes.visible != null)
            {
               this.addVNpcDes(_loc3_);
            }
            else
            {
               this.addNpc(_loc3_);
            }
            if(_loc3_.createDes != null)
            {
               this.addVNpcFuncs(_loc3_.createDes.vNpcFuncs,_loc3_);
               this.addCareTaskIDs(_loc3_.createDes.taskIDs,_loc3_);
            }
            _loc2_++;
         }
      }
      
      protected function contain(param1:NpcDes) : Boolean
      {
         return this.getNpcProxy2(param1) != null;
      }
      
      protected function addCareTaskIDs(param1:XMLList, param2:NpcDes) : void
      {
         var _loc4_:int = 0;
         var _loc5_:XML = null;
         var _loc6_:VisibleDes = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         var _loc3_:int = param1.length();
         if(_loc3_ > 0)
         {
            if(this.vCareStates == null)
            {
               this.vCareStates = [];
            }
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = param1[_loc4_];
               (_loc6_ = new VisibleDes()).attachDes = param2;
               _loc6_.careTaskID = new CareTaskID(_loc5_.@id,_loc5_.@care);
               _loc6_.currState = new TaskState();
               this.vCareStates.push(_loc6_);
               _loc4_++;
            }
         }
      }
      
      protected function addVNpcFuncs(param1:Array, param2:NpcDes) : void
      {
         var _loc3_:int = 0;
         var _loc4_:NpcFuncDes = null;
         var _loc5_:VisibleDes = null;
         if(param1 == null || param2 == null)
         {
            return;
         }
         if(param1.length > 0)
         {
            if(this.vNPCFuncs == null)
            {
               this.vNPCFuncs = [];
            }
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc4_ = param1[_loc3_];
               (_loc5_ = new VisibleDes()).attachDes = param2;
               _loc5_.funcDes = _loc4_;
               _loc5_.visibleXML = new VisibleXML(_loc4_.visible);
               this.vNPCFuncs.push(_loc5_);
               _loc3_++;
            }
         }
      }
      
      protected function addVNpcDes(param1:NpcDes) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.vNPCDeses == null)
         {
            this.vNPCDeses = [];
         }
         var _loc2_:VisibleDes = new VisibleDes();
         _loc2_.attachDes = param1;
         _loc2_.visibleXML = new VisibleXML(param1.createDes.visible);
         this.vNPCDeses.push(_loc2_);
      }
      
      public function getXMLNpcDeses() : Array
      {
         return this.xmlNPCDeses;
      }
      
      public function getVNpcDeses() : Array
      {
         return this.vNPCDeses;
      }
      
      public function getVNpcFuncs() : Array
      {
         return this.vNPCFuncs;
      }
      
      public function getVCareStates() : Array
      {
         return this.vCareStates;
      }
      
      public function getNpcProxy(param1:int) : INpcDataProxy
      {
         var _loc3_:NpcDataProxy = null;
         var _loc2_:int = int(this.npcProxys.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.npcProxys[_loc2_];
            if(_loc3_ != null && _loc3_.getNpcDes().npcID == param1)
            {
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      public function getNpcProxy2(param1:NpcDes) : INpcDataProxy
      {
         var _loc3_:NpcDataProxy = null;
         if(this.npcProxys == null)
         {
            return null;
         }
         var _loc2_:int = int(this.npcProxys.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.npcProxys[_loc2_];
            if(_loc3_ != null && _loc3_.isNpcDes(param1))
            {
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      public function addNpc(param1:NpcDes, param2:Boolean = false) : void
      {
         var _loc4_:NpcModelEvent = null;
         if(param1 == null)
         {
            return;
         }
         if(this.npcProxys == null)
         {
            this.npcProxys = [];
         }
         if(this.contain(param1))
         {
            return;
         }
         var _loc3_:NpcDataProxy = new NpcDataProxy(param1);
         this.npcProxys.push(_loc3_);
         if(param2)
         {
            (_loc4_ = new NpcModelEvent(NpcModelEvent.ON_ADD_NPC)).data = _loc3_;
            dispatchEvent(_loc4_);
         }
      }
      
      public function removeNpc(param1:NpcDes, param2:Boolean = false) : void
      {
         var _loc4_:NpcDataProxy = null;
         var _loc5_:NpcModelEvent = null;
         if(param1 == null || this.npcProxys == null)
         {
            return;
         }
         var _loc3_:int = int(this.npcProxys.length - 1);
         while(_loc3_ >= 0)
         {
            if((_loc4_ = this.npcProxys[_loc3_]) != null && _loc4_.isNpcDes(param1))
            {
               this.npcProxys.splice(_loc3_,1);
               if(param2)
               {
                  (_loc5_ = new NpcModelEvent(NpcModelEvent.ON_REMOVE_NPC)).data = _loc4_;
                  dispatchEvent(_loc5_);
               }
               return;
            }
            _loc3_--;
         }
      }
      
      public function getCurrNpcProxys() : Array
      {
         if(this.npcProxys == null)
         {
            return null;
         }
         return this.npcProxys.concat();
      }
      
      public function update() : void
      {
         dispatchEvent(new NpcModelEvent(NpcModelEvent.ON_MODEL_UPDATE));
      }
   }
}
