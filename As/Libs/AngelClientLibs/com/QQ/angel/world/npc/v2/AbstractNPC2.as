package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.api.display.IDisplay;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.scene.IElementView;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.NpcViewDes;
   import com.QQ.angel.data.entity.NpcViewEventDes;
   import com.QQ.angel.data.entity.world.events.NpcModelEvent;
   import com.QQ.angel.utils.LocalFile;
   import com.QQ.angel.world.npc.INPCElement;
   import com.QQ.angel.world.npc.INPCElementView;
   import com.QQ.angel.world.npc.INPCListener;
   import com.QQ.angel.world.scene.IDCreateView;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AbstractNPC2 extends EventDispatcher implements INPCElement
   {
       
      
      protected var view:*;
      
      protected var nameTxt:TextField;
      
      protected var listener:INPCListener;
      
      protected var npcProxy:NpcDataProxy;
      
      protected var atLayer:ILayer;
      
      protected var lastClickTime:int = 0;
      
      protected var isRender:Boolean = false;
      
      protected var viewEventsMap:Dictionary;
      
      public function AbstractNPC2()
      {
         super();
      }
      
      protected function onMouseClick(param1:MouseEvent) : void
      {
         trace("[SimpleNpcElement] npc is clicked!");
         if(this.npclistener != null)
         {
            if(this.npclistener.isFrequency(getTimer() - this.lastClickTime))
            {
               trace("[SimpleNpcElement] NPC的点击频率过高!!");
               return;
            }
            this.npclistener.onNPCClick(this);
            this.lastClickTime = getTimer();
         }
      }
      
      protected function setVUnkownVal(param1:String, param2:*) : void
      {
         if(this.view == null || param2 == null)
         {
            return;
         }
         if(this.view.hasOwnProperty(param1))
         {
            this.view[param1] = param2;
         }
      }
      
      protected function onNPCAssetLoaded(param1:Event) : void
      {
         if(this.npcProxy != null)
         {
            this.npcProxy.dispatchEvent(new NpcModelEvent(NpcModelEvent.ON_ASSET_LOADED));
         }
      }
      
      protected function onNPCViewEvent(param1:Event) : void
      {
         if(this.viewEventsMap == null)
         {
            return;
         }
         var _loc2_:CFunction = this.viewEventsMap[param1.type];
         if(_loc2_ != null)
         {
            _loc2_.invoke();
         }
      }
      
      protected function bindViewEvent(param1:Boolean = true) : void
      {
         var _loc4_:int = 0;
         var _loc5_:NpcViewEventDes = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc2_:Array = this.npcProxy.getViewEvents();
         if(_loc2_ == null || _loc2_.length == 0)
         {
            return;
         }
         var _loc3_:IEventDispatcher = this.view as IEventDispatcher;
         if(_loc3_ == null)
         {
            return;
         }
         if(param1)
         {
            this.viewEventsMap = new Dictionary();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               if((_loc5_ = _loc2_[_loc4_]) != null && _loc5_.handler != null)
               {
                  _loc6_ = _loc5_.eType;
                  _loc3_.addEventListener(_loc6_,this.onNPCViewEvent);
                  this.viewEventsMap[_loc6_] = _loc5_.handler;
               }
               _loc4_++;
            }
         }
         else
         {
            if(this.viewEventsMap == null)
            {
               return;
            }
            for(_loc7_ in this.viewEventsMap)
            {
               _loc3_.removeEventListener(_loc7_,this.onNPCViewEvent);
            }
            this.viewEventsMap = null;
         }
      }
      
      public function initialize(... rest) : void
      {
         var _loc6_:IDCreateView = null;
         this.npcProxy.bind(this.view as DisplayObject);
         var _loc2_:NpcDes = this.npcProxy.getNpcDes();
         if(_loc2_.tooltip != "")
         {
            this.setVUnkownVal("tooltip",_loc2_.tooltip);
            this.setVUnkownVal("tooltipType",_loc2_.tooltipType);
            this.setVUnkownVal("tooltipPos",_loc2_.tooltipPos);
         }
         this.setVUnkownVal("direction",_loc2_.direction);
         this.setVUnkownVal("placeID",_loc2_.placeID);
         this.setVUnkownVal("placeType",_loc2_.placeType);
         this.setVUnkownVal("leftGamePos",_loc2_.leftGamePos);
         var _loc3_:INPCElementView = this.view as INPCElementView;
         if(_loc3_ != null)
         {
            _loc3_.setViewDes(_loc2_.npcViewDes);
            if(_loc2_.hasBrand)
            {
               _loc3_.setNameTxt(this.nameTxt = this.listener.createNameTxt());
               _loc3_.setNpcName(_loc2_.name);
            }
            _loc3_.setSceneStage(this.listener.getSceneStage());
         }
         if(this.atLayer != null)
         {
            this.atLayer.addElement(this);
         }
         var _loc4_:NpcViewDes;
         if((_loc4_ = _loc2_.npcViewDes) != null)
         {
            this.view.setLocation(_loc2_.position);
            (_loc6_ = this.view as IDCreateView).setPath(this.listener.getNpcPath(_loc2_.npcID,_loc4_.src));
         }
         this.bindViewEvent();
         var _loc5_:IEventDispatcher;
         if((_loc5_ = this.view as IEventDispatcher) != null)
         {
            _loc5_.addEventListener(MouseEvent.CLICK,this.onMouseClick);
            _loc5_.addEventListener(Event.COMPLETE,this.onNPCAssetLoaded);
         }
         if(_loc3_ != null)
         {
            _loc3_.onReady();
         }
      }
      
      public function finalize() : void
      {
         var _loc1_:IEventDispatcher = null;
         if(this.nameTxt != null)
         {
            this.npclistener.returnNameTxt(this.nameTxt);
            this.nameTxt = null;
         }
         this.bindViewEvent(false);
         if(this.atLayer != null)
         {
            this.atLayer.removeElement(this);
            this.atLayer = null;
         }
         if(this.view != null)
         {
            _loc1_ = this.view as IEventDispatcher;
            if(_loc1_ != null)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onMouseClick);
               _loc1_.removeEventListener(Event.COMPLETE,this.onNPCAssetLoaded);
            }
            if(this.view is IElementView)
            {
               (this.view as IElementView).unload();
            }
            else
            {
               this.view is DisplayObjectContainer;
            }
            LocalFile.STOPContainer(this.view as DisplayObjectContainer);
            this.view = null;
         }
         if(this.npcProxy != null)
         {
            this.npcProxy.unbind();
            this.npcProxy = null;
         }
         this.npclistener = null;
      }
      
      public function getID() : uint
      {
         if(this.npcProxy == null)
         {
            return 0;
         }
         return this.npcProxy.getNpcDes().npcID;
      }
      
      public function get display() : DisplayObject
      {
         if(this.view is DisplayObject)
         {
            return this.view as DisplayObject;
         }
         if(this.view is IDisplay)
         {
            return (this.view as IDisplay).display;
         }
         return null;
      }
      
      public function getNpcType() : int
      {
         return 0;
      }
      
      public function getView() : *
      {
         return this.view;
      }
      
      public function getName() : String
      {
         return this.view == null ? "" : this.view.name;
      }
      
      public function setAtLayer(param1:ILayer) : void
      {
         this.atLayer = param1;
      }
      
      public function setData(param1:Object) : void
      {
         this.npcProxy = param1 as NpcDataProxy;
      }
      
      public function getData() : Object
      {
         return this.npcProxy;
      }
      
      public function set npclistener(param1:INPCListener) : void
      {
         this.listener = param1;
      }
      
      public function get npclistener() : INPCListener
      {
         return this.listener;
      }
      
      public function attachView(param1:*) : void
      {
         this.view = param1;
      }
      
      public function onDataChange(param1:Object) : void
      {
      }
   }
}
