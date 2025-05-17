package com.QQ.angel.data.templateAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   import com.QQ.angel.api.net.protocol.ADFHead;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class DataInfoAdapterSocketMonitor extends DataInfoAdapterBase
   {
      
      protected var m_netCmdArray:Array;
      
      public function DataInfoAdapterSocketMonitor()
      {
         super();
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_DECODED_DATA,onGetSocketData,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_DECODED_DATA,onGetSocketData,this);
      }
      
      private static function onGetSocketData(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc7_:ADFHead = null;
         var _loc8_:ProtocolBase = null;
         var _loc5_:DataInfoAdapterSocketMonitor = param4 as DataInfoAdapterSocketMonitor;
         var _loc6_:Array = param2 as Array;
         if(_loc5_.m_netCmdArray)
         {
            _loc7_ = _loc6_[1] as ADFHead;
            if((Boolean(_loc7_)) && _loc5_.m_netCmdArray.indexOf(_loc7_.cmdID) != -1)
            {
               _loc8_ = ProtocolBase(_loc6_[0]);
               _loc5_.onDataGetted(_loc8_);
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
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_DECODED_DATA,onGetSocketData,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_DECODED_DATA,onGetSocketData,this);
         this.m_netCmdArray = null;
         super.dispose();
      }
      
      public function onDataGetted(param1:ProtocolBase) : void
      {
      }
   }
}

