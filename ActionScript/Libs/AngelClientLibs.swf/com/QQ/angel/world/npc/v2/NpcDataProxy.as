package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.NPCCDConvert;
   import com.QQ.angel.data.entity.NpcCreateDes;
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.NpcFuncDes;
   import com.QQ.angel.data.entity.NpcViewEventDes;
   import com.QQ.angel.data.entity.OpenAsWinDes;
   import com.QQ.angel.data.entity.OpenNPCTaskDes;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   import com.QQ.angel.data.entity.world.CareTaskID;
   import com.QQ.angel.data.entity.world.INpcDataProxy;
   import com.QQ.angel.data.entity.world.events.NpcModelEvent;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   
   public class NpcDataProxy extends EventDispatcher implements INpcDataProxy
   {
      
      protected var npcDes:NpcDes;
      
      protected var click:NPCCDConvert;
      
      protected var taskClick:OpenNPCTaskDes;
      
      protected var target:DisplayObject;
      
      protected var npcFuncs:Array;
      
      protected var taskIDs:Array;
      
      protected var viewEvents:Array;
      
      protected var careStates:Array;
      
      protected var headIconType:int = 0;
      
      public function NpcDataProxy(param1:NpcDes)
      {
         super();
         this.npcDes = param1;
         if(this.npcDes == null)
         {
            throw new Error("[NpcDataProxy] NpcDes不能为空!");
         }
         this.npcFuncs = [];
         this.careStates = [];
         this.taskIDs = [];
      }
      
      protected function specialOpenAsWin(param1:NPCCDConvert) : void
      {
         var _loc2_:OpenAsWinDes = param1 as OpenAsWinDes;
         if(_loc2_ == null || _loc2_.fire == false || _loc2_.params != "true")
         {
            return;
         }
         _loc2_.params = new CFunction(__global.DataAPI.fireClickToCGI,__global.DataAPI,[_loc2_.npcID,true]);
         _loc2_.fire = false;
      }
      
      protected function checkIconType() : int
      {
         var _loc3_:TaskState = null;
         var _loc4_:int = 0;
         if(this.careStates == null || this.careStates.length == 0)
         {
            return 0;
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.careStates.length)
         {
            _loc3_ = this.careStates[_loc2_];
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.state;
               if(_loc4_ == TaskState.NOTACCEPTED || _loc4_ == TaskState.ACCEPTED)
               {
                  _loc1_ = _loc4_;
                  if(_loc1_ == TaskState.ACCEPTED)
                  {
                     return _loc1_;
                  }
               }
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      protected function bindViewEvents(param1:Boolean = true) : void
      {
         var _loc3_:int = 0;
         var _loc4_:NpcViewEventDes = null;
         var _loc2_:NpcCreateDes = this.npcDes.createDes;
         if(_loc2_ != null)
         {
            this.viewEvents = _loc2_.viewEvents;
            if(this.viewEvents != null)
            {
               _loc3_ = 0;
               while(_loc3_ < this.viewEvents.length)
               {
                  _loc4_ = this.viewEvents[_loc3_];
                  if(_loc4_ != null && _loc4_.clickDes != null)
                  {
                     if(param1)
                     {
                        _loc4_.clickDes.target = this.target;
                        _loc4_.handler = new CFunction(__global.executeClick,__global,[_loc4_.clickDes]);
                        this.specialOpenAsWin(_loc4_.clickDes);
                     }
                     else
                     {
                        _loc4_.clickDes.target = null;
                        _loc4_.handler = null;
                     }
                  }
                  _loc3_++;
               }
            }
         }
      }
      
      protected function bindNpcFunc(param1:Boolean = true) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:NpcFuncDes = null;
         var _loc2_:NpcCreateDes = this.npcDes.createDes;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.npcFuncs;
            if(_loc3_ != null)
            {
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  _loc5_ = _loc3_[_loc4_];
                  if(_loc5_ != null && _loc5_.clickDes != null)
                  {
                     if(param1)
                     {
                        this.addNpcFunc(_loc5_);
                     }
                     else
                     {
                        _loc5_.fun = _loc5_.handler = null;
                        _loc5_.clickDes.target = null;
                     }
                  }
                  _loc4_++;
               }
            }
         }
      }
      
      public function bind(param1:DisplayObject) : void
      {
         this.target = param1;
         if(this.npcDes.position == null)
         {
            this.npcDes.position = new Point(param1.x,param1.y);
         }
         this.bindViewEvents(true);
         this.click = this.npcDes.clickDes;
         if(this.click != null)
         {
            this.click.target = this.target;
            this.specialOpenAsWin(this.click);
            if(this.click.aimPos == null)
            {
               this.click.aimPos = this.npcDes.aimPos;
               if(this.click.aimPos == null)
               {
                  this.click.aimPos = this.npcDes.position;
               }
            }
            this.taskClick = this.click as OpenNPCTaskDes;
            if(this.taskClick != null)
            {
               if(this.npcFuncs == null)
               {
                  this.npcFuncs = [];
               }
               this.taskClick.npcFuns = this.npcFuncs;
               if(this.taskIDs == null)
               {
                  this.taskIDs = [];
               }
               this.taskClick.taskIDs = this.taskIDs;
               if(this.careStates == null)
               {
                  this.careStates = [];
               }
               this.bindNpcFunc(true);
            }
         }
      }
      
      public function unbind() : void
      {
         if(this.click != null)
         {
            this.click.target = null;
            this.click = null;
         }
         this.bindViewEvents(false);
         if(this.taskClick != null)
         {
            this.taskClick.npcFuns = null;
            this.taskClick.taskIDs = null;
            this.bindNpcFunc(false);
         }
         this.npcDes.tState = null;
         this.viewEvents = null;
         this.npcFuncs = null;
         this.taskIDs = null;
         this.careStates = null;
         this.npcDes = null;
         this.target = null;
      }
      
      public function equal(param1:INpcDataProxy) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.npcDes == param1.getNpcDes();
      }
      
      public function isNpcDes(param1:NpcDes) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return this.npcDes == param1;
      }
      
      public function updateHeadIcon() : void
      {
         var _loc1_:int = this.checkIconType();
         if(_loc1_ == this.headIconType)
         {
            return;
         }
         this.headIconType = _loc1_;
         dispatchEvent(new NpcModelEvent(NpcModelEvent.ON_HEADICON_CHANGE));
      }
      
      public function updateCareID(param1:CareTaskID) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc3_:CareTaskID = this.npcDes.tState as CareTaskID;
         if(_loc3_ == null || _loc3_.taskID != param1.taskID || _loc3_.sourceCare != param1.sourceCare)
         {
            this.npcDes.tState = param1;
            dispatchEvent(new NpcModelEvent(NpcModelEvent.ON_TSTATE_CHANGE));
         }
      }
      
      public function addCareTaskState(param1:TaskState, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(param1 == null || this.careStates == null)
         {
            return;
         }
         if(this.careStates.indexOf(param1) != -1)
         {
            return;
         }
         this.careStates.push(param1);
         if(!param2)
         {
            _loc3_ = param1.id;
            if(this.taskIDs.indexOf(_loc3_) == -1)
            {
               this.taskIDs.push(_loc3_);
            }
         }
         if(this.headIconType == param1.state || this.headIconType == TaskState.ACCEPTED)
         {
            return;
         }
         this.headIconType = param1.state;
         dispatchEvent(new NpcModelEvent(NpcModelEvent.ON_HEADICON_CHANGE));
      }
      
      public function removeCareTaskState(param1:TaskState, param2:Boolean = false) : void
      {
         var _loc4_:int = 0;
         if(param1 == null || this.careStates == null)
         {
            return;
         }
         var _loc3_:int = int(this.careStates.indexOf(param1));
         if(_loc3_ == -1)
         {
            return;
         }
         this.careStates.splice(_loc3_,1);
         if(!param2)
         {
            _loc4_ = param1.id;
            _loc3_ = int(this.taskIDs.indexOf(_loc4_));
            if(_loc3_ != -1)
            {
               this.taskIDs.splice(_loc3_,1);
            }
         }
         this.updateHeadIcon();
      }
      
      public function setGeneralDialog(param1:String) : void
      {
      }
      
      public function addNpcFunc(param1:NpcFuncDes) : void
      {
         if(param1 == null || this.npcFuncs == null)
         {
            return;
         }
         if(this.npcFuncs.indexOf(param1) == -1)
         {
            if(param1.clickDes != null)
            {
               param1.fun = param1.handler = new CFunction(__global.executeClick,__global,[param1.clickDes]);
               param1.clickDes.target = this.target;
               this.specialOpenAsWin(param1.clickDes);
            }
            this.npcFuncs.push(param1);
            if(param1.tState != null)
            {
               this.addCareTaskState(param1.tState,true);
            }
         }
      }
      
      public function removeNpcFunc(param1:NpcFuncDes) : void
      {
         if(param1 == null || this.npcFuncs == null)
         {
            return;
         }
         var _loc2_:int = int(this.npcFuncs.indexOf(param1));
         if(_loc2_ != -1)
         {
            this.npcFuncs.splice(_loc2_,1);
            if(param1.clickDes != null)
            {
               param1.fun = param1.handler = null;
               param1.clickDes.target = null;
            }
            if(param1.tState != null)
            {
               this.removeCareTaskState(param1.tState,true);
            }
         }
      }
      
      public function getNpcDes() : NpcDes
      {
         return this.npcDes;
      }
      
      public function getTargetPos() : Point
      {
         return this.npcDes.position;
      }
      
      public function getClick() : NPCCDConvert
      {
         return this.click;
      }
      
      public function getHeadIcon() : int
      {
         return this.headIconType;
      }
      
      public function getViewEvents() : Array
      {
         return this.viewEvents;
      }
      
      public function getTarget() : DisplayObject
      {
         return this.target;
      }
      
      public function dispose() : void
      {
      }
   }
}

