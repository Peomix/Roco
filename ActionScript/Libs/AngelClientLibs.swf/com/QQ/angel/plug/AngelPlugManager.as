package com.QQ.angel.plug
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IParamsAware;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.plug.IPlugLib;
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.api.plug.extension.IExtensionRegistry;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.CmdExeDes;
   import com.QQ.angel.data.entity.PluginCallDes;
   import com.QQ.angel.plug.extension.AngelExtensionRegistry;
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class AngelPlugManager implements IAngelPluginManager, IAngelSysAPIAware, ICmdListener
   {
      
      private var _plugNum:uint = 0;
      
      protected var plugList:Dictionary;
      
      protected var angelSysAPI:IAngelSysAPI;
      
      protected var sysResAdapter:IResAdapter;
      
      protected var gEvent:IEventDispatcher;
      
      protected var settingManager:PluginSettingManager;
      
      protected var angelER:IExtensionRegistry;
      
      private var installPluginObj:Object;
      
      public function AngelPlugManager()
      {
         this.installPluginObj = {"installPlugin":this.installPlugin};
         super();
      }
      
      private static function onInstallOrCallPlugin(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:Array = param2 as Array;
         var _loc6_:AngelPlugManager = AngelPlugManager(param4);
         if((Boolean(_loc6_)) && Boolean(_loc5_))
         {
            if(_loc5_[0])
            {
               if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_SYNC)
               {
                  _loc6_.installPlugin(_loc5_[0],true);
               }
               else if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_ASYNC)
               {
                  _loc6_.installPlugin(_loc5_[0],false);
               }
               else if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC)
               {
                  _loc6_.callPlugin(_loc5_[0],_loc5_[1],true,true);
               }
               else if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC)
               {
                  _loc6_.callPlugin(_loc5_[0],_loc5_[1],true,false);
               }
               else if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_IF_INSTALLED)
               {
                  _loc6_.callPlugin(_loc5_[0],_loc5_[1],false,true);
               }
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function dispose() : void
      {
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_SYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_ASYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_IF_INSTALLED,AngelPlugManager.onInstallOrCallPlugin,this);
      }
      
      protected function install2(param1:IPlugProgram, param2:PluginSetting) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var _loc3_:String = getQualifiedClassName(param1);
         if(param2 == null)
         {
            param2 = this.settingManager.getSettingByName(_loc3_);
         }
         param1.setPlugName(_loc3_);
         _loc3_ = param1.getPlugName();
         if(this.hasPlug(_loc3_))
         {
            return false;
         }
         if(param2 != null && param2.plugName != _loc3_)
         {
            throw new Error("[AngelPlugManager] 配置文件的插件名[" + param2.plugName + "]与实际插件名[" + _loc3_ + "]不相符!!");
         }
         this.plugList[_loc3_] = param1;
         ++this._plugNum;
         if(param2 != null && param2.params != null && param1 is IParamsAware)
         {
            (param1 as IParamsAware).setParams(param2.params);
         }
         param1.setAngelSysAPI(this.angelSysAPI);
         var _loc4_:String = _loc3_.substring(_loc3_.lastIndexOf("::") + 2,_loc3_.length - 6);
         var _loc5_:Boolean = param1.initialize();
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_ON_A_PLUGIN_INSTALLED,[param1,_loc3_,_loc4_]);
         return _loc5_;
      }
      
      public function installPlugin(param1:String, param2:Boolean = true) : void
      {
         var _loc3_:IPlugProgram = this.getPlugByName(param1);
         if(_loc3_)
         {
            return;
         }
         var _loc4_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.CMDLIS_NOT_FOUND);
         var _loc5_:CmdExeDes = new CmdExeDes();
         _loc5_.cmdType = param1;
         _loc5_.arg = this.installPluginObj;
         _loc4_.data = _loc5_;
         this.onPlugNotFound(_loc4_,null,false,param2);
      }
      
      public function callPlugin(param1:String, param2:Object = null, param3:Boolean = true, param4:Boolean = true) : void
      {
         var _loc5_:IPlugProgram = this.getPlugByName("com.QQ.angel.plugs." + param1 + "::" + param1 + "Plugin");
         if(_loc5_)
         {
            _loc5_.call(param2);
            return;
         }
         if(!param3)
         {
            return;
         }
         var _loc6_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.CMDLIS_NOT_FOUND);
         var _loc7_:CmdExeDes = new CmdExeDes();
         _loc7_.cmdType = param1;
         _loc7_.arg = param2;
         _loc6_.data = _loc7_;
         this.onPlugNotFound(_loc6_,null,true,param4);
      }
      
      protected function onPlugNotFound(param1:AngelSysEvent, param2:CmdExeDes = null, param3:Boolean = true, param4:Boolean = true) : void
      {
         var setting:PluginSetting;
         var plugProgram:IPlugProgram;
         var params:InstallParams = null;
         var PlugCls:Class = null;
         var ipp:IPlugProgram = null;
         var event:AngelSysEvent = param1;
         var exeDes:CmdExeDes = param2;
         var withCall:Boolean = param3;
         var syncLoad:Boolean = param4;
         if(exeDes == null)
         {
            exeDes = event.data as CmdExeDes;
         }
         if(exeDes == null)
         {
            return;
         }
         setting = this.settingManager.getSettingByCMDT(exeDes.cmdType);
         if(setting == null)
         {
            return;
         }
         plugProgram = this.getPlugByName(setting.plugName);
         if(plugProgram == null)
         {
            try
            {
               PlugCls = ApplicationDomain.currentDomain.getDefinition(setting.plugName) as Class;
            }
            catch(e:Error)
            {
            }
            if(PlugCls != null)
            {
               ipp = new PlugCls() as IPlugProgram;
               if(ipp)
               {
                  this.install(ipp);
                  if(withCall)
                  {
                     ipp.call(exeDes.arg);
                  }
                  return;
               }
            }
            params = new InstallParams(setting,null,null);
            params.loadType = syncLoad ? PluginSetting.SYNC_LOAD : PluginSetting.ASYN_LOAD;
            params.exeDes = exeDes;
            params.context = null;
            if(setting.domain)
            {
               if(setting.domain == "current")
               {
                  params.context = new LoaderContext(false,ApplicationDomain.currentDomain);
               }
               else if(setting.domain == "single")
               {
                  params.context = new LoaderContext(false,new ApplicationDomain());
               }
            }
            if(withCall)
            {
               PluginFactory.getInstance().createAndInstallAndCall(params);
            }
            else
            {
               PluginFactory.getInstance().createAndInstall(params);
            }
         }
         else if(withCall)
         {
            plugProgram.call(exeDes.arg);
         }
      }
      
      public function initialize() : void
      {
         this.plugList = new Dictionary();
         this.gEvent = this.angelSysAPI.getGEventAPI().angelEventDispatcher;
         this.gEvent.addEventListener(AngelSysEvent.CMDLIS_NOT_FOUND,this.onPlugNotFound);
         var _loc1_:Object = this.angelSysAPI.getGDataAPI().getGlobalVal(Constants.CONFS);
         var _loc2_:String = _loc1_["plugin_conf"];
         if(!_loc2_)
         {
            _loc2_ = _loc1_["plugins_conf"];
         }
         this.settingManager = new PluginSettingManager(_loc2_);
         _loc1_["plugin_conf"] = null;
         _loc1_["plugins_conf"] = null;
         PluginFactory.getInstance(this);
         this.angelSysAPI.getGEventAPI().addCmdListener("onPluginCall",this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_SYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_ASYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC,AngelPlugManager.onInstallOrCallPlugin,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_IF_INSTALLED,AngelPlugManager.onInstallOrCallPlugin,this);
      }
      
      public function installStepPlugins(param1:int) : void
      {
         var _loc4_:PluginSetting = null;
         var _loc5_:Class = null;
         var _loc2_:Array = this.settingManager.getSettingByStep(param1);
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            _loc5_ = getDefinitionByName(_loc4_.plugName) as Class;
            this.install2(new _loc5_() as IPlugProgram,_loc4_);
            _loc3_++;
         }
      }
      
      public function call(param1:Object) : *
      {
         var _loc2_:PluginCallDes = param1 as PluginCallDes;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:CmdExeDes = new CmdExeDes();
         _loc3_.cmdType = _loc2_.cmdType;
         this.onPlugNotFound(null,_loc3_);
      }
      
      public function loadAndInstallPlug(param1:String, param2:String, param3:CFunction = null, param4:LoaderContext = null) : void
      {
         var _loc5_:PluginSetting = this.getSettingByName(param2);
         if(_loc5_ == null)
         {
            _loc5_ = new PluginSetting();
            _loc5_.plugSrc = param1;
            _loc5_.plugName = param2;
            _loc5_.loadType = PluginSetting.SYNC_LOAD;
            _loc5_.plugLabel = "";
         }
         var _loc6_:InstallParams = new InstallParams(_loc5_,param3,param4);
         PluginFactory.getInstance().createAndInstallAndCall(_loc6_);
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysAPI = param1;
      }
      
      public function getSys() : IAngelSysAPI
      {
         return this.angelSysAPI;
      }
      
      public function install(param1:IPlugProgram) : Boolean
      {
         return this.install2(param1,null);
      }
      
      public function installFromLib(param1:IPlugLib, param2:PluginSetting) : IPlugProgram
      {
         if(param1 == null)
         {
            return null;
         }
         var _loc3_:Array = param1.getPlugClasses();
         var _loc4_:IPlugProgram = null;
         _loc4_ = new _loc3_[0]() as IPlugProgram;
         this.install2(_loc4_,param2);
         return _loc4_;
      }
      
      public function hasPlug(param1:String) : Boolean
      {
         if(param1.indexOf("com.QQ.") != 0)
         {
            param1 = "com.QQ.angel.plugs." + param1 + "::" + param1 + "Plugin";
         }
         if(this.plugList[param1])
         {
            return true;
         }
         return false;
      }
      
      public function getPlugByName(param1:String) : IPlugProgram
      {
         if(param1.indexOf("com.QQ.") != 0)
         {
            param1 = "com.QQ.angel.plugs." + param1 + "::" + param1 + "Plugin";
         }
         if(this.isValid(param1))
         {
            return this.plugList[param1];
         }
         return null;
      }
      
      public function getPlugList() : Array
      {
         var _loc2_:IPlugProgram = null;
         var _loc1_:Array = new Array();
         for each(_loc2_ in this.plugList)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      public function getExtensionRegistry() : IExtensionRegistry
      {
         if(this.angelER == null)
         {
            this.angelER = new AngelExtensionRegistry();
         }
         return this.angelER;
      }
      
      public function uninstall(param1:String) : Boolean
      {
         if(this.isValid(param1))
         {
            (this.plugList[param1] as IPlugProgram).finalize();
            delete this.plugList[param1];
            --this._plugNum;
            return true;
         }
         return false;
      }
      
      public function getSettingByName(param1:String) : PluginSetting
      {
         return this.settingManager.getSettingByName(param1);
      }
      
      private function isValid(param1:String) : Boolean
      {
         if(this.plugList[param1])
         {
            return true;
         }
         return false;
      }
   }
}

