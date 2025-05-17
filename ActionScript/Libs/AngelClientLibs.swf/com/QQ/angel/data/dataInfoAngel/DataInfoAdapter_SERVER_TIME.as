package com.QQ.angel.data.dataInfoAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   import DataInfoCenterUtil.DataInfoCenter;
   import DataInfoCenterUtil.DataInfoPair;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.protocol.SKT_0x030085_QueryServerTime_C2S;
   import com.QQ.angel.data.protocol.SKT_0x030085_QueryServerTime_S2C;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.getTimer;
   
   public class DataInfoAdapter_SERVER_TIME extends DataInfoAdapterBase
   {
      
      private var m_diPair:DataInfoPair;
      
      private var m_diPairStamp:DataInfoPair;
      
      private var m_serverTimeGettted:Number;
      
      private var m_serverTimeComputed:Number;
      
      private var m_localTime:Number;
      
      private var m_lastMinutes:int;
      
      public function DataInfoAdapter_SERVER_TIME()
      {
         super();
         CallbackCenter.registerCallBack(CALLBACK.AS3_ENTER_FRAME,DataInfoAdapter_SERVER_TIME.onUpdateTimer,this);
      }
      
      private static function onUpdateTimer(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc6_:uint = 0;
         var _loc7_:Date = null;
         var _loc8_:* = false;
         var _loc5_:DataInfoAdapter_SERVER_TIME = param4 as DataInfoAdapter_SERVER_TIME;
         if(_loc5_.m_diPair)
         {
            _loc6_ = getTimer() - _loc5_.m_localTime;
            _loc5_.m_serverTimeComputed = _loc5_.m_serverTimeGettted + _loc6_;
            _loc7_ = new Date(_loc5_.m_serverTimeComputed);
            _loc8_ = _loc5_.m_lastMinutes != _loc7_.minutes;
            _loc5_.m_lastMinutes = _loc7_.minutes;
            _loc5_.m_diPair.dataInfo = _loc7_;
            _loc5_.m_diPair.updateTimeStamp();
            _loc5_.m_diPairStamp.dataInfo = _loc5_.m_serverTimeComputed;
            _loc5_.m_diPairStamp.updateTimeStamp();
            if(_loc8_)
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_SERVER_TIME_LOADED,_loc5_.m_diPair);
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_SERVER_TIME_STAMP_LOADED,_loc5_.m_diPairStamp);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      override public function createNew() : DataInfoAdapterBase
      {
         return this;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         CallbackCenter.unregisterCallBack(CALLBACK.AS3_ENTER_FRAME,DataInfoAdapter_SERVER_TIME.onUpdateTimer,this);
      }
      
      override public function load() : void
      {
         m_hash = null;
         if(m_isLoading)
         {
            DataInfoCenter.getInstance().removeAdapterQueue(this);
            return;
         }
         var _loc1_:SKT_0x030085_QueryServerTime_C2S = new SKT_0x030085_QueryServerTime_C2S();
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,[_loc1_,this.onGetData]);
         m_isLoading = true;
         updateStartLoadingTimer();
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return param1 == DataInfoType.DATAINFO_TYPE_SERVER_TIME || param1 == DataInfoType.DATAINFO_TYPE_SERVER_TIME_STAMP;
      }
      
      private function onGetData(param1:ProtocolBase) : void
      {
         var _loc3_:Date = null;
         m_isLoading = false;
         DataInfoCenter.getInstance().removeAdapterQueue(this);
         var _loc2_:SKT_0x030085_QueryServerTime_S2C = SKT_0x030085_QueryServerTime_S2C(param1);
         if(_loc2_.retCode.code == 0)
         {
            this.m_serverTimeGettted = _loc2_.stamp;
            this.m_serverTimeGettted *= 1000;
            this.m_localTime = getTimer();
            this.m_serverTimeComputed = this.m_serverTimeGettted;
            _loc3_ = new Date(this.m_serverTimeComputed);
            this.m_lastMinutes = _loc3_.minutes;
            if(!this.m_diPair)
            {
               this.m_diPair = new DataInfoPair(_loc3_,null);
               DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_SERVER_TIME,this.m_diPair);
               this.m_diPairStamp = new DataInfoPair(this.m_serverTimeComputed,null);
               DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_SERVER_TIME_STAMP,this.m_diPairStamp);
            }
            else
            {
               this.m_diPair.dataInfo = _loc3_;
               this.m_diPair.updateTimeStamp();
               this.m_diPairStamp.dataInfo = this.m_serverTimeComputed;
               this.m_diPairStamp.updateTimeStamp();
            }
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_SERVER_TIME_LOADED,this.m_diPair);
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_SERVER_TIME_STAMP_LOADED,this.m_diPairStamp);
         }
      }
   }
}

