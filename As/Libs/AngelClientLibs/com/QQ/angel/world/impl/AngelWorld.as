package com.QQ.angel.world.impl
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.IUISysAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.media.IAudioPlayer;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.INPCSysAPI;
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.api.world.ISceneAPI;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.ChangeSceneDes;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.ServerInfo;
   import com.QQ.angel.data.entity.SysEventDes;
   import com.QQ.angel.logging.log;
   import com.QQ.angel.world.IAngelWorld;
   import com.QQ.angel.world.assets.CSAlert;
   import com.QQ.angel.world.net.AWDataReceiver;
   import com.QQ.angel.world.npc.AngelNPCSystem;
   import com.QQ.angel.world.panel.*;
   import com.QQ.angel.world.res.GuardianPetAvatarResAdapter;
   import com.QQ.angel.world.res.SpiritAvatarResAdapter;
   import com.QQ.angel.world.role.AngelRoleSystem;
   import com.QQ.angel.world.scene.AngelSceneManager;
   import com.QQ.angel.world.script.WorldScriptSystem;
   import com.QQ.angel.world.utils.WorldHelper;
   import com.QQ.angel.world.vo.AllScenesConfig;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class AngelWorld extends EventDispatcher implements IAngelWorld, IGreenSystem, IAngelSysAPIAware, ICmdListener
   {
       
      
      protected var angelSysApi:IAngelSysAPI;
      
      protected var serverInfo:ServerInfo;
      
      protected var sceneConf:AllScenesConfig;
      
      protected var isSceneInit:Boolean = false;
      
      protected var isOnline:Boolean = false;
      
      protected var changeSceneObj:Object;
      
      protected var sceneManager:AngelSceneManager;
      
      protected var bgMusic:IAudioPlayer;
      
      protected var roleSystem:AngelRoleSystem;
      
      protected var npcSystem:AngelNPCSystem;
      
      protected var scriptSystem:WorldScriptSystem;
      
      protected var commUI:ICommUIManager;
      
      protected var uiSysApi:IUISysAPI;
      
      protected var loadingUI:ILoadingView;
      
      protected var gDispatcer:IEventDispatcher;
      
      protected var aWDataRec:AWDataReceiver;
      
      protected var screenRect:Rectangle;
      
      protected var changeHandler:CFunction;
      
      protected var loadSceneTime:int = 0;
      
      private var m_lastRequestUin:int = -1;
      
      public function AngelWorld()
      {
         super();
      }
      
      private static function onChangeScene(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc7_:SceneDes = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc5_:Array = param2 as Array;
         var _loc6_:AngelWorld = param4 as AngelWorld;
         if(_loc5_)
         {
            if(_loc7_ = _loc5_[1] as SceneDes)
            {
               _loc8_ = new Object();
               if(_loc6_.changeSceneObj)
               {
                  for(_loc9_ in _loc6_.changeSceneObj)
                  {
                     _loc8_[_loc9_] = _loc6_.changeSceneObj[_loc9_];
                  }
                  _loc6_.changeSceneObj = _loc8_;
                  _loc6_.changeSceneObj.sceneID = _loc7_.sceneID;
                  _loc6_.changeSceneObj.ver = _loc7_.ver;
               }
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_OLD_SCENE_LEAVED,param2);
               _loc6_.gDispatcer.dispatchEvent(new AngelSysEvent(AngelSysEvent.ON_SCENE_DESTROY));
               _loc6_.roleSystem.delAndUnloadRoles();
               _loc6_.npcSystem.delAndUnloadNpcs();
               _loc6_.sceneManager.unload();
               _loc6_.isSceneInit = false;
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_OLD_SCENE_DISPOSED,param2);
               _loc6_.loadScene(_loc7_.sceneID,_loc7_.ver);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onSceneRoleDataLoaded(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc11_:RoleData = null;
         var _loc5_:AngelWorld = AngelWorld(param4);
         var _loc6_:Object;
         if((_loc6_ = param2).error == true)
         {
            trace("错误:获取人物列表失败,进入场景失败!\n" + "原因:" + _loc6_.message);
            return CallbackCenter.EVENT_OK;
         }
         var _loc7_:Array = _loc6_.roleDatas as Array;
         var _loc8_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ROLE_DATA);
         var _loc9_:RoleData = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.MAIN_ROLE_INFO) as RoleData;
         _loc8_.clear();
         _loc5_.roleSystem.delAndUnloadRoles();
         var _loc10_:int = 0;
         while(_loc10_ < _loc6_.roleDatas.length)
         {
            if((_loc11_ = _loc7_[_loc10_]).id == _loc9_.id)
            {
               _loc9_.update(_loc11_);
               _loc8_.insert(_loc9_);
            }
            else
            {
               _loc8_.insert(_loc11_);
            }
            _loc10_++;
         }
         _loc5_.roleSystem.buildAndLoadRoles();
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onApplyChangeScene(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Object = null;
         var _loc11_:IDataProxy = null;
         var _loc12_:AllScenesConfig = null;
         var _loc13_:String = null;
         var _loc14_:int = 0;
         var _loc5_:ChangeSceneDes = param2 as ChangeSceneDes;
         var _loc6_:AngelWorld = param4 as AngelWorld;
         if(_loc5_ != null)
         {
            if(_loc5_.randomIDs != null)
            {
               _loc8_ = int(_loc5_.randomIDs.length * Math.random());
               _loc7_ = int(_loc5_.randomIDs[_loc8_]);
            }
            else
            {
               _loc7_ = _loc5_.sceneID;
            }
            if(_loc5_.verList != null)
            {
               _loc9_ = int(_loc5_.verList.length * Math.random());
               _loc5_.ver = int(_loc5_.verList[_loc9_]);
            }
            if(_loc5_.ver == 0)
            {
               _loc11_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SCENE_DATA);
               if(_loc12_ = AllScenesConfig(_loc11_))
               {
                  _loc10_ = _loc12_.getScenesWithoutVer(_loc7_);
               }
               for(_loc13_ in _loc10_)
               {
                  if((_loc14_ = int(_loc13_)) > _loc5_.ver)
                  {
                     _loc5_.ver = _loc14_;
                  }
               }
            }
            if(_loc6_)
            {
               _loc6_.changeScene(_loc7_,_loc5_.uin,_loc5_.name,_loc5_.ver);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      protected function reflashPage(... rest) : void
      {
         if(rest[0] == 1)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,["Home",null]);
         }
         else
         {
            this.angelSysApi.getExternalAPI().reflashHTML();
         }
      }
      
      protected function hiddenLoadingUI() : void
      {
         var _loc1_:IWindow = null;
         if(this.loadingUI != null)
         {
            this.loadingUI.setBackGround(null);
            _loc1_ = this.loadingUI as IWindow;
            _loc1_.hide();
         }
      }
      
      protected function showLoadingUI(param1:Boolean = true) : void
      {
         if(this.loadingUI == null)
         {
            this.loadingUI = this.commUI.createLoadingView(4,true);
         }
         else if((this.loadingUI as DisplayObject).visible)
         {
            return;
         }
         this.loadingUI.setBackGround(param1 ? this.uiSysApi.printScreen(this.screenRect) : {"bd":this.uiSysApi.printScreen(this.screenRect,1)});
         (this.loadingUI as IWindow).show();
         (this.loadingUI as IWindow).bringToFront();
      }
      
      protected function onSceneBuilt(param1:AngelSysEvent) : void
      {
         if(param1.data == null)
         {
            this.commUI.alert("","跳转场景魔法失败了，\n确定将返回家园，取消将重新登录",2,new CFunction(this.reflashPage,this));
            return;
         }
         if(this.loadingUI != null)
         {
            this.loadingUI.setLabel("加载场景数据...");
         }
         this.aWDataRec.initSceneData(this.sceneManager.getCurrentScene().sceneID);
         this.angelSysApi.getExternalAPI().ccGC();
         if(!this.isOnline)
         {
            log(getTimer() - this.loadSceneTime,8);
         }
      }
      
      protected function setIsOnline() : void
      {
         var _loc1_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.ON_SYS_EVENT);
         var _loc2_:SysEventDes = new SysEventDes();
         _loc2_.type = SysEventDes.ONLINE;
         _loc1_.data = _loc2_;
         this.isOnline = true;
         this.gDispatcer.dispatchEvent(_loc1_);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_ON_PLAYER_SET_ONLINE);
      }
      
      protected function onSceneDataInit(param1:Event) : void
      {
         if(this.isSceneInit)
         {
            return;
         }
         this.npcSystem.buildAndLoadNpcs();
         this.hiddenLoadingUI();
         if(!this.isOnline && this.sceneManager.getCurrentScene().sceneID != 10001)
         {
            this.setIsOnline();
            this.angelSysApi.getMediaSysAPI().getEAudioManager().setPath(DEFINE.COMM_ROOT + "res/music/EffectSoundAll.swf");
         }
         var _loc2_:Array = this.sceneManager.getCurrentScene().bgMusic;
         if(_loc2_ != null && this.bgMusic != null)
         {
            this.bgMusic.setPaths(_loc2_,true);
         }
         this.isSceneInit = true;
         if(this.changeSceneObj != null && this.changeSceneObj.message != "")
         {
            switch(this.changeSceneObj.message)
            {
               case "御风术施法成功。":
                  __global.SysAPI.getWorldAPI().getRoleSysAPI().applyActionTo2(0,0,{
                     "id":9,
                     "dur":1000
                  });
                  break;
               case "辟水咒施法成功。":
                  __global.SysAPI.getWorldAPI().getRoleSysAPI().applyActionTo2(0,0,{
                     "id":10,
                     "dur":1000
                  });
                  break;
               case "扫帚飞行施法成功。":
                  __global.SysAPI.getWorldAPI().getRoleSysAPI().applyActionTo2(0,0,{
                     "id":11,
                     "dur":1000
                  });
                  break;
               default:
                  this.commUI.alert("",this.changeSceneObj.message);
            }
            this.changeSceneObj = null;
         }
      }
      
      protected function requestChange(param1:int = 1) : void
      {
         if(param1 != 1)
         {
            return;
         }
         var _loc2_:int = int(this.changeHandler.params[0]);
         if(_loc2_ == -1)
         {
            return;
         }
         var _loc3_:uint = uint(this.changeHandler.params[1]);
         var _loc4_:int = int(this.changeHandler.params[2]);
         this.commUI.closeAllWindows();
         this.showLoadingUI();
         this.loadingUI.setProgress(0);
         this.loadingUI.setLabel("请求场景切换...");
         this.aWDataRec.requestChangeScene(this.sceneManager.getCurrentScene().sceneID,_loc2_,_loc3_,_loc4_);
         this.m_lastRequestUin = _loc3_;
         this.changeHandler.params[0] = -1;
         this.changeHandler.params[1] = 0;
         this.changeHandler.params[2] = 1;
      }
      
      public function setRender(param1:Boolean = false) : void
      {
         if(this.sceneManager != null)
         {
            this.sceneManager.setSceneRender(param1);
         }
         if(this.npcSystem != null)
         {
            this.npcSystem.setRender(param1);
         }
      }
      
      public function call(param1:Object) : *
      {
         var _loc2_:ChangeSceneDes = param1 as ChangeSceneDes;
         var _loc3_:ChangeSceneDes = new ChangeSceneDes();
         _loc3_.sceneID = _loc2_.sceneID;
         _loc3_.randomIDs = !!_loc2_.randomIDs ? _loc2_.randomIDs.slice() : null;
         _loc3_.dialogTxt = _loc2_.dialogTxt;
         _loc3_.uin = _loc2_.uin;
         _loc3_.name = _loc2_.name;
         _loc3_.ver = _loc2_.ver;
         _loc3_.verList = !!_loc2_.verList ? _loc2_.verList.slice() : null;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_APPLY_CHANGE_SCENE,_loc3_);
      }
      
      public function changeScene(param1:int, param2:uint, param3:String, param4:int = 1) : void
      {
         var _loc6_:int;
         var _loc5_:SceneDes;
         if((_loc6_ = (_loc5_ = this.sceneManager.getCurrentScene()).sceneID) == param1 && _loc5_.uin == param2 && _loc5_.ver == param4)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         var _loc7_:SceneDes;
         if((_loc7_ = this.sceneConf.getScenesDesByID(param1,param4)) == null)
         {
            this.commUI.alert("","没有找到ID为" + param1 + " 版本号为" + param4 + "的场景");
            return;
         }
         if(_loc7_.sceneName == "?")
         {
            _loc7_.topID = -1;
         }
         if(_loc7_.topID == -1 && Boolean(param3))
         {
            _loc7_.sceneName = param3;
         }
         if(this.changeHandler == null)
         {
            this.changeHandler = new CFunction(this.requestChange,this,[]);
         }
         this.changeHandler.params[0] = param1;
         this.changeHandler.params[1] = param2;
         this.changeHandler.params[2] = param4;
         if(_loc6_ > 20000 && (param1 < 20000 && param1 != 72))
         {
            this.commUI.alert("","如果现在离开挑战馆，下回需要从这个馆的第一层开始挑战，确定要退出么？",2,this.changeHandler);
         }
         else
         {
            this.requestChange();
         }
      }
      
      public function getRoleSysAPI() : IRoleSysAPI
      {
         return this.roleSystem;
      }
      
      public function getNPCSysAPI() : INPCSysAPI
      {
         return this.npcSystem;
      }
      
      public function getSceneAPI() : ISceneAPI
      {
         return this.sceneManager;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysApi = param1;
      }
      
      public function onChangeSceneRes(param1:Object) : void
      {
         if(param1.error)
         {
            this.hiddenLoadingUI();
            this.changeSceneErrorHandler(param1);
            return;
         }
         this.changeSceneObj = param1;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_CHANGE_SCENE,[this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CUR_SCENE),this.sceneConf.getScenesDesByID(param1.sceneID,param1.ver)]);
      }
      
      public function loadScene(param1:int, param2:int = 1) : void
      {
         var _loc3_:SceneDes = this.sceneConf.getScenesDesByID(param1,param2);
         if(_loc3_ == null)
         {
            this.commUI.alert("","没有找到场景ID为(" + param1 + "版本号为" + param2 + ")的相关配置文件...");
            return;
         }
         this.angelSysApi.getGDataAPI().addGlobalVal(Constants.PRE_SCENE,this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CUR_SCENE));
         _loc3_.uin = this.m_lastRequestUin;
         this.m_lastRequestUin = -1;
         this.angelSysApi.getGDataAPI().addGlobalVal(Constants.CUR_SCENE,_loc3_);
         this.showLoadingUI(this.isOnline);
         this.sceneManager.load(_loc3_,this.loadingUI);
         if(!this.isOnline)
         {
            this.loadSceneTime = getTimer();
         }
      }
      
      public function initialize(... rest) : void
      {
         this.gDispatcer = this.angelSysApi.getGEventAPI().angelEventDispatcher;
         this.gDispatcer.addEventListener(AngelSysEvent.ON_SCENE_BUILT,this.onSceneBuilt);
         this.gDispatcer.addEventListener(AngelSysEvent.ON_SCENEDATA_INIT,this.onSceneDataInit,false,100);
         this.angelSysApi.getGEventAPI().addCmdListener(AngelSysEvent.ON_CHANGE_SCENE,this);
         this.angelSysApi.getResSysAPI().addResAdapter(new SpiritAvatarResAdapter());
         this.angelSysApi.getResSysAPI().addResAdapter(new GuardianPetAvatarResAdapter());
         var _loc2_:String = rest[0];
         this.sceneManager = new AngelSceneManager();
         this.sceneManager.setAngelSysAPI(this.angelSysApi);
         this.sceneManager.initialize();
         this.roleSystem = new AngelRoleSystem();
         this.roleSystem.setAngelSysAPI(this.angelSysApi);
         this.roleSystem.initialize();
         this.npcSystem = new AngelNPCSystem();
         this.npcSystem.setAngelSysAPI(this.angelSysApi);
         this.npcSystem.initialize();
         this.uiSysApi = this.angelSysApi.getUISysAPI();
         this.commUI = this.uiSysApi.commUIManager;
         this.screenRect = new Rectangle(0,0,this.uiSysApi.getScreenWidth(),this.uiSysApi.getScreenHeight());
         this.aWDataRec = new AWDataReceiver();
         this.aWDataRec.setAngelSysAPI(this.angelSysApi);
         this.aWDataRec.initialize();
         var _loc3_:Object = this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CONFS);
         this.sceneConf = new AllScenesConfig(_loc3_["scene_conf"]);
         this.angelSysApi.getGDataAPI().addDataProxy(this.sceneConf);
         this.serverInfo = this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         WorldHelper.initialize(this.angelSysApi);
         this.scriptSystem = new WorldScriptSystem();
         this.scriptSystem.setAngelSysAPI(this.angelSysApi);
         this.scriptSystem.initialize();
         this.bgMusic = this.angelSysApi.getMediaSysAPI().getBGAudio();
         new TaskCallHandler(this.angelSysApi);
         new OpenGameHandler(this.angelSysApi);
         new TimesPaperHandler(this.angelSysApi);
         new OpenCombatHandler(this.angelSysApi);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_APPLY_CHANGE_SCENE,AngelWorld.onApplyChangeScene,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_CHANGE_SCENE,AngelWorld.onChangeScene,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ROLE_DATA_LOADED,AngelWorld.onSceneRoleDataLoaded,this);
      }
      
      public function finalize() : void
      {
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_WORLD_APPLY_CHANGE_SCENE,AngelWorld.onApplyChangeScene,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_WORLD_ON_CHANGE_SCENE,AngelWorld.onChangeScene,this);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ROLE_DATA_LOADED,AngelWorld.onSceneRoleDataLoaded,this);
      }
      
      private function changeSceneErrorHandler(param1:Object) : void
      {
         var gotoScene47:Function = null;
         var gotoScene20:Function = null;
         var back:Object = param1;
         gotoScene47 = function():void
         {
            __global.changeScene(null,47);
         };
         gotoScene20 = function():void
         {
            __global.changeScene(null,20);
         };
         switch(back.code)
         {
            case -136:
               __global.showMAlert(new CSAlert(),"",back.message,gotoScene47);
               break;
            case -137:
               __global.showMAlert(new CSAlert(),"",back.message,gotoScene20);
               break;
            default:
               this.commUI.alert("",back.message);
         }
      }
   }
}
