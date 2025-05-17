package DataInfoCenterUtil
{
   import DataInfoCenterUtil.DataInfoAdapter.template.DataInfoAdapterBase;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class DataInfoCenter
   {
      
      private static var ins:DataInfoCenter;
      
      private static const MAX_REQUEST:int = 6;
      
      private static const LOADING_TIMEOUT_TIME:int = 60000;
      
      private static const DATAINFO_TYPE_ALL:int = -1;
      
      private static var DATAINFO_TYPE_MAX:int = 0;
      
      private var m_errorUrlArray:Array;
      
      private var m_adapterRegedArray:Array;
      
      private var m_adapterQueueArray:Array;
      
      private var m_loadingNum:int;
      
      private var m_dataInfoPool:Array;
      
      private var m_getStringFunc:Function;
      
      public function DataInfoCenter()
      {
         super();
      }
      
      public static function getInstance() : DataInfoCenter
      {
         if(ins == null)
         {
            ins = new DataInfoCenter();
         }
         return ins;
      }
      
      public function init(param1:int, param2:Function) : void
      {
         var _loc3_:int = 0;
         DATAINFO_TYPE_MAX = param1;
         this.m_getStringFunc = param2;
         if(!this.m_errorUrlArray)
         {
            this.m_errorUrlArray = new Array();
            this.m_adapterRegedArray = [];
            this.m_adapterQueueArray = [];
            this.m_dataInfoPool = new Array();
            this.m_dataInfoPool.length = DATAINFO_TYPE_MAX;
            _loc3_ = 0;
            while(_loc3_ < DATAINFO_TYPE_MAX)
            {
               this.m_dataInfoPool[_loc3_] = new Array();
               _loc3_++;
            }
         }
      }
      
      public function registerAdapterArray(param1:Array) : void
      {
         var _loc2_:Class = null;
         for each(_loc2_ in param1)
         {
            this.registerAdapter(_loc2_);
         }
      }
      
      public function registerAdapter(param1:Class) : void
      {
         var _loc4_:DataInfoAdapterBase = null;
         var _loc2_:DataInfoAdapterBase = DataInfoAdapterBase(new param1());
         _loc2_.isRegClassInstance = true;
         var _loc3_:String = getQualifiedClassName(_loc2_);
         for each(_loc4_ in this.m_adapterRegedArray)
         {
            if(getQualifiedClassName(_loc4_) == _loc3_)
            {
               _loc2_.dispose();
               return;
            }
         }
         if(this.m_adapterRegedArray)
         {
            this.m_adapterRegedArray.push(_loc2_);
         }
      }
      
      public function getDataInfoTypeString(param1:int) : String
      {
         if(this.m_getStringFunc != null)
         {
            return this.m_getStringFunc(param1);
         }
         return "";
      }
      
      private function addAdapterQueue(param1:DataInfoAdapterBase) : void
      {
         if(!this.m_adapterQueueArray)
         {
            return;
         }
         this.m_adapterQueueArray.push(param1);
      }
      
      public function removeAdapterQueue(param1:DataInfoAdapterBase) : void
      {
         if(!this.m_adapterQueueArray)
         {
            return;
         }
         var _loc2_:int = int(this.m_adapterQueueArray.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.m_adapterQueueArray.splice(_loc2_,1);
         }
         var _loc3_:int = getTimer();
         var _loc4_:int = 0;
         while(_loc4_ < MAX_REQUEST && _loc4_ < this.m_adapterQueueArray.length)
         {
            param1 = DataInfoAdapterBase(this.m_adapterQueueArray[_loc4_]);
            if(!param1.isLoading)
            {
               param1.load();
               if(param1 == this.m_adapterQueueArray[_loc4_])
               {
                  _loc4_++;
               }
            }
            else if(_loc3_ - param1.startLoadingTimer > LOADING_TIMEOUT_TIME)
            {
               param1.dispose();
               if(param1 == this.m_adapterQueueArray[_loc4_])
               {
                  _loc4_++;
               }
            }
            else
            {
               _loc4_++;
            }
         }
      }
      
      public function addDataInfoPair(param1:int, param2:DataInfoPair) : void
      {
         var _loc3_:Array = null;
         var _loc4_:DataInfoPair = null;
         if(this.m_dataInfoPool)
         {
            _loc3_ = this.m_dataInfoPool[param1] as Array;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.hash == param2.hash)
               {
                  return;
               }
            }
            param2.grab(this);
            _loc3_.push(param2);
         }
      }
      
      public function getDataInfoPair(param1:int, param2:Object) : DataInfoPair
      {
         var _loc3_:Array = null;
         var _loc4_:DataInfoPair = null;
         if(this.m_dataInfoPool)
         {
            _loc3_ = this.m_dataInfoPool[param1] as Array;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.hash == param2)
               {
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         var _loc1_:DataInfoAdapterBase = null;
         this.reset();
         this.m_errorUrlArray = null;
         this.m_adapterQueueArray = null;
         if(this.m_dataInfoPool)
         {
            this.m_dataInfoPool.length = 0;
            this.m_dataInfoPool = null;
         }
         if(this.m_adapterRegedArray)
         {
            for each(_loc1_ in this.m_adapterRegedArray)
            {
               _loc1_.dispose();
            }
            this.m_adapterRegedArray.length = 0;
            this.m_adapterRegedArray = null;
         }
         if(ins == this)
         {
            ins = null;
         }
      }
      
      public function isErrorUrl(param1:String) : Boolean
      {
         return param1 != null && Boolean(this.m_errorUrlArray) && this.m_errorUrlArray.indexOf(param1) != -1;
      }
      
      public function addErrorUrl(param1:String) : void
      {
         if(Boolean(this.m_errorUrlArray) && this.m_errorUrlArray.indexOf(param1) == -1)
         {
            this.m_errorUrlArray.push(param1);
         }
      }
      
      public function applyDataInfo(param1:int, param2:Object) : Boolean
      {
         var _loc3_:DataInfoAdapterBase = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:DataInfoAdapterBase = null;
         var _loc7_:DataInfoAdapterBase = null;
         var _loc8_:DataInfoAdapterBase = null;
         var _loc9_:int = 0;
         for each(_loc3_ in this.m_adapterQueueArray)
         {
            if(_loc3_.dataInfoType == param1 && _loc3_.hash == param2)
            {
               return true;
            }
         }
         _loc4_ = getTimer();
         _loc5_ = 0;
         while(_loc5_ < MAX_REQUEST && _loc5_ < this.m_adapterQueueArray.length)
         {
            _loc7_ = DataInfoAdapterBase(this.m_adapterQueueArray[_loc5_]);
            if(!_loc7_.isLoading)
            {
               _loc7_.load();
               if(_loc7_ == this.m_adapterQueueArray[_loc5_])
               {
                  _loc5_++;
               }
            }
            else if(_loc4_ - _loc7_.startLoadingTimer > LOADING_TIMEOUT_TIME)
            {
               _loc7_.dispose();
               if(_loc7_ == this.m_adapterQueueArray[_loc5_])
               {
                  _loc5_++;
               }
            }
            else
            {
               _loc5_++;
            }
         }
         for each(_loc6_ in this.m_adapterRegedArray)
         {
            if(_loc6_.canDealDataInfoType(param1))
            {
               _loc8_ = _loc6_.createNew();
               this.addAdapterQueue(_loc8_);
               _loc9_ = int(this.m_adapterQueueArray.indexOf(_loc8_));
               _loc8_.setLoadArgs(param1,param2);
               if(_loc9_ < MAX_REQUEST || _loc8_.isResidentDataInfo)
               {
                  _loc8_.load();
               }
               return true;
            }
         }
         return false;
      }
      
      public function reset() : void
      {
         this.diposeDataInfoArray(DATAINFO_TYPE_ALL);
         if(this.m_errorUrlArray)
         {
            this.m_errorUrlArray.length = 0;
         }
         if(this.m_adapterQueueArray)
         {
            while(this.m_adapterQueueArray.length)
            {
               this.m_adapterQueueArray[0].dispose();
            }
         }
      }
      
      public function diposeDataInfo(param1:int, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc4_:DataInfoPair = null;
         if(this.m_dataInfoPool)
         {
            _loc3_ = this.m_dataInfoPool[param1] as Array;
            for each(_loc4_ in _loc3_)
            {
               if(_loc4_.hash == param2)
               {
                  _loc4_.drop(this);
                  _loc3_.splice(_loc3_.indexOf(_loc4_),1);
                  return;
               }
            }
         }
      }
      
      public function diposeDataInfoArray(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:DataInfoPair = null;
         if(this.m_dataInfoPool)
         {
            if(param1 == DATAINFO_TYPE_ALL)
            {
               for each(_loc2_ in this.m_dataInfoPool)
               {
                  for each(_loc3_ in _loc2_)
                  {
                     _loc3_.drop(this);
                  }
                  _loc2_.length = 0;
               }
            }
            else
            {
               _loc2_ = this.m_dataInfoPool[param1] as Array;
               for each(_loc3_ in _loc2_)
               {
                  _loc3_.drop(this);
               }
               _loc2_.length = 0;
            }
         }
      }
      
      public function stopLoading(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:DataInfoAdapterBase = null;
         _loc2_ = 0;
         while(_loc2_ < this.m_adapterQueueArray.length)
         {
            _loc3_ = DataInfoAdapterBase(this.m_adapterQueueArray[_loc2_]);
            if(param1 == DATAINFO_TYPE_ALL || _loc3_.dataInfoType == param1)
            {
               _loc3_.dispose();
            }
            else
            {
               _loc2_++;
            }
         }
      }
   }
}

