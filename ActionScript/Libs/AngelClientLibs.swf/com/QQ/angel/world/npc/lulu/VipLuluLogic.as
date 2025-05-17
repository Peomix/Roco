package com.QQ.angel.world.npc.lulu
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.action.ActionExecuter;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.world.vo.VipLuluData;
   import flash.display.DisplayObject;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class VipLuluLogic extends EventDispatcher implements IMotionItem, IActor, IHenchman
   {
      
      protected var luluData:VipLuluData;
      
      protected var view:VipLuluView;
      
      protected var instanceName:String = "";
      
      protected var actionExecuter:ActionExecuter;
      
      protected var id:uint = 0;
      
      protected var typeID:uint;
      
      protected var itemListener:Object;
      
      protected var lastClickTime:int = 0;
      
      protected var aiChips:Array = [];
      
      public function VipLuluLogic()
      {
         super();
         this.actionExecuter = new ActionExecuter(this);
      }
      
      protected function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(this.itemListener != null && !this.itemListener.isFrequency(_loc2_ - this.lastClickTime))
         {
            this.itemListener.onItemClick(this);
            this.lastClickTime = _loc2_;
         }
         else
         {
            trace("[SimpleSpiritLogic] SimpleSpirit的点击频率过高!!");
         }
      }
      
      public function changeLuluVip(param1:int) : void
      {
         this.luluData.vipLevel = param1;
         this.typeID = this.luluData.typeID;
         this.view.wearAvatar("",this.typeID,0,this.getMotionType());
      }
      
      public function getDirection() : int
      {
         if(this.luluData != null)
         {
            return this.luluData.direction;
         }
         return 0;
      }
      
      public function getMotionType() : int
      {
         if(this.luluData != null)
         {
            return this.luluData.motionType;
         }
         return 0;
      }
      
      public function setDirection(param1:int) : void
      {
         if(this.getDirection() == param1)
         {
            return;
         }
         this.luluData.direction = param1;
         this.view.playMotion(this.luluData.motionType,param1);
      }
      
      public function setMotionType(param1:int) : void
      {
         if(this.getMotionType() == param1)
         {
            return;
         }
         this.luluData.motionType = param1;
         this.view.playMotion(param1,this.luluData.direction);
      }
      
      public function setMotionAndDir(param1:int, param2:int) : void
      {
         if(this.getMotionType() == param1 && this.getDirection() == param2)
         {
            return;
         }
         this.luluData.motionType = param1;
         this.luluData.direction = param2;
         this.view.playMotion(param1,param2);
      }
      
      public function getPosition() : Point
      {
         return this.luluData.locXY.clone();
      }
      
      public function setPosition(param1:Point) : void
      {
         this.view.setLocation(param1);
         this.luluData.locXY.x = param1.x;
         this.luluData.locXY.y = param1.y;
      }
      
      public function getSpeed() : Number
      {
         if(this.luluData != null)
         {
            return this.luluData.speed;
         }
         return 3;
      }
      
      public function isHit(param1:Number, param2:Number) : Boolean
      {
         if(this.view == null)
         {
            return false;
         }
         return this.view.hitTestPoint(param1,param2,true);
      }
      
      public function isHit2(param1:DisplayObject) : Boolean
      {
         if(param1 == null || this.view == null)
         {
            return false;
         }
         return this.view.hitTestObject(param1);
      }
      
      public function addClickListener(param1:Object) : void
      {
         this.itemListener = param1;
      }
      
      public function initialize(... rest) : void
      {
         this.id = this.luluData.id;
         this.typeID = this.luluData.typeID;
         this.view.setLocation(this.luluData.locXY);
         this.view.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.view.playMotion(this.luluData.motionType,this.luluData.direction);
         this.view.wearAvatar("",this.typeID,0,this.luluData.motionType);
      }
      
      public function reset() : void
      {
         this.pullOutChip(0);
         this.actionExecuter.clear();
         this.view.reset();
         this.itemListener = null;
         this.view.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
      }
      
      public function finalize() : void
      {
         this.pullOutChip(0);
         this.actionExecuter.clear();
         this.view.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.view.unload();
         this.luluData = null;
         this.actionExecuter = null;
      }
      
      public function getID() : uint
      {
         return this.id;
      }
      
      public function getTypeID() : int
      {
         return this.typeID;
      }
      
      public function getVipLevel() : int
      {
         return this.luluData.vipLevel;
      }
      
      public function getName() : String
      {
         return this.instanceName;
      }
      
      public function get display() : DisplayObject
      {
         if(this.view != null)
         {
            return this.view.display;
         }
         return null;
      }
      
      public function getView() : *
      {
         return this.view;
      }
      
      public function setData(param1:Object) : void
      {
         this.luluData = param1 as VipLuluData;
      }
      
      public function getData() : Object
      {
         return this.luluData;
      }
      
      public function attachView(param1:*) : void
      {
         if(param1 is VipLuluView)
         {
            this.view = param1 as VipLuluView;
            this.instanceName = (param1 as VipLuluView).display.name;
            return;
         }
         throw new Error("角色类不能绑定非IRoleView的视图实例!");
      }
      
      public function onDataChange(param1:Object) : void
      {
      }
      
      public function act(param1:IAction) : Boolean
      {
         return this.actionExecuter.act(param1);
      }
      
      public function onTick(... rest) : void
      {
         var _loc3_:IAIChip = null;
         this.actionExecuter.onTick();
         var _loc2_:int = int(this.aiChips.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.aiChips[_loc2_];
            _loc3_.active();
            _loc2_--;
         }
      }
      
      public function insertChip(param1:IAIChip) : void
      {
         if(this.aiChips == null || this.aiChips.indexOf(param1) != -1)
         {
            return;
         }
         param1.attach(this);
         this.aiChips.push(param1);
      }
      
      public function pullOutChip(param1:int) : void
      {
         var _loc3_:IAIChip = null;
         var _loc2_:int = int(this.aiChips.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.aiChips[_loc2_];
            if(_loc3_.getType() == param1 || param1 == 0)
            {
               _loc3_.dispose();
               this.aiChips.splice(_loc2_,1);
            }
            _loc2_--;
         }
      }
   }
}

