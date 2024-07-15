package com.QQ.angel.data.dataInfoAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoCenter;
   import DataInfoCenterUtil.DataInfoPair;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   import com.QQ.angel.data.protocol.SKT_0x0E0001_QueryTaskInfoList_C2S;
   import com.QQ.angel.data.protocol.SKT_0x0E0001_QueryTaskInfoList_S2C;
   import com.QQ.angel.data.protocol.SKT_0x0E0002_ApplyAcceptATask_S2C;
   import com.QQ.angel.data.protocol.SKT_0x0E0003_ApplyCompleteATask_S2C;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskInfo;
   import com.QQ.angel.data.templateAngel.DataInfoAdapterSocketMonitor;
   import flash.utils.Dictionary;
   
   public class DataInfoAdapter_TASK_STATUS extends DataInfoAdapterSocketMonitor
   {
       
      
      private var m_storyDict:Dictionary;
      
      private const NAME:String = "TaskGroup";
      
      public function DataInfoAdapter_TASK_STATUS()
      {
         super();
         m_netCmdArray = [917505,917506,917507];
      }
      
      private function initStoryDict() : void
      {
         this.m_storyDict = new Dictionary();
         var _loc1_:Object = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CONFS);
         this.processXML(_loc1_[this.NAME]);
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc3_:XMLList = _loc2_.StoryList[0].Story;
         var _loc4_:int = _loc3_.length();
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this.processStory(_loc3_[_loc5_]);
            _loc5_++;
         }
      }
      
      private function processStory(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = int(param1.@id);
         var _loc3_:Array = String(param1.@subIDs).split(",");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_] = int(_loc3_[_loc4_]);
            _loc4_++;
         }
         this.m_storyDict[_loc2_] = _loc3_;
      }
      
      override public function onDataGetted(param1:ProtocolBase) : void
      {
         var _loc2_:Array = null;
         var _loc4_:Dictionary = null;
         var _loc5_:TaskInfo = null;
         var _loc6_:TaskInfo = null;
         var _loc7_:Array = null;
         var _loc8_:TaskInfo = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Array = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:TaskInfo = null;
         switch(param1.getProtocolId())
         {
            case 917505:
               _loc2_ = SKT_0x0E0001_QueryTaskInfoList_S2C(param1).taskInfoListArray;
               break;
            case 917506:
               _loc2_ = SKT_0x0E0002_ApplyAcceptATask_S2C(param1).taskInfoListArray;
               break;
            case 917507:
               _loc2_ = SKT_0x0E0003_ApplyCompleteATask_S2C(param1).taskInfoListArray;
               break;
            default:
               return;
         }
         if(m_hash == null)
         {
            m_hash = __global.MainRoleData.uin;
         }
         var _loc3_:DataInfoPair = DataInfoCenter.getInstance().getDataInfoPair(DataInfoType.DATAINFO_TYPE_TASK_STATUS,m_hash);
         if(!_loc3_)
         {
            _loc4_ = new Dictionary();
            for each(_loc6_ in _loc2_)
            {
               _loc4_[_loc6_.taskTaskId] = _loc6_;
            }
            _loc3_ = new DataInfoPair(_loc4_,m_hash);
            DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_TASK_STATUS,_loc3_);
         }
         else
         {
            _loc4_ = Dictionary(_loc3_.dataInfo);
            for each(_loc5_ in _loc4_)
            {
               _loc5_.taskStatus = TaskState.DONE;
            }
            for each(_loc6_ in _loc2_)
            {
               if(!(_loc5_ = TaskInfo(_loc4_[_loc6_.taskTaskId])))
               {
                  _loc4_[_loc6_.taskTaskId] = _loc6_;
               }
               else
               {
                  _loc5_.taskStatus = _loc6_.taskStatus;
               }
            }
            if(!this.m_storyDict)
            {
               this.initStoryDict();
            }
            _loc7_ = [];
            for each(_loc8_ in _loc4_)
            {
               _loc9_ = int(_loc8_.taskTaskId);
               if((Boolean(_loc10_ = int(_loc8_.taskStoryId))) && _loc7_.indexOf(_loc10_) == -1)
               {
                  _loc7_.push(_loc10_);
                  if((_loc11_ = this.m_storyDict[_loc10_]) != null)
                  {
                     if((_loc12_ = _loc11_.indexOf(_loc9_)) != -1)
                     {
                        if(_loc12_ > 0)
                        {
                           _loc13_ = 0;
                           while(_loc13_ < _loc12_)
                           {
                              _loc14_ = int(_loc11_[_loc13_]);
                              if(_loc4_[_loc14_] == null)
                              {
                                 (_loc15_ = new TaskInfo()).taskStatus = TaskState.DONE;
                                 _loc15_.taskStoryId = _loc8_.taskStoryId;
                                 _loc15_.taskTaskId = _loc14_;
                                 _loc15_.taskType = _loc8_.taskType;
                                 _loc15_.taskTypeSub = _loc8_.taskType;
                                 _loc4_[_loc14_] = _loc15_;
                              }
                              _loc13_++;
                           }
                        }
                     }
                  }
               }
            }
            _loc7_ = null;
            _loc3_.dataInfo = _loc4_;
            _loc3_.updateTimeStamp();
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_TASK_STATUS_LOADED,_loc3_);
      }
      
      private function removeRef(param1:ProtocolBase) : void
      {
         m_isLoading = false;
         DataInfoCenter.getInstance().removeAdapterQueue(this);
      }
      
      override public function load() : void
      {
         var _loc1_:uint = uint(m_hash);
         if(_loc1_ == __global.MainRoleData.uin)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,[new SKT_0x0E0001_QueryTaskInfoList_C2S(),this.removeRef]);
         }
         m_isLoading = true;
         updateStartLoadingTimer();
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return param1 == DataInfoType.DATAINFO_TYPE_TASK_STATUS;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_storyDict = null;
      }
   }
}
