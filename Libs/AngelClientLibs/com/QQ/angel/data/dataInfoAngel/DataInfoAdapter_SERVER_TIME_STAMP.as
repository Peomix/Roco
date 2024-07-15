package com.QQ.angel.data.dataInfoAngel
{
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   
   public class DataInfoAdapter_SERVER_TIME_STAMP extends DataInfoAdapterBase
   {
       
      
      public function DataInfoAdapter_SERVER_TIME_STAMP()
      {
         super();
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return false;
      }
   }
}
