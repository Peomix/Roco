package com.QQ.angel.ui
{
   import BitmapFont.font.v9.FontBase;
   import BitmapFont.font.v9.FontCenter;
   import BitmapFont.res.DFPHaiBaoW12_BitmapData;
   import BitmapFont.res.DFPHaiBaoW12_ByteArray;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.IUISysAPI;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.IEffectManager;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.npc.NpcDialogCenter;
   import com.QQ.angel.ui.core.AImage;
   import com.QQ.angel.ui.core.Animation;
   import com.QQ.angel.ui.core.BaseCursor;
   import com.QQ.angel.ui.core.StageManager;
   import com.QQ.angel.ui.core.ToolTip;
   import com.QQ.angel.ui.core.WindowManager;
   import com.QQ.angel.ui.effect.AngelEffectManager;
   import com.QQ.angel.ui.sysicons.SysIconManager;
   import com.QQ.angel.utils.RightMenuUtil;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.ContextMenuEvent;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   
   public class AngelUISystem implements IUISysAPI, IGreenSystem
   {
      
      FontCenter.regFont(FontBase.createFont(new DFPHaiBaoW12_ByteArray(),new DFPHaiBaoW12_BitmapData()),"DFPHaiBaoW12.MDF");
      
      protected var plugContainer:Sprite;
      
      protected var worldContainer:Sprite;
      
      protected var effectCs:Array;
      
      protected var commUIM:ICommUIManager;
      
      protected var effectM:IEffectManager;
      
      protected var myRoot:Sprite;
      
      protected var windowContainer:Sprite;
      
      protected var sysUIContainer:Sprite;
      
      protected var cursorMap:Dictionary;
      
      protected var currCursor:BaseCursor;
      
      public function AngelUISystem()
      {
         super();
      }
      
      protected function mouseFocusChangeHandler(param1:FocusEvent) : void
      {
         var _loc2_:Object = param1.relatedObject;
         if(_loc2_ != null && (_loc2_ is TextField || Boolean(_loc2_.hasOwnProperty("focusManager"))))
         {
            return;
         }
         if(this.myRoot.stage.focus == null)
         {
            return;
         }
         this.myRoot.stage.focus = null;
         StageManager.setup(this.myRoot.stage);
         param1.preventDefault();
      }
      
      public function initialize(... rest) : void
      {
         this.myRoot = rest[0];
         this.effectCs = [];
         this.myRoot.addChild(this.worldContainer = new Sprite());
         this.myRoot.addChild(this.plugContainer = new Sprite());
         var _loc2_:Sprite = new Sprite();
         _loc2_.mouseEnabled = false;
         this.myRoot.addChild(this.effectCs[0] = _loc2_);
         this.myRoot.addChild(this.windowContainer = new Sprite());
         _loc2_ = new Sprite();
         _loc2_.mouseEnabled = false;
         this.myRoot.addChild(this.effectCs[1] = _loc2_);
         this.commUIM = new WindowManager(this.windowContainer);
         this.effectM = new AngelEffectManager(this);
         this.myRoot.stage.addChild(this.sysUIContainer = new Sprite());
         this.sysUIContainer.mouseEnabled = false;
         this.worldContainer.name = "worldContainer";
         this.plugContainer.name = "plugContainer";
         this.windowContainer.name = "windowContainer";
         this.sysUIContainer.name = "sysUIContainer";
         SysIconManager.getInstance(this.effectCs[0]);
         if(DEFINE.IS_DEBUG == true)
         {
            RightMenuUtil.addRightMenu(this.myRoot,"version.").addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.__versionSelect);
         }
         var _loc3_:ToolTip = ToolTip.getInstance(this.myRoot.stage,this.sysUIContainer);
         _loc3_.addBubble(this.commUIM.createBubble(2),2);
         _loc3_.addBubble(this.commUIM.createBubble(1),1);
         _loc3_.addBubble(this.commUIM.createBubble(5),5);
         _loc3_.addBubble(this.commUIM.createBubble(10),10);
         _loc3_.addBubble(this.commUIM.createBubble(12),12);
         _loc3_.addBubble(this.commUIM.createBubble(100),100);
         this.cursorMap = new Dictionary();
         this.myRoot.stage.addEventListener(FocusEvent.MOUSE_FOCUS_CHANGE,this.mouseFocusChangeHandler);
         StageManager.setup(this.myRoot.stage);
         new NpcDialogCenter();
      }
      
      protected function __versionSelect(param1:ContextMenuEvent) : void
      {
         var event:ContextMenuEvent = param1;
         var loader:URLLoader = new URLLoader(new URLRequest("//172.25.40.122/res/svn.log"));
         loader.dataFormat = URLLoaderDataFormat.TEXT;
         loader.addEventListener(Event.COMPLETE,this.__versionlogComplete);
         loader.addEventListener(IOErrorEvent.IO_ERROR,function(param1:Event):void
         {
         });
         loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,function(param1:Event):void
         {
         });
      }
      
      protected function __versionlogComplete(param1:Event) : void
      {
         var _loc2_:URLLoader = URLLoader(param1.currentTarget);
         __global.UI.alert("",_loc2_.data);
      }
      
      public function finalize() : void
      {
      }
      
      public function getPlugContainer() : DisplayObjectContainer
      {
         return this.plugContainer;
      }
      
      public function getWindowContainer() : DisplayObjectContainer
      {
         return this.windowContainer;
      }
      
      public function getWorldContainer() : DisplayObjectContainer
      {
         return this.worldContainer;
      }
      
      public function getEffectContainer(param1:int = 0) : DisplayObjectContainer
      {
         return this.effectCs[param1];
      }
      
      public function get commUIManager() : ICommUIManager
      {
         return this.commUIM;
      }
      
      public function get effectManager() : IEffectManager
      {
         return this.effectM;
      }
      
      public function setMouseEnabled(param1:Boolean) : void
      {
         this.myRoot.mouseChildren = param1;
      }
      
      public function setCursor(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:BaseCursor = null;
         if(this.currCursor != null)
         {
            this.currCursor.hidden();
         }
         this.currCursor = null;
         if(param1 is int)
         {
            _loc2_ = param1 as int;
            this.currCursor = this.cursorMap[_loc2_];
         }
         else if(param1 is BaseCursor)
         {
            _loc3_ = param1 as BaseCursor;
            this.currCursor = _loc3_;
         }
         if(this.currCursor != null)
         {
            this.currCursor.show(this.sysUIContainer);
         }
      }
      
      public function printScreen(param1:Rectangle, param2:int = 0) : BitmapData
      {
         var _loc3_:DisplayObject = null;
         switch(param2)
         {
            case 0:
               _loc3_ = this.getWorldContainer();
               break;
            case 1:
               _loc3_ = this.myRoot.getChildAt(0);
         }
         var _loc4_:BitmapData = new BitmapData(param1.width,param1.height);
         _loc4_.draw(_loc3_,new Matrix(1,0,0,1,param1.x,param1.y));
         return _loc4_;
      }
      
      public function getScreenWidth() : Number
      {
         return 960;
      }
      
      public function getScreenHeight() : Number
      {
         return 560;
      }
      
      public function bindSystemResApi(param1:IResourceSysAPI) : void
      {
         AImage.setRLTM(param1.getResLoadTaskManager());
         Animation.setRLTM(param1.getResLoadTaskManager());
      }
      
      public function setUIEnabled(param1:Boolean) : void
      {
      }
   }
}

