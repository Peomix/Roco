package DataInfoCenterUtil.DataInfoAdapter.template
{
   import DataInfoCenterUtil.DataInfoCenter;
   import flash.utils.getTimer;
   
   public class DataInfoAdapterBase
   {
       
      
      public var isRegClassInstance:Boolean;
      
      protected var m_isLoading:Boolean;
      
      protected var m_isResidentDataInfo:Boolean;
      
      protected var m_dataInfoType:int;
      
      protected var m_hash:Object;
      
      private var m_startLoadingTimer:int;
      
      public function DataInfoAdapterBase()
      {
         super();
      }
      
      public function get isResidentDataInfo() : Boolean
      {
         return this.m_isResidentDataInfo;
      }
      
      public function get dataInfoType() : int
      {
         return this.m_dataInfoType;
      }
      
      public function get hash() : Object
      {
         return this.m_hash;
      }
      
      public function get isLoading() : Boolean
      {
         return this.m_isLoading;
      }
      
      public function get startLoadingTimer() : int
      {
         return this.m_startLoadingTimer;
      }
      
      protected function updateStartLoadingTimer() : void
      {
         this.m_startLoadingTimer = getTimer();
      }
      
      public function setLoadArgs(param1:int, param2:Object) : void
      {
         this.m_dataInfoType = param1;
         this.m_hash = param2;
      }
      
      public function load() : void
      {
      }
      
      public function createNew() : DataInfoAdapterBase
      {
         var _loc1_:Class = this["constructor"];
         return new _loc1_() as DataInfoAdapterBase;
      }
      
      public function canDealDataInfoType(param1:int) : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
         if(!this.isRegClassInstance)
         {
            DataInfoCenter.getInstance().removeAdapterQueue(this);
         }
         this.m_hash = null;
      }
   }
}
