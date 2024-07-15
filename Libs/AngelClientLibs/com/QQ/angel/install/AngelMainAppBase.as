package com.QQ.angel.install
{
   import CallbackUtil.CallbackCenter;
   import CallbackUtil.CallbackDym;
   import DataInfoCenterUtil.DataInfoCenter;
   import com.QQ.angel.access.AngelAccessPermission;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAccessPermission;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IExternalAPI;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.IGlobalEventAPI;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.IMediaSysAPI;
   import com.QQ.angel.api.IMsgAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.IPlugManagerAPI;
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.IUISysAPI;
   import com.QQ.angel.api.IWorldAPI;
   import com.QQ.angel.api.events.AngelNetSysEvent;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.*;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DATAINFO;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.ServerInfo;
   import com.QQ.angel.data.impl.AGlobalDataManager;
   import com.QQ.angel.debug.Debugger;
   import com.QQ.angel.events.AngelEventManager;
   import com.QQ.angel.external.AngelExternalManger;
   import com.QQ.angel.logging.AngelLogger;
   import com.QQ.angel.media.MediaSysManager;
   import com.QQ.angel.msg.AngelMSGSys;
   import com.QQ.angel.net.center.NetProtocalCenter;
   import com.QQ.angel.net.impl.AngelNetSystem;
   import com.QQ.angel.net.impl.AngelTcpConnection;
   import com.QQ.angel.plug.AngelPlugManager;
   import com.QQ.angel.res.AngelResourceSystem;
   import com.QQ.angel.res.adapter.AngelCombatResAdapter;
   import com.QQ.angel.res.adapter.AngelSystemResAdapter;
   import com.QQ.angel.ui.AngelUISystem;
   import com.QQ.angel.ui.Billboard;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.system.Security;
   import flash.utils.getDefinitionByName;
   
   public class AngelMainAppBase extends Sprite implements IAngelSysAPI, IGreenSystem
   {
      
      public static const VERSION:String = "Angel 1.0Alpha1build081";
       
      
      protected var resourceSysApi:IResourceSysAPI;
      
      protected var uiSysApi:IUISysAPI;
      
      protected var netSysApi:INetSysAPI;
      
      protected var plugManagerApi:IPlugManagerAPI;
      
      private var plugManager:AngelPlugManager;
      
      protected var gEventApi:IGlobalEventAPI;
      
      protected var gDataApi:IGlobalDataAPI;
      
      protected var worldApi:IWorldAPI;
      
      protected var extenrlApi:IExternalAPI;
      
      protected var accPermission:IAccessPermission;
      
      protected var mediaSysApi:IMediaSysAPI;
      
      protected var sysMSGApi:IMsgAPI;
      
      protected var isRender:Boolean = true;
      
      private var globalConf:Object;
      
      private var installHelp:Object;
      
      protected var serverInfo:ServerInfo;
      
      protected var logFun:Function;
      
      private var m_callbackCenterInited:Boolean;
      
      public function AngelMainAppBase()
      {
         this.serverInfo = new ServerInfo();
         super();
         Security.allowDomain("*");
         if(stage)
         {
            this.initStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.initStage);
         }
      }
      
      public function getWorldAPI() : IWorldAPI
      {
         return this.worldApi;
      }
      
      public function getNetSysAPI() : INetSysAPI
      {
         return this.netSysApi;
      }
      
      public function getGDataAPI() : IGlobalDataAPI
      {
         return this.gDataApi;
      }
      
      public function getUISysAPI() : IUISysAPI
      {
         return this.uiSysApi;
      }
      
      public function getGEventAPI() : IGlobalEventAPI
      {
         return this.gEventApi;
      }
      
      public function getMediaSysAPI() : IMediaSysAPI
      {
         return this.mediaSysApi;
      }
      
      public function getResSysAPI() : IResourceSysAPI
      {
         return this.resourceSysApi;
      }
      
      public function getPlugSysAPI() : IPlugManagerAPI
      {
         return this.plugManagerApi;
      }
      
      public function getExternalAPI() : IExternalAPI
      {
         return this.extenrlApi;
      }
      
      public function getAccessPermission() : IAccessPermission
      {
         return this.accPermission;
      }
      
      public function getMSGAPI() : IMsgAPI
      {
         return this.sysMSGApi;
      }
      
      private function initStage(param1:Event = null, param2:Stage = null) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Class = null;
         if(hasEventListener(Event.ADDED_TO_STAGE))
         {
            removeEventListener(Event.ADDED_TO_STAGE,this.initStage);
         }
         if(!param2)
         {
            param2 = this.stage;
         }
         if(param2)
         {
            if(!this.m_callbackCenterInited)
            {
               this.m_callbackCenterInited = true;
               _loc3_ = new Object();
               _loc3_[Event.ENTER_FRAME] = CALLBACK.AS3_ENTER_FRAME;
               _loc3_[MouseEvent.MOUSE_DOWN] = CALLBACK.AS3_STAGE_MOUSE_DOWN;
               _loc3_[MouseEvent.MOUSE_UP] = CALLBACK.AS3_STAGE_MOUSE_UP;
               _loc3_[MouseEvent.MOUSE_MOVE] = CALLBACK.AS3_STAGE_MOUSE_MOVE;
               _loc3_[MouseEvent.MOUSE_WHEEL] = CALLBACK.AS3_STAGE_MOUSE_WHEEL;
               _loc3_[Event.MOUSE_LEAVE] = CALLBACK.AS3_STAGE_MOUSE_LEAVE;
               _loc3_[KeyboardEvent.KEY_DOWN] = CALLBACK.AS3_KEY_DOWN;
               _loc3_[KeyboardEvent.KEY_UP] = CALLBACK.AS3_KEY_UP;
               CallbackCenter.init(param2,_loc3_);
               CallbackDym.s_callbackDymFlag = 2147418112;
               if(_loc4_ == null)
               {
                  _loc4_ = getDefinitionByName("com.QQ.angel.data.PROTOCAL") as Class;
               }
               if(_loc4_ != null)
               {
                  NetProtocalCenter.initClassArray(_loc4_["PROTOCAL_ARRAY"]);
               }
               DataInfoCenter.getInstance().init(DataInfoType.DATAINFO_TYPE_MAX,null);
               DataInfoCenter.getInstance().registerAdapterArray(DATAINFO.DATAINFO_ARRAY);
            }
         }
      }
      
      public function setRender(param1:Boolean = false) : void
      {
         if(this.gEventApi != null)
         {
            this.gEventApi.setRenderTimer(param1);
         }
         if(this.worldApi != null)
         {
            this.worldApi.setRender(param1);
         }
         if(this.uiSysApi != null)
         {
            this.uiSysApi.setUIEnabled(param1);
         }
         if(this.sysMSGApi != null)
         {
            this.sysMSGApi.onRenderChange(param1);
         }
         this.isRender = param1;
      }
      
      public function getIsRender() : Boolean
      {
         return this.isRender;
      }
      
      protected function getServerInfo(param1:Object) : ServerInfo
      {
         var _loc2_:Object = this.extenrlApi.getFlashVar("angel_uin");
         var _loc3_:String = this.extenrlApi.getFlashVar("angel_key") as String;
         var _loc4_:String = this.extenrlApi.getFlashVar("skey") as String;
         var _loc5_:String = this.extenrlApi.getFlashVar("pskey") as String;
         this.serverInfo.dirHost = param1.DirServer.host;
         this.serverInfo.dirPort = param1.DirServer.port;
         if(_loc2_ != null)
         {
            this.serverInfo.uin = uint(_loc2_);
         }
         if(_loc3_ != null)
         {
            this.serverInfo.sessionKey = _loc3_;
         }
         if(_loc4_ != null)
         {
            this.serverInfo.skey = _loc4_;
         }
         if(_loc5_ != null)
         {
            this.serverInfo.pskey = _loc5_;
         }
         return this.serverInfo;
      }
      
      protected function initializeWorld(param1:Object, param2:Object, param3:Sprite) : void
      {
         var _loc8_:Object = null;
         Billboard.src = param1.getBBSrc();
         var _loc4_:Array = param1.DEFINE;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc8_ = _loc4_[_loc5_];
            DEFINE[_loc8_.name] = _loc8_.value;
            _loc5_++;
         }
         this.gEventApi = new AngelEventManager();
         this.extenrlApi = new AngelExternalManger(param3);
         (this.extenrlApi as IAngelSysAPIAware).setAngelSysAPI(this);
         this.uiSysApi = new AngelUISystem();
         (this.uiSysApi as IGreenSystem).initialize(param3);
         var _loc6_:Object;
         (_loc6_ = param2)[Constants.CUR_SERVER_INFO] = this.getServerInfo(param1);
         this.gDataApi = new AGlobalDataManager();
         (this.gDataApi as IGreenSystem).initialize(_loc6_);
         this.resourceSysApi = new AngelResourceSystem();
         this.resourceSysApi.addResAdapter(new AngelSystemResAdapter(this.uiSysApi.commUIManager));
         this.resourceSysApi.addResAdapter(new AngelCombatResAdapter());
         this.uiSysApi.bindSystemResApi(this.resourceSysApi);
         this.netSysApi = new AngelNetSystem();
         (this.netSysApi as IAngelSysAPIAware).setAngelSysAPI(this);
         (this.netSysApi as IGreenSystem).initialize(AngelTcpConnection);
         var _loc7_:AngelAccessPermission;
         (_loc7_ = new AngelAccessPermission()).setAngelSysAPI(this);
         this.accPermission = _loc7_;
         this.plugManager = new AngelPlugManager();
         this.plugManager.setAngelSysAPI(this);
         this.plugManager.initialize();
         this.plugManagerApi = this.plugManager;
         this.mediaSysApi = new MediaSysManager();
         (this.mediaSysApi as IAngelSysAPIAware).setAngelSysAPI(this);
         this.sysMSGApi = new AngelMSGSys(this.uiSysApi);
         this.gEventApi.angelEventDispatcher.addEventListener(AngelSysEvent.LOGIN_OK,this.onLoginedHandler);
         AngelLogger.getLogger(this.logFun);
         Debugger.initialize(param3,true);
      }
      
      public function initialize(... rest) : void
      {
         var _loc2_:Sprite = rest[0] as Sprite;
         if(Boolean(_loc2_) && Boolean(_loc2_.stage))
         {
            this.initStage(null,_loc2_.stage);
         }
         this.globalConf = rest[1];
         this.installHelp = rest[2];
         this.logFun = rest[3];
         this.initializeWorld(this.globalConf,this.globalConf.getAllConfs(),_loc2_);
         this.installPlugin(0);
      }
      
      public function finalize() : void
      {
      }
      
      protected function onLibLoaded(param1:Event = null) : void
      {
         var _loc2_:Class = getDefinitionByName("com.QQ.angel.world.impl.AngelWorld") as Class;
         var _loc3_:IWorldAPI = new _loc2_() as IWorldAPI;
         this.worldApi = _loc3_;
         (_loc3_ as IAngelSysAPIAware).setAngelSysAPI(this);
         (_loc3_ as IGreenSystem).initialize();
         this.installPlugin(1);
         var _loc4_:SceneDes = this.gDataApi.getGlobalVal(Constants.WANT_TO_SCENE) as SceneDes;
         this.worldApi["loadScene"](_loc4_.sceneID,_loc4_.ver);
         var _loc5_:IEventDispatcher;
         (_loc5_ = this.gEventApi.angelEventDispatcher).addEventListener(AngelNetSysEvent.ON_STATE_CHANGE,this.onSystemNetClosed);
      }
      
      protected function onLogined() : void
      {
         this.installHelp.loadLibs(this.globalConf.getLibsPath(1),this.onLibLoaded);
      }
      
      protected function onLoginedHandler(param1:AngelSysEvent) : void
      {
         var _loc2_:String = param1.data as String;
         this.plugManagerApi.uninstall(_loc2_);
         this.onLogined();
      }
      
      protected function installPlugin(param1:int) : void
      {
         if(param1 == 0)
         {
            this.plugManagerApi.installPlugin("Effect",true);
            this.plugManagerApi.installPlugin("AutoExec",true);
            this.plugManagerApi.callPlugin("Login",null,true);
         }
         else if(param1 == 1)
         {
            this.plugManagerApi.callPlugin("ControlBar",null,false);
            this.plugManagerApi.callPlugin("Chat",null,false);
            this.plugManagerApi.callPlugin("Owl",null,false);
         }
         else
         {
            this.plugManager.installStepPlugins(param1);
         }
      }
      
      protected function onSystemNetClosed(param1:AngelNetSysEvent) : void
      {
         if(param1.message != null && param1.message != "")
         {
            this.uiSysApi.commUIManager.alert("",param1.message,1,new CFunction(this.reflashHTML,this));
         }
         else
         {
            this.uiSysApi.commUIManager.alert("","网络连接关闭!",1,new CFunction(this.reflashHTML,this));
         }
      }
      
      protected function reflashHTML(param1:int = 0) : void
      {
         this.extenrlApi.reflashHTML();
      }
   }
}
