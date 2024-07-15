package com.QQ.angel.data.dataInfoAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   import DataInfoCenterUtil.DataInfoCenter;
   import DataInfoCenterUtil.DataInfoPair;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.protocol.SKT_0x0C0001_QueryTaskConditionStatus_C2S;
   import com.QQ.angel.data.protocol.SKT_0x0C0001_QueryTaskConditionStatus_S2C;
   import com.QQ.angel.data.protocol.SKT_0x0C0100_OnTaskConditionComplete_S2C;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskConditionInfo;
   import com.QQ.angel.data.templateAngel.DataInfoAdapterRequest;
   import flash.utils.ByteArray;
   
   public class DataInfoAdapter_TASK_CONDITION_STATUS extends DataInfoAdapterRequest
   {
      
      private static var s_taskConditionMonitor:TaskConditionMonitor;
       
      
      public function DataInfoAdapter_TASK_CONDITION_STATUS()
      {
         super();
         if(!s_taskConditionMonitor)
         {
            s_taskConditionMonitor = new TaskConditionMonitor();
            s_taskConditionMonitor.isRegClassInstance = true;
            s_taskConditionMonitor.callBack = onDataGettedFormMonitor;
         }
      }
      
      private static function onDataGettedFormMonitor(param1:ProtocolBase) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ByteArray = null;
         var _loc4_:DataInfoPair = null;
         var _loc5_:SKT_0x0C0001_QueryTaskConditionStatus_S2C = null;
         var _loc6_:ByteArray = null;
         var _loc7_:int = 0;
         var _loc8_:SKT_0x0C0100_OnTaskConditionComplete_S2C = null;
         var _loc9_:TaskConditionInfo = null;
         if(param1.getProtocolId() === 786433)
         {
            _loc2_ = int((_loc5_ = SKT_0x0C0001_QueryTaskConditionStatus_S2C(param1)).taskTaskId);
            if(_loc2_ == 0)
            {
               trace("error��DataInfoAdapter_TASK_CONDITION_STATUS  _taskId=0");
               return;
            }
            _loc3_ = _loc5_.taskConditionStatusArray;
            if(!(_loc4_ = DataInfoCenter.getInstance().getDataInfoPair(DataInfoType.DATAINFO_TYPE_TASK_CONDITION_STATUS,_loc2_)))
            {
               _loc6_ = new ByteArray();
               _loc3_.position = 0;
               _loc6_.writeBytes(_loc3_);
               _loc4_ = new DataInfoPair(_loc6_,_loc2_);
               DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_TASK_CONDITION_STATUS,_loc4_);
            }
            else
            {
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  _loc4_.dataInfo[_loc7_] = _loc3_[_loc7_];
                  _loc7_++;
               }
               _loc4_.updateTimeStamp();
            }
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_TASK_CONDITION_STATUS_LOADED,_loc4_);
         }
         else if(param1.getProtocolId() === 786688)
         {
            _loc8_ = SKT_0x0C0100_OnTaskConditionComplete_S2C(param1);
            for each(_loc9_ in _loc8_.taskConditionArray)
            {
               _loc2_ = int(_loc9_.taskTaskId);
               if(_loc4_ = DataInfoCenter.getInstance().getDataInfoPair(DataInfoType.DATAINFO_TYPE_TASK_CONDITION_STATUS,_loc2_))
               {
                  _loc4_.dataInfo[_loc9_.taskConditionIndex] = _loc9_.taskConditionStatus;
                  _loc4_.updateTimeStamp();
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_TASK_CONDITION_STATUS_LOADED,_loc4_);
               }
            }
         }
      }
      
      override public function createNew() : DataInfoAdapterBase
      {
         return new DataInfoAdapter_TASK_CONDITION_STATUS();
      }
      
      override public function dispose() : void
      {
         if(isRegClassInstance)
         {
            if(s_taskConditionMonitor)
            {
               s_taskConditionMonitor.dispose();
               s_taskConditionMonitor = null;
            }
         }
         super.dispose();
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return param1 == DataInfoType.DATAINFO_TYPE_TASK_CONDITION_STATUS;
      }
      
      override public function load() : void
      {
         var _loc1_:SKT_0x0C0001_QueryTaskConditionStatus_C2S = new SKT_0x0C0001_QueryTaskConditionStatus_C2S();
         _loc1_.taskTaskId = int(m_hash);
         m_protocolBase = _loc1_;
         _loc1_ = null;
         super.load();
      }
   }
}

import com.QQ.angel.data.protocolBase.ProtocolBase;
import com.QQ.angel.data.templateAngel.DataInfoAdapterSocketMonitor;

class TaskConditionMonitor extends DataInfoAdapterSocketMonitor
{
    
   
   public var callBack:Function;
   
   public function TaskConditionMonitor()
   {
      super();
      m_netCmdArray = [786433,786688];
   }
   
   override public function onDataGetted(param1:ProtocolBase) : void
   {
      if(this.callBack != null)
      {
         this.callBack(param1);
      }
   }
   
   override public function dispose() : void
   {
      this.callBack = null;
      super.dispose();
   }
}
