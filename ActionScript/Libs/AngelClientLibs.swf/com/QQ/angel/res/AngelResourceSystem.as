package com.QQ.angel.res
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.res.adapter.SceneRoleResAdapter;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class AngelResourceSystem implements IResourceSysAPI
   {
      
      protected var resAdapters:Dictionary;
      
      protected var resLoadTaskManager:IResLoadTaskManager;
      
      protected var objPools:Dictionary;
      
      protected var sceneRoleResAdpter:SceneRoleResAdapter;
      
      public function AngelResourceSystem()
      {
         super();
         this.resAdapters = new Dictionary();
         this.resLoadTaskManager = new ResLoadTaskManager();
         this.resLoadTaskManager.createVipChannel(Constants.SMALL_RES);
         this.objPools = new Dictionary();
      }
      
      public function getResLoadTaskManager() : IResLoadTaskManager
      {
         return this.resLoadTaskManager;
      }
      
      public function addResAdapter(param1:IResAdapter) : void
      {
         if(param1 == null || this.getResAdapter(param1.getAdapterResType()) != null)
         {
            throw new Error("类型为" + param1.getAdapterResType() + "的资源适配器已经加入!!");
         }
         this.resAdapters[param1.getAdapterResType()] = param1;
         param1.setResLoadTaskManager(this.resLoadTaskManager);
         param1.initialize();
         this.sceneRoleResAdpter = new SceneRoleResAdapter(this.resLoadTaskManager);
      }
      
      public function getResAdapter(param1:String) : IResAdapter
      {
         return this.resAdapters[param1] as IResAdapter;
      }
      
      public function getMagicClsByID(param1:uint) : Class
      {
         var _loc3_:Class = null;
         var _loc2_:String = "com.QQ.angel.assets.magic.Magic_" + param1;
         if(ApplicationDomain.currentDomain.hasDefinition(_loc2_))
         {
            _loc3_ = getDefinitionByName(_loc2_) as Class;
            trace("[AngelResourceSystem] ########找到相应的魔法类!" + _loc2_);
         }
         return _loc3_;
      }
      
      public function getEffectClsByID(param1:uint) : Class
      {
         var cls:Class = null;
         var id:uint = param1;
         var clsPath:String = "com.QQ.angel.assets.effect.Effect_" + id;
         try
         {
            cls = getDefinitionByName(clsPath) as Class;
         }
         catch(error:Error)
         {
         }
         return cls;
      }
      
      public function borrowObj(param1:uint, param2:int = 0) : Object
      {
         var _loc5_:Class = null;
         var _loc6_:CFunction = null;
         var _loc7_:Object = null;
         var _loc8_:MovieClip = null;
         var _loc3_:String = "T_" + param2 + "_" + param1;
         var _loc4_:Array = this.objPools[_loc3_];
         if(_loc4_ == null)
         {
            this.objPools[_loc3_] = _loc4_ = [];
         }
         if(_loc4_.length == 0)
         {
            _loc5_ = (param2 == 0 ? this.getMagicClsByID : this.getEffectClsByID)(param1);
            if(_loc5_ != null)
            {
               return new _loc5_();
            }
            if(param2 == 0)
            {
               _loc6_ = new CFunction(null);
               this.sceneRoleResAdpter.requestMagic(param1,_loc6_);
               return _loc6_;
            }
            return new MovieClip();
         }
         _loc7_ = _loc4_.pop();
         _loc8_ = _loc7_ as MovieClip;
         if(_loc8_ != null)
         {
            _loc8_.gotoAndPlay(1);
         }
         return _loc7_;
      }
      
      public function giveBackObj(param1:uint, param2:Object, param3:int = 0) : void
      {
         var _loc4_:String = "T_" + param3 + "_" + param1;
         var _loc5_:Array = this.objPools[_loc4_];
         if(_loc5_ == null)
         {
            this.objPools[_loc4_] = _loc5_ = [];
         }
         var _loc6_:MovieClip = param2 as MovieClip;
         if(_loc6_ != null)
         {
            _loc6_.gotoAndStop("BLANK");
         }
         _loc5_.push(param2);
      }
      
      public function borrowObjByUrl(param1:String, param2:String) : Object
      {
         var _loc5_:Class = null;
         var _loc6_:CFunction = null;
         var _loc7_:Object = null;
         var _loc8_:MovieClip = null;
         var _loc3_:String = param1 + "_" + param2;
         var _loc4_:Array = this.objPools[_loc3_];
         if(_loc4_ == null)
         {
            this.objPools[_loc3_] = _loc4_ = [];
         }
         if(_loc4_.length == 0)
         {
            if(ApplicationDomain.currentDomain.hasDefinition(param2))
            {
               _loc5_ = getDefinitionByName(param2) as Class;
            }
            if(_loc5_ != null)
            {
               return new _loc5_();
            }
            _loc6_ = new CFunction(null);
            this.sceneRoleResAdpter.requestMagicByUrl(param1,_loc6_);
            return _loc6_;
         }
         _loc7_ = _loc4_.pop();
         _loc8_ = _loc7_ as MovieClip;
         if(_loc8_ != null)
         {
            _loc8_.gotoAndPlay(1);
         }
         return _loc7_;
      }
      
      public function giveBackObjByUrl(param1:String, param2:String, param3:Object) : void
      {
         var _loc4_:String = param1 + "_" + param2;
         var _loc5_:Array = this.objPools[_loc4_];
         if(_loc5_ == null)
         {
            this.objPools[_loc4_] = _loc5_ = [];
         }
         var _loc6_:MovieClip = param3 as MovieClip;
         if(_loc6_ != null)
         {
            _loc6_.gotoAndStop("BLANK");
         }
         _loc5_.push(param3);
      }
   }
}

