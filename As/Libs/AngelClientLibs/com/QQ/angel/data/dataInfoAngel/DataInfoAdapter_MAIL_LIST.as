package com.QQ.angel.data.dataInfoAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoCenter;
   import DataInfoCenterUtil.DataInfoPair;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.protocol.SKT_0x140003_OnMailListReceived_S2C;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.templateAngel.DataInfoAdapterSocketMonitor;
   
   public class DataInfoAdapter_MAIL_LIST extends DataInfoAdapterSocketMonitor
   {
       
      
      public function DataInfoAdapter_MAIL_LIST()
      {
         super();
         m_netCmdArray = [1310723];
      }
      
      override public function onDataGetted(param1:ProtocolBase) : void
      {
         var _loc2_:SKT_0x140003_OnMailListReceived_S2C = SKT_0x140003_OnMailListReceived_S2C(param1);
         var _loc3_:DataInfoPair = DataInfoCenter.getInstance().getDataInfoPair(DataInfoType.DATAINFO_TYPE_MAIL_LIST,__global.MainRoleData.uin);
         if(!_loc3_)
         {
            _loc3_ = new DataInfoPair(_loc2_.mailInfoArray.slice(),__global.MainRoleData.uin);
            DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_MAIL_LIST,_loc3_);
         }
         else
         {
            _loc3_.dataInfo = _loc2_.mailInfoArray.slice();
            _loc3_.updateTimeStamp();
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_MAIL_LIST_LOADED,_loc3_);
      }
      
      override public function load() : void
      {
         var _loc1_:uint = uint(m_hash);
         if(_loc1_ == __global.MainRoleData.uin)
         {
         }
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return param1 == DataInfoType.DATAINFO_TYPE_MAIL_LIST;
      }
   }
}
