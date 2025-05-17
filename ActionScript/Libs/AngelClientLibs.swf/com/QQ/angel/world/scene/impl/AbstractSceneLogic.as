package com.QQ.angel.world.scene.impl
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IGlobalEventAPI;
   import com.QQ.angel.api.events.ITickListener;
   import com.QQ.angel.api.world.action.ActionExecuter;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.api.world.scene.ISPlace;
   import com.QQ.angel.api.world.scene.IStaticScene;
   import com.QQ.angel.world.magic.IAcceptMagicView;
   import com.QQ.angel.world.magic.IAcceptMagicWithUin;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   import com.QQ.angel.world.scene.IHero;
   import com.QQ.angel.world.scene.ISceneAdapter;
   import com.QQ.angel.world.utils.WorldCmdType;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   import flash.utils.Dictionary;
   
   public class AbstractSceneLogic extends Sprite implements IAngelSceneLogic, IActor, ITickListener
   {
      
      private var __adapter:ISceneAdapter;
      
      protected var sceneName:String = "unknown";
      
      protected var angelSysApi:IAngelSysAPI;
      
      protected var currDomain:ApplicationDomain;
      
      protected var scenePlaces:Dictionary;
      
      protected var layers:Dictionary;
      
      protected var runLevel:int = 0;
      
      public var clickArea:Sprite;
      
      public var backgroundSprite:Sprite;
      
      public var spaceSprite:Sprite;
      
      public var skySprite:Sprite;
      
      public var bgroundLayer:SimpleLayer;
      
      public var spaceLayer:SpaceLayer;
      
      public var skyLayer:SimpleLayer;
      
      protected var actionExecuter:ActionExecuter;
      
      public function AbstractSceneLogic()
      {
         super();
         this.actionExecuter = new ActionExecuter(this);
      }
      
      public function get CustomRoleView() : Class
      {
         return null;
      }
      
      protected function clickAreaHandler(param1:MouseEvent) : void
      {
         this.onCommand(WorldCmdType.SPACE_CLICK,new Point(param1.localX,param1.localY));
      }
      
      protected function createClickArea() : void
      {
         addChildAt(this.clickArea = new Sprite(),0);
         this.clickArea.graphics.beginFill(0,0);
         this.clickArea.graphics.drawRect(0,0,960,560);
         this.clickArea.graphics.endFill();
      }
      
      public function setClickArea(param1:int, param2:int) : void
      {
         if(this.clickArea == null)
         {
            addChildAt(this.clickArea = new Sprite(),0);
         }
         this.clickArea.graphics.clear();
         this.clickArea.graphics.beginFill(0,0);
         this.clickArea.graphics.drawRect(0,0,param1,param2);
         this.clickArea.graphics.endFill();
      }
      
      public function initialize(... rest) : void
      {
         var _loc2_:IGlobalEventAPI = null;
         this.scenePlaces = new Dictionary();
         this.layers = new Dictionary();
         this.runLevel = int(rest[1]);
         if(this.bgroundLayer == null && this.backgroundSprite != null)
         {
            trace("[AbstractSceneLogic] 初始化背景层");
            this.bgroundLayer = new SimpleLayer(this.backgroundSprite,1);
            this.bgroundLayer.initialize(this.scenePlaces,this.runLevel);
         }
         this.layers[1] = this.bgroundLayer;
         if(this.spaceLayer == null && this.spaceSprite != null)
         {
            trace("[AbstractSceneLogic] 初始化空间层");
            this.spaceLayer = new SpaceLayer(this.spaceSprite,2);
            this.spaceLayer.initialize(this.scenePlaces,this.runLevel);
         }
         this.layers[2] = this.spaceLayer;
         if(this.skyLayer == null && this.skySprite != null)
         {
            trace("[AbstractSceneLogic] 初始化天空层");
            this.skyLayer = new SimpleLayer(this.skySprite,3);
            this.skyLayer.initialize(this.scenePlaces,this.runLevel);
         }
         this.layers[3] = this.skyLayer;
         if(this.angelSysApi != null)
         {
            _loc2_ = this.angelSysApi.getGEventAPI();
            if(_loc2_ != null)
            {
               _loc2_.addRenderListener(this.bgroundLayer);
               _loc2_.addRenderListener(this.spaceLayer);
               _loc2_.addRenderListener(this.skyLayer);
            }
         }
         if(this.clickArea == null)
         {
            this.createClickArea();
         }
         this.clickArea.addEventListener(MouseEvent.CLICK,this.clickAreaHandler);
         this.onSceneReady(this.__adapter);
      }
      
      public function finalize() : void
      {
         var _loc1_:IGlobalEventAPI = null;
         this.actionExecuter.clear();
         this.scenePlaces = null;
         this.layers = null;
         if(this.clickArea != null)
         {
            this.clickArea.removeEventListener(MouseEvent.CLICK,this.clickAreaHandler);
         }
         if(this.angelSysApi != null)
         {
            _loc1_ = this.angelSysApi.getGEventAPI();
            if(_loc1_ != null)
            {
               _loc1_.removeRenderListener(this.bgroundLayer);
               _loc1_.removeRenderListener(this.spaceLayer);
               _loc1_.removeRenderListener(this.skyLayer);
            }
         }
         if(this.skyLayer != null)
         {
            this.skyLayer.finalize();
         }
         if(this.spaceLayer != null)
         {
            this.spaceLayer.finalize();
         }
         if(this.bgroundLayer != null)
         {
            this.bgroundLayer.finalize();
         }
         this.skyLayer = null;
         this.spaceLayer = null;
         this.bgroundLayer = null;
         this.angelSysApi = null;
         this.__adapter = null;
         this.currDomain = null;
      }
      
      public function getWalkAreaAsset() : Class
      {
         try
         {
            return this.currDomain.getDefinition("WalkAreaAsset") as Class;
         }
         catch(error:Error)
         {
            trace("[AbstractSceneLogic] 警告:没有找到WalkAreaAsset");
         }
         return null;
      }
      
      public function getSPlaceAt(param1:Point) : ISPlace
      {
         if(this.scenePlaces == null)
         {
            return null;
         }
         var _loc2_:String = Math.round(param1.x) + "-" + Math.round(param1.y);
         return this.scenePlaces[_loc2_];
      }
      
      public function getItemViewAt(param1:Point) : Object
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:SimpleLayer = this.spaceLayer as SimpleLayer;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.findInstanceAt(param1);
         }
         _loc3_ = this.bgroundLayer as SimpleLayer;
         if(_loc2_ == null && _loc3_ != null)
         {
            _loc2_ = _loc3_.findInstanceAt(param1);
         }
         return _loc2_;
      }
      
      public function itemAcceptMagic(param1:int, param2:Point, param3:uint = 0) : void
      {
         var _loc4_:Object = this.getItemViewAt(param2);
         if(_loc4_ == null)
         {
            return;
         }
         if(_loc4_ is IAcceptMagicView)
         {
            (_loc4_ as IAcceptMagicView).onAcceptedMagic(param1,param2.x,param2.y);
         }
         if(_loc4_ is IAcceptMagicWithUin)
         {
            (_loc4_ as IAcceptMagicWithUin).onAcceptedUinMagic(param1,param2.x,param2.y,param3);
         }
      }
      
      public function getObjectByName(param1:String) : DisplayObject
      {
         var _loc2_:DisplayObject = this.backgroundSprite.getChildByName(param1);
         if(_loc2_ == null)
         {
            _loc2_ = this.spaceSprite.getChildByName(param1);
         }
         if(_loc2_ == null)
         {
            _loc2_ = this.skySprite.getChildByName(param1);
         }
         return _loc2_;
      }
      
      public function setRender(param1:Boolean = false) : void
      {
         this.spaceLayer.setDMEnabled(param1);
      }
      
      public function onCommand(param1:int, param2:Object) : void
      {
         if(this.__adapter != null)
         {
            this.__adapter.onCommand(param1,param2);
         }
      }
      
      public function setRunLevel(param1:int = 0) : void
      {
         if(this.runLevel == param1)
         {
            return;
         }
         this.runLevel = param1;
         this.setXRunLevel(this.runLevel);
         this.bgroundLayer.setRunLevel(this.runLevel);
         this.spaceLayer.setRunLevel(this.runLevel);
         this.skyLayer.setRunLevel(this.runLevel);
      }
      
      public function setXRunLevel(param1:int = 0) : void
      {
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysApi = param1;
      }
      
      public function setSceneAdapter(param1:ISceneAdapter) : void
      {
         this.__adapter = param1;
      }
      
      public function getName() : String
      {
         return this.sceneName;
      }
      
      public function attachStaticScene(param1:IStaticScene) : void
      {
      }
      
      public function getStaticScene() : IStaticScene
      {
         return null;
      }
      
      public function getSpaceLayer() : ILayer
      {
         return this.spaceLayer;
      }
      
      public function getSkyLayer() : ILayer
      {
         return this.skyLayer;
      }
      
      public function getGroundLayer() : ILayer
      {
         return this.bgroundLayer;
      }
      
      public function getNpcList() : Array
      {
         return [];
      }
      
      public function getContainer() : DisplayObjectContainer
      {
         return this;
      }
      
      public function onWorldInited(param1:IHero) : void
      {
      }
      
      public function onSceneReady(param1:ISceneAdapter) : void
      {
      }
      
      public function getWalkData() : Array
      {
         return null;
      }
      
      public function setCurrDomain(param1:ApplicationDomain) : void
      {
         this.currDomain = param1;
      }
      
      public function getCurrDomain() : ApplicationDomain
      {
         return this.currDomain;
      }
      
      public function getLayerByID(param1:int) : ILayer
      {
         return this.layers[param1];
      }
      
      public function onTick(... rest) : void
      {
      }
      
      public function onTickEvent(param1:Event) : void
      {
         this.actionExecuter.onTick();
      }
      
      public function act(param1:IAction) : Boolean
      {
         return this.actionExecuter.act(param1);
      }
      
      public function getActor() : IActor
      {
         return this;
      }
      
      public function getID() : uint
      {
         return 100000;
      }
   }
}

