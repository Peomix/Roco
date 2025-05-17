package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAccessPermission;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.events.ITickListener;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.api.world.scene.ISceneLogic;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.AccessPermission;
   import com.QQ.angel.data.entity.OpenGameDes;
   import com.QQ.angel.data.entity.SceneCMDDes;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.SysEventDes;
   import com.QQ.angel.world.effects.ClickEffect;
   import com.QQ.angel.world.scene.cmdLogic.ChallengeTowerLogic;
   import com.QQ.angel.world.scene.cmdLogic.SEventCMDLogic;
   import com.QQ.angel.world.scene.data.AngelSceneContext;
   import com.QQ.angel.world.scene.data.AngelSceneMapModel;
   import com.QQ.angel.world.scene.data.AngelSceneModel;
   import com.QQ.angel.world.scene.events.AngelSceneEvent;
   import com.QQ.angel.world.scene.impl.DCSpriteView;
   import com.QQ.angel.world.utils.WorldCmdType;
   import com.QQ.angel.world.utils.WorldHelper;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.KeyboardEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.utils.Dictionary;
   
   public class AngelSceneManager extends EventDispatcher implements ISceneManager, IAngelSysAPIAware, IGreenSystem, ISceneAdapter, ICmdListener
   {
      
      private var __isbuilded:Boolean = false;
      
      private var __isLoading:Boolean = false;
      
      private var __sysAPI:IAngelSysAPI;
      
      private var __roleSysApi:IRoleSysAPI;
      
      private var __accessP:IAccessPermission;
      
      private var __worldContainer:DisplayObjectContainer;
      
      private var __currSDes:SceneDes;
      
      private var __install:AngelSceneInstall;
      
      protected var currSLogic:IAngelSceneLogic;
      
      protected var context:AngelSceneContext;
      
      protected var globalDist:IEventDispatcher;
      
      protected var spaceClickTime:int = 0;
      
      protected var hero:HeroAdapter;
      
      protected var sceneCMDLogics:Dictionary;
      
      protected var runLevel:int = 0;
      
      protected var clickEffect:ClickEffect;
      
      public function AngelSceneManager()
      {
         super();
      }
      
      protected function getMapModel() : AngelSceneMapModel
      {
         var _loc1_:AngelSceneModel = this.getSceneModel() as AngelSceneModel;
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_.getMapModel() as AngelSceneMapModel;
      }
      
      protected function onWorldInited(param1:Event) : void
      {
         if(this.__roleSysApi == null)
         {
            this.__roleSysApi = this.__sysAPI.getWorldAPI().getRoleSysAPI();
         }
         this.hero.bindParams(this.__roleSysApi);
         if(this.currSLogic != null)
         {
            this.currSLogic.onWorldInited(this.hero);
         }
      }
      
      protected function onSceneInstalled(param1:AngelSceneEvent) : void
      {
         this.__isLoading = false;
         if(param1.type == AngelSceneEvent.ON_INSTALL_SUCCESS)
         {
            this.context = param1.context;
            this.currSLogic = this.context.logic;
            if(this.currSLogic is ITickListener)
            {
               this.__sysAPI.getGEventAPI().addTickListener(this.currSLogic as ITickListener);
            }
            this.__worldContainer.addChild(this.currSLogic.getContainer());
            this.currSLogic.setAngelSysAPI(this.__sysAPI);
            this.currSLogic.setSceneAdapter(this);
            this.currSLogic.initialize(null,this.runLevel);
            this.__isbuilded = true;
            this.endLoading();
            return;
         }
         this.endLoading(param1.message);
      }
      
      protected function endLoading(param1:String = "") : void
      {
         this.__isLoading = false;
         var _loc2_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.ON_SCENE_BUILT);
         _loc2_.message = param1;
         _loc2_.data = param1 == "" ? this.getCurrentScene() : null;
         this.globalDist.dispatchEvent(_loc2_);
      }
      
      public function setSceneRender(param1:Boolean = false) : void
      {
         var _loc2_:DisplayObject = null;
         if(this.currSLogic != null)
         {
            _loc2_ = this.currSLogic.getContainer();
            if(param1)
            {
               if(!this.__worldContainer.contains(_loc2_))
               {
                  this.__worldContainer.addChild(_loc2_);
               }
               this.__worldContainer.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            }
            else
            {
               if(this.__worldContainer.contains(_loc2_))
               {
                  this.__worldContainer.removeChild(_loc2_);
               }
               this.__worldContainer.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
            }
            this.currSLogic.setRender(param1);
         }
      }
      
      public function onCommand(param1:int, param2:Object) : *
      {
         var _loc3_:Point = null;
         var _loc4_:OpenGameDes = null;
         if(param1 != WorldCmdType.SPACE_CLICK && this.__accessP.canAccess(AccessPermission.GAME_ACCESS) == false)
         {
            return;
         }
         switch(param1)
         {
            case WorldCmdType.SPACE_CLICK:
               _loc3_ = param2 as Point;
               if(this.__roleSysApi.mainRoleWalk(_loc3_.clone()))
               {
                  _loc3_.x += __global.SysAPI.getWorldAPI().getSceneAPI().getSceneLogic().getContainer().x;
                  _loc3_.y += __global.SysAPI.getWorldAPI().getSceneAPI().getSceneLogic().getContainer().y;
                  this.clickEffect.click(_loc3_);
               }
               break;
            case WorldCmdType.SCENEGAME_CLICK:
               _loc4_ = new OpenGameDes();
               _loc4_.gameType = 1;
               if(param2 is int)
               {
                  _loc4_.gameID = param2 as int;
                  _loc4_.gameParms = "1";
               }
               else
               {
                  _loc4_.gameID = param2.id;
                  _loc4_.gameParms = param2.data;
               }
               __global.openGame(_loc4_);
               break;
            default:
               WorldHelper.onWorldCommand(param1,param2);
         }
      }
      
      public function call(param1:Object) : *
      {
         var _loc4_:IEventDispatcher = null;
         var _loc5_:AngelSysEvent = null;
         var _loc6_:SysEventDes = null;
         var _loc2_:SceneCMDDes = param1 as SceneCMDDes;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:ISceneCMDLogic = this.sceneCMDLogics[_loc2_.cmd];
         if(_loc3_ != null)
         {
            _loc3_.execute(_loc2_);
         }
         else
         {
            _loc4_ = this.__sysAPI.getGEventAPI().angelEventDispatcher;
            _loc5_ = new AngelSysEvent(AngelSysEvent.ON_SCENECMD_CALL);
            _loc6_ = new SysEventDes();
            _loc6_.type = uint(_loc2_.type);
            _loc6_.data = _loc2_.params;
            _loc5_.data = _loc6_;
            _loc4_.dispatchEvent(_loc5_);
         }
      }
      
      public function initialize(... rest) : void
      {
         this.__accessP = this.__sysAPI.getAccessPermission();
         this.__worldContainer = this.__sysAPI.getUISysAPI().getWorldContainer();
         this.globalDist = this.__sysAPI.getGEventAPI().angelEventDispatcher;
         this.globalDist.addEventListener(AngelSysEvent.ON_SCENEDATA_INIT,this.onWorldInited);
         this.__sysAPI.getGEventAPI().addCmdListener(AngelSysEvent.ON_SCENECMD_CALL,this);
         this.hero = new HeroAdapter();
         var _loc2_:IResLoadTaskManager = this.__sysAPI.getResSysAPI().getResLoadTaskManager();
         _loc2_.createVipChannel(Constants.SCENE_RES);
         DCSpriteView.RLTM = _loc2_;
         this.sceneCMDLogics = new Dictionary();
         this.sceneCMDLogics[SceneCMDDes.EVENT_CMD] = new SEventCMDLogic(this);
         this.sceneCMDLogics[SceneCMDDes.CHALLENGE_CMD] = new ChallengeTowerLogic(this);
         this.__worldContainer.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         var _loc3_:Class = this.__sysAPI.getResSysAPI().getEffectClsByID(2);
         if(_loc3_ != null)
         {
            this.clickEffect = new ClickEffect(this.__sysAPI.getUISysAPI().getEffectContainer(),new _loc3_() as MovieClip);
         }
         this.__install = new AngelSceneInstall();
         this.__install.addEventListener(AngelSceneEvent.ON_INSTALL_SUCCESS,this.onSceneInstalled);
         this.__install.addEventListener(AngelSceneEvent.ON_INSTALL_ERROR,this.onSceneInstalled);
         trace("[AngelSceneManager] 场景管理初始化完毕");
      }
      
      public function finalize() : void
      {
      }
      
      public function load(param1:SceneDes, param2:ILoadingView) : void
      {
         if(this.__isLoading)
         {
            return;
         }
         trace("[AngelSceneManager] 开始加载" + param1.sceneName);
         this.__isLoading = true;
         this.__currSDes = param1;
         this.__install.install(param1,param2);
      }
      
      public function unload() : void
      {
         this.hero.bindParams(null);
         if(this.__worldContainer != null && this.currSLogic != null)
         {
            this.__worldContainer.removeChild(this.currSLogic.getContainer());
         }
         if(this.currSLogic != null)
         {
            if(this.currSLogic is ITickListener)
            {
               this.__sysAPI.getGEventAPI().removeTickListener(this.currSLogic as ITickListener);
            }
            this.currSLogic = null;
            this.__install.uninstall(this.context);
         }
         this.context = null;
         this.__isbuilded = false;
      }
      
      public function onKeyDown(param1:KeyboardEvent) : void
      {
         if(param1.shiftKey && param1.keyCode == 83)
         {
            if(this.currSLogic == null)
            {
               return;
            }
            this.runLevel = this.runLevel == 0 ? 1 : 0;
            this.currSLogic.setRunLevel(this.runLevel);
         }
      }
      
      public function findPath(param1:Point, param2:Point, param3:int = 0) : Array
      {
         var _loc4_:AngelSceneMapModel = this.getMapModel();
         if(_loc4_ == null)
         {
            return null;
         }
         return _loc4_.findPath(param1,param2,param3);
      }
      
      public function isWalkable(param1:Point) : Boolean
      {
         var _loc2_:AngelSceneMapModel = this.getMapModel();
         if(_loc2_ == null)
         {
            return false;
         }
         return _loc2_.isWalkable(param1);
      }
      
      public function createMapArea(param1:Rectangle) : IMapArea
      {
         var _loc2_:AngelSceneMapModel = this.getMapModel();
         if(_loc2_ == null)
         {
            return null;
         }
         return _loc2_.createMapArea(param1);
      }
      
      public function createURLLoader() : URLLoader
      {
         if(this.__sysAPI == null)
         {
            return null;
         }
         return this.__sysAPI.getNetSysAPI().createURLLoader(true);
      }
      
      public function getSceneModel(param1:int = -1, param2:int = 1) : Object
      {
         var _loc3_:AngelSceneContext = null;
         if(param1 == -1)
         {
            _loc3_ = this.context;
         }
         else
         {
            _loc3_ = this.__install.getContext(param1,param2);
         }
         if(_loc3_ != null)
         {
            return _loc3_.model;
         }
         return null;
      }
      
      public function addSceneCMDLogics(param1:ISceneCMDLogic, param2:int) : void
      {
         this.sceneCMDLogics[param2] = param1;
      }
      
      public function getSceneData() : ISceneData
      {
         var _loc1_:AngelSceneModel = this.getSceneModel() as AngelSceneModel;
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_.getSceneData() as ISceneData;
      }
      
      public function getChallengeTower() : IChallengeTower
      {
         return this.sceneCMDLogics[SceneCMDDes.CHALLENGE_CMD];
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.__sysAPI = param1;
      }
      
      public function getHero() : IHero
      {
         return this.hero;
      }
      
      public function getSceneLogic() : ISceneLogic
      {
         return this.currSLogic;
      }
      
      public function getCurrentScene() : SceneDes
      {
         return this.__currSDes;
      }
      
      public function isBuilded() : Boolean
      {
         return this.__isbuilded;
      }
   }
}

