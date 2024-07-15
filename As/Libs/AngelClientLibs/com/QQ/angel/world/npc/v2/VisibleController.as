package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.SysEventDes;
   import com.QQ.angel.data.entity.tasksys.TaskDataV2;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   import com.QQ.angel.data.entity.tasksys.model.IModelManager;
   import com.QQ.angel.data.entity.tasksys.model.ITaskModel;
   import com.QQ.angel.data.entity.world.CareTaskID;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class VisibleController
   {
       
      
      protected var sys:IAngelSysAPI;
      
      protected var tModels:IModelManager;
      
      protected var npcModel:AngelNPCModel;
      
      protected var isActived:Boolean = false;
      
      protected var hasTaskList:Boolean = false;
      
      protected var delayCallTimer:Timer;
      
      public function VisibleController(param1:IAngelSysAPI)
      {
         super();
         this.sys = param1;
         var _loc2_:IEventDispatcher = param1.getGEventAPI().angelEventDispatcher;
         _loc2_.addEventListener(AngelSysEvent.ON_SYS_EVENT,this.onSystemEvent);
         this.delayCallTimer = new Timer(500);
         this.delayCallTimer.addEventListener(TimerEvent.TIMER,this.updateTaskNpcs);
      }
      
      protected function get modelManager() : IModelManager
      {
         if(this.tModels == null)
         {
            this.tModels = this.sys.getGDataAPI().getGlobalVal(Constants.TASK_LIST_DATA) as IModelManager;
         }
         return this.tModels;
      }
      
      protected function refreshNpcs() : void
      {
         var _loc2_:NpcDataProxy = null;
         var _loc3_:NpcDes = null;
         var _loc4_:VisibleDes = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:CareTaskID = null;
         var _loc1_:Array = this.npcModel.getVNpcDeses();
         if(_loc1_ != null && _loc1_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.length)
            {
               _loc3_ = (_loc4_ = _loc1_[_loc6_]).attachDes;
               if(_loc5_ = _loc4_.visibleXML.getTaskVisible(this.modelManager))
               {
                  _loc7_ = _loc4_.visibleXML.getCurrTrue();
                  if(_loc4_.exist)
                  {
                     _loc2_ = this.npcModel.getNpcProxy2(_loc3_) as NpcDataProxy;
                     if(_loc2_ != null)
                     {
                        _loc2_.updateCareID(_loc7_);
                     }
                  }
                  else
                  {
                     _loc3_.tState = _loc7_;
                     _loc4_.exist = true;
                     this.npcModel.addNpc(_loc3_,true);
                  }
               }
               else if(_loc4_.exist)
               {
                  _loc4_.exist = false;
                  this.npcModel.removeNpc(_loc3_,true);
               }
               _loc6_++;
            }
         }
      }
      
      protected function refreshNpcFuncs() : void
      {
         var _loc1_:NpcDataProxy = null;
         var _loc2_:NpcDes = null;
         var _loc3_:VisibleDes = null;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         var _loc5_:Array;
         if((_loc5_ = this.npcModel.getVNpcFuncs()) != null && _loc5_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc3_ = _loc5_[_loc6_];
               _loc2_ = _loc3_.attachDes;
               _loc1_ = this.npcModel.getNpcProxy2(_loc2_) as NpcDataProxy;
               if(_loc1_ != null)
               {
                  if(_loc4_ = _loc3_.visibleXML.getTaskVisible(this.modelManager))
                  {
                     if(_loc3_.exist == false)
                     {
                        _loc3_.exist = true;
                        _loc1_.addNpcFunc(_loc3_.funcDes);
                     }
                  }
                  else if(_loc3_.exist)
                  {
                     _loc3_.exist = false;
                     _loc1_.removeNpcFunc(_loc3_.funcDes);
                  }
               }
               _loc6_++;
            }
         }
      }
      
      public function refreshCareTaskIDs() : void
      {
         var _loc1_:NpcDataProxy = null;
         var _loc2_:NpcDes = null;
         var _loc3_:VisibleDes = null;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:TaskState = null;
         var _loc8_:CareTaskID = null;
         var _loc9_:ITaskModel = null;
         var _loc10_:TaskDataV2 = null;
         var _loc11_:Boolean = false;
         var _loc5_:Array;
         if((_loc5_ = this.npcModel.getVCareStates()) != null && _loc5_.length > 0)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc5_.length)
            {
               _loc3_ = _loc5_[_loc6_];
               _loc2_ = _loc3_.attachDes;
               _loc1_ = this.npcModel.getNpcProxy2(_loc2_) as NpcDataProxy;
               if(_loc1_ != null)
               {
                  _loc7_ = _loc3_.currState;
                  _loc8_ = _loc3_.careTaskID;
                  if((_loc9_ = this.modelManager.getTaskModelByID(_loc8_.taskID)) != null)
                  {
                     _loc10_ = _loc9_.getValue();
                     if(_loc8_.isCareNow(_loc10_.state))
                     {
                        _loc11_ = false;
                        if(_loc7_.id != _loc10_.taskID)
                        {
                           _loc7_.id = _loc10_.taskID;
                           _loc11_ = true;
                        }
                        if(_loc7_.state != _loc10_.state)
                        {
                           _loc7_.state = _loc10_.state;
                           _loc11_ = true;
                        }
                        if(_loc3_.exist == false)
                        {
                           _loc3_.exist = true;
                           _loc1_.addCareTaskState(_loc7_);
                        }
                        else if(_loc11_)
                        {
                           _loc1_.updateHeadIcon();
                        }
                     }
                     else if(_loc3_.exist)
                     {
                        _loc1_.removeCareTaskState(_loc7_);
                     }
                  }
               }
               _loc6_++;
            }
         }
      }
      
      protected function updateTaskNpcs(param1:TimerEvent = null) : void
      {
         this.delayCallTimer.reset();
         if(!this.hasTaskList || this.npcModel == null || this.isActived == false)
         {
            return;
         }
         this.refreshNpcs();
         this.refreshNpcFuncs();
         this.refreshCareTaskIDs();
      }
      
      protected function onSystemEvent(param1:AngelSysEvent) : void
      {
         var _loc2_:SysEventDes = param1.data as SysEventDes;
         if(_loc2_ == null)
         {
            return;
         }
         switch(_loc2_.type)
         {
            case SysEventDes.TASK_REFRESH:
               this.hasTaskList = true;
            case SysEventDes.CONDITION_REFRESH:
               this.delayCallTimer.reset();
               this.delayCallTimer.start();
         }
      }
      
      public function watch(param1:AngelNPCModel) : void
      {
         this.npcModel = param1;
         this.isActived = true;
         this.delayCallTimer.reset();
         this.delayCallTimer.start();
      }
      
      public function unwatch() : void
      {
         this.delayCallTimer.reset();
         this.npcModel = null;
         this.isActived = false;
      }
   }
}
