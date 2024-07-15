package com.QQ.angel.res.adapter
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.data.entity.combatsys.SpiritSkillDes;
   import com.QQ.angel.data.entity.combatsys.pool.*;
   import com.QQ.angel.data.entity.combatsys.utils.CombatResType;
   import com.QQ.angel.data.entity.combatsys.vo.*;
   import com.QQ.angel.res.BitmapDataAsset;
   import com.QQ.angel.res.ICombatResAdapter;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   
   public class AngelCombatResAdapter extends EventDispatcher implements ICombatResAdapter
   {
       
      
      private var _resLoadManager:IResLoadTaskManager;
      
      private var _resTask:ResLoadTask;
      
      private var _currentPool:ICombatResPool;
      
      private var _isAllComplete:Boolean = true;
      
      private var _paths:Array;
      
      public var itemsLoaded:uint = 0;
      
      public var itemsTotal:uint = 0;
      
      private var _commonPool:CommonCombatResPool;
      
      private var _iconPool:IconCombatResPool;
      
      private var _buffPool:BuffCombatResPool;
      
      public function AngelCombatResAdapter()
      {
         this._paths = [];
         super();
      }
      
      public function initialize(... rest) : void
      {
         this._resTask = new ResLoadTask();
         this._resTask.resType = this.getAdapterResType();
         if(this.onSWFProgress != null)
         {
            this._resTask.progressHandler = new CFunction(this.onSWFProgress,this);
         }
         if(this.onSWFError != null)
         {
            this._resTask.errorHandler = new CFunction(this.onSWFError,this);
         }
         if(this.onSWFComplete != null)
         {
            this._resTask.completeHandler = new CFunction(this.onSWFComplete,this);
         }
         if(this.onSWFAllComplete != null)
         {
            this._resTask.allCompleteHandler = new CFunction(this.onSWFAllComplete,this);
         }
         this._resLoadManager.createVipChannel(this.getAdapterResType());
         this._commonPool = new CommonCombatResPool();
         this._iconPool = new IconCombatResPool();
         this._iconPool.onCompleteHandler(null);
         this._buffPool = new BuffCombatResPool();
         this._buffPool.pool = this._commonPool;
      }
      
      public function finalize() : void
      {
      }
      
      public function setResLoadTaskManager(param1:IResLoadTaskManager) : void
      {
         this._resLoadManager = param1;
      }
      
      public function requestRes(... rest) : Object
      {
         if(this._isAllComplete)
         {
            this._isAllComplete = false;
            this._paths = rest[0];
            this.load(this._paths[0]);
            this.itemsLoaded = 0;
            this.itemsTotal = this._paths.length;
         }
         else
         {
            this._paths = this._paths.concat(rest[0]);
            this.itemsTotal = this._paths.length;
         }
         return null;
      }
      
      public function cancelRequest(... rest) : Boolean
      {
         return true;
      }
      
      public function disposeRes(... rest) : void
      {
      }
      
      public function getAdapterResType() : String
      {
         return "combatResAdapter";
      }
      
      public function removeAllCacheRes() : void
      {
      }
      
      public function stopAllResRequest() : void
      {
      }
      
      public function getSpiritIdleMC(param1:uint, param2:Function) : MovieClip
      {
         var _loc4_:CombatLoadResVO = null;
         var _loc5_:IDataProxy = null;
         var _loc6_:int = 0;
         var _loc3_:CombatResVO = this._commonPool.getResPool(param1,CombatResType.TYPE_SPIRIT_PREVIEW);
         if(_loc3_ == null)
         {
            (_loc4_ = new CombatLoadResVO()).id = param1;
            _loc4_.linkName = "Spirit";
            _loc4_.policy = CombatResType.POLICY_DEFAULT;
            _loc4_.resPool = this._commonPool;
            _loc4_.type = CombatResType.TYPE_SPIRIT_PREVIEW;
            _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
            if(param1 > 100000 && param1 < 200000)
            {
               _loc6_ = int(param1 / 10) - 10000;
               _loc4_.url = SpiritDes(_loc5_.select(_loc6_)).previewSrc.split("previews/")[0] + "previews/" + (100000 + int(SpiritDes(_loc5_.select(_loc6_)).previewSrc.split("previews/")[1].split("-idle.swf")[0]) * 10 + param1 % 10) + "-idle.swf" + SpiritDes(_loc5_.select(_loc6_)).previewSrc.split("previews/")[1].split("-idle.swf")[1];
            }
            else
            {
               _loc4_.url = SpiritDes(_loc5_.select(param1)).previewSrc;
            }
            _loc4_.callBack = param2;
            this.requestRes([_loc4_]);
            return null;
         }
         if(param2 != null)
         {
            param2(_loc3_.display);
         }
         return _loc3_.display;
      }
      
      public function returnSpiritIdleMC(param1:String) : void
      {
         this._commonPool.removeResPool(param1);
      }
      
      public function getSpiritImage(param1:uint, param2:Function) : BitmapDataAsset
      {
         var _loc4_:CombatLoadResVO = null;
         var _loc5_:IDataProxy = null;
         var _loc6_:int = 0;
         var _loc3_:CombatResVO = this._commonPool.getResPool(param1,CombatResType.TYPE_SPIRIT_ICON);
         if(_loc3_ == null)
         {
            (_loc4_ = new CombatLoadResVO()).id = param1;
            _loc4_.policy = CombatResType.POLICY_DEFAULT;
            _loc4_.resPool = this._commonPool;
            _loc4_.type = CombatResType.TYPE_SPIRIT_ICON;
            _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
            if(param1 > 100000 && param1 < 200000)
            {
               _loc6_ = int(param1 / 10) - 10000;
               _loc4_.url = SpiritDes(_loc5_.select(_loc6_)).iconSrc.split("icons/")[0] + "icons/" + (100000 + int(SpiritDes(_loc5_.select(_loc6_)).iconSrc.split("icons/")[1].split("-.png")[0]) * 10 + param1 % 10) + "-.png" + SpiritDes(_loc5_.select(_loc6_)).iconSrc.split("icons/")[1].split("-.png")[1];
            }
            else
            {
               _loc4_.url = SpiritDes(_loc5_.select(param1)).iconSrc;
            }
            _loc4_.callBack = param2;
            this.requestRes([_loc4_]);
            return null;
         }
         if(param2 != null)
         {
            param2(_loc3_.display);
         }
         return _loc3_.display;
      }
      
      public function returnSpiritImage(param1:String) : void
      {
         this._commonPool.removeResPool(param1);
      }
      
      public function getSuperSkillBgImage(param1:uint, param2:Function) : BitmapDataAsset
      {
         var _loc4_:CombatLoadResVO = null;
         var _loc5_:IDataProxy = null;
         var _loc3_:CombatResVO = this._commonPool.getResPool(param1,CombatResType.TYPE_SUPER_SKILL_BG);
         if(_loc3_ == null)
         {
            (_loc4_ = new CombatLoadResVO()).id = param1;
            _loc4_.policy = CombatResType.POLICY_DEFAULT;
            _loc4_.resPool = this._commonPool;
            _loc4_.type = CombatResType.TYPE_SUPER_SKILL_BG;
            _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SSKILL_DATA);
            _loc4_.url = SpiritSkillDes(_loc5_.select(param1)).superSkillBgSrc;
            _loc4_.callBack = param2;
            this.requestRes([_loc4_]);
            return null;
         }
         if(param2 != null)
         {
            param2(_loc3_.display);
         }
         return _loc3_.display;
      }
      
      public function returnSuperSkillBgImage(param1:String) : void
      {
         this._commonPool.removeResPool(param1);
      }
      
      public function getSpiritSkillImage(param1:int) : BitmapData
      {
         return this._iconPool.getResPool(param1).display as BitmapData;
      }
      
      public function getSpiritGroupImage(param1:int) : BitmapData
      {
         return this._iconPool.getResPool(param1 + 500).display as BitmapData;
      }
      
      public function onSWFProgress(param1:LoadTaskEvent) : void
      {
         param1.resData.itemsLoaded = this.itemsLoaded;
         param1.resData.itemsTotal = this.itemsTotal;
         this.dispatchEvent(param1);
      }
      
      public function onSWFError(param1:LoadTaskEvent) : void
      {
         this.isAllComplete();
      }
      
      public function onSWFComplete(param1:LoadTaskEvent) : void
      {
         this._currentPool.onCompleteHandler(param1.resData);
         this.isAllComplete();
      }
      
      public function onSWFAllComplete(param1:LoadTaskEvent) : void
      {
      }
      
      private function load(param1:CombatLoadResVO) : void
      {
         this._currentPool = param1.resPool;
         var _loc2_:Boolean = this._currentPool.splicePath(param1);
         if(_loc2_)
         {
            this.isAllComplete();
            return;
         }
         this._resTask.paths = [param1];
         this._resLoadManager.addLoadTask(this._resTask);
      }
      
      private function isAllComplete() : void
      {
         ++this.itemsLoaded;
         this._paths.shift();
         if(this._paths.length <= 0)
         {
            this._isAllComplete = true;
            this.dispatchEvent(new LoadTaskEvent(LoadTaskEvent.TASK_COMPLETE));
         }
         else
         {
            this.load(this._paths[0]);
         }
      }
      
      public function get commonCombatResPool() : CommonCombatResPool
      {
         return this._commonPool;
      }
      
      public function get iconCombatResPool() : IconCombatResPool
      {
         return this._iconPool;
      }
      
      public function get buffCombatResPool() : BuffCombatResPool
      {
         return this._buffPool;
      }
   }
}
