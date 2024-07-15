package com.QQ.angel.data.templateAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   
   public class DataInfoAdapterRequest extends DataInfoAdapterBase
   {
       
      
      protected var m_protocolBase:ProtocolBase;
      
      public function DataInfoAdapterRequest()
      {
         super();
      }
      
      override public function dispose() : void
      {
         this.m_protocolBase = null;
         super.dispose();
      }
      
      public function onDataGetted(param1:ProtocolBase) : void
      {
         m_isLoading = false;
         this.dispose();
      }
      
      override public function load() : void
      {
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL,[this.m_protocolBase,this.onDataGetted]);
         this.m_protocolBase = null;
         m_isLoading = true;
         updateStartLoadingTimer();
      }
   }
}
