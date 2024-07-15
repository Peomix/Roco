package com.QQ.angel.world.npc
{
   import com.QQ.angel.api.IAccessPermission;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.INPCSysAPI;
   import com.QQ.angel.api.world.npc.INPC;
   import com.QQ.angel.api.world.scene.ISceneLogic;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.tasksys.model.IModelManager;
   import com.QQ.angel.data.entity.world.INpcDataProxy;
   import com.QQ.angel.world.assets.SignAsset;
   import com.QQ.angel.world.npc.v2.DCreateNpcView2;
   import com.QQ.angel.world.npc.v2.SceneNPCManager;
   import com.QQ.angel.world.npc.v2.SimpleNpcElement2;
   import com.QQ.angel.world.npc.v2.TaskNPCElement2;
   import com.QQ.angel.world.scene.ISceneManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class AngelNPCSystem extends EventDispatcher implements IGreenSystem, IAngelSysAPIAware, INPCSysAPI, INPCListener
   {
       
      
      protected var angelSysApi:IAngelSysAPI;
      
      protected var accessP:IAccessPermission;
      
      protected var sceneManager:ISceneManager;
      
      protected var sSpiritM:SceneSpiritManager;
      
      protected var sNpcM:SceneNPCManager;
      
      protected var npcClsMap:Dictionary;
      
      protected var npcViewClsMap:Dictionary;
      
      protected var commIcons:Dictionary;
      
      protected var iconPool:Array;
      
      protected var nameTxtPool:Array;
      
      protected var npcTxtFliters:Array;
      
      protected var npcOverFliters:Array;
      
      protected var clickCall:CFunction;
      
      protected var commUI:ICommUIManager;
      
      protected var models:IModelManager;
      
      public function AngelNPCSystem()
      {
         super();
      }
      
      protected function get spiritManager() : SceneSpiritManager
      {
         if(this.sSpiritM == null)
         {
            this.sSpiritM = new SceneSpiritManager();
            this.sSpiritM.setAngelSysAPI(this.angelSysApi);
            this.sSpiritM.setNpcListener(this);
            this.sSpiritM.initialize();
         }
         return this.sSpiritM;
      }
      
      protected function get npcManager() : SceneNPCManager
      {
         if(this.sNpcM == null)
         {
            this.sNpcM = new SceneNPCManager();
            this.sNpcM.setAngelSysAPI(this.angelSysApi);
            this.sNpcM.setNpcListener(this);
            this.sNpcM.initialize();
         }
         return this.sNpcM;
      }
      
      public function initialize(... rest) : void
      {
         this.npcClsMap = new Dictionary();
         this.npcClsMap[0] = SimpleNpcElement2;
         this.npcClsMap[1] = TaskNPCElement2;
         this.npcViewClsMap = new Dictionary();
         this.npcViewClsMap[0] = DCreateNpcView2;
         this.commIcons = new Dictionary();
         this.commIcons["taskSign"] = SignAsset;
         this.sceneManager = this.angelSysApi.getWorldAPI().getSceneAPI() as ISceneManager;
         this.accessP = this.angelSysApi.getAccessPermission();
         this.commUI = this.angelSysApi.getUISysAPI().commUIManager;
         this.npcTxtFliters = [];
         var _loc2_:GlowFilter = new GlowFilter();
         _loc2_.blurX = 3;
         _loc2_.blurY = 3;
         _loc2_.color = 16777215;
         _loc2_.strength = 6;
         this.npcTxtFliters.push(_loc2_);
         this.sSpiritM = new SceneSpiritManager();
         this.sSpiritM.setAngelSysAPI(this.angelSysApi);
         this.sSpiritM.setNpcListener(this);
         this.sSpiritM.initialize();
         trace("[AngelNPCSystem] >>NPC初始化完毕");
      }
      
      public function finalize() : void
      {
      }
      
      public function buildAndLoadNpcs() : void
      {
         this.spiritManager.active();
         this.npcManager.active();
      }
      
      public function delAndUnloadNpcs() : void
      {
         this.spiritManager.deactivate();
         this.npcManager.deactivate();
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysApi = param1;
      }
      
      public function setRender(param1:Boolean) : void
      {
         if(this.sSpiritM != null)
         {
            this.sSpiritM.setRender(param1);
         }
      }
      
      public function getNPCCls(param1:int = 0) : Class
      {
         return this.npcClsMap[param1];
      }
      
      public function getNPCViewCls(param1:int = 0) : Class
      {
         return this.npcViewClsMap[param1];
      }
      
      public function getNPCByName(param1:String) : INPC
      {
         return this.sNpcM == null ? null : this.sNpcM.getNPCByName(param1);
      }
      
      public function getNPCList() : Array
      {
         return this.sNpcM == null ? null : this.sNpcM.getNPCList();
      }
      
      public function getNPCModel(param1:int = -1) : Object
      {
         return this.sNpcM == null ? null : this.sNpcM.getNPCModel();
      }
      
      public function getSceneStage() : Sprite
      {
         var _loc1_:ISceneLogic = this.sceneManager.getSceneLogic();
         if(_loc1_ == null)
         {
            return null;
         }
         return _loc1_.getContainer() as Sprite;
      }
      
      public function createNameTxt() : TextField
      {
         var _loc1_:TextField = null;
         if(this.nameTxtPool == null || this.nameTxtPool.length == 0)
         {
            _loc1_ = new TextField();
            _loc1_.textColor = 255;
            _loc1_.selectable = false;
            _loc1_.autoSize = "left";
            _loc1_.mouseEnabled = false;
            _loc1_.filters = this.npcTxtFliters;
            return _loc1_;
         }
         return this.nameTxtPool.pop() as TextField;
      }
      
      public function returnNameTxt(param1:TextField) : void
      {
         if(this.nameTxtPool == null)
         {
            this.nameTxtPool = [];
         }
         this.nameTxtPool.push(param1);
      }
      
      public function getCommIcon(param1:String) : DisplayObject
      {
         var _loc2_:Class = null;
         if(this.iconPool == null || this.iconPool.length == 0)
         {
            _loc2_ = this.commIcons[param1] as Class;
            return new _loc2_();
         }
         return this.iconPool.pop() as DisplayObject;
      }
      
      public function returnCommIcon(param1:String, param2:DisplayObject) : void
      {
         if(this.iconPool == null)
         {
            this.iconPool = [];
         }
         this.iconPool.push(param2);
      }
      
      public function getOverFilters(param1:int = 0) : Array
      {
         var _loc2_:GlowFilter = null;
         if(this.npcOverFliters == null)
         {
            this.npcOverFliters = [];
            _loc2_ = new GlowFilter();
            _loc2_.blurX = 5;
            _loc2_.blurY = 5;
            _loc2_.color = 16776960;
            _loc2_.strength = 6;
            this.npcOverFliters.push(_loc2_);
         }
         return this.npcOverFliters;
      }
      
      public function onNPCClick(param1:INPC) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:INpcDataProxy = param1.getData() as INpcDataProxy;
         __global.executeClick(_loc2_.getClick());
      }
      
      public function isFrequency(param1:int) : Boolean
      {
         return param1 < 500;
      }
      
      public function getNpcPath(param1:int, param2:String) : String
      {
         if(param2.indexOf("https://") != -1 && param2.indexOf("http://") != -1)
         {
            return param2;
         }
         return __global.getNPCPath() + param1 + "/" + param2;
      }
   }
}
