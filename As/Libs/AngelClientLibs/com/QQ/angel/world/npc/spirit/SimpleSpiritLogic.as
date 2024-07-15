package com.QQ.angel.world.npc.spirit
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.action.ActionExecuter;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.world.assets.PetEffectAsset;
   import com.QQ.angel.world.vo.SpiritData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class SimpleSpiritLogic extends EventDispatcher implements IMotionItem, IActor, IHenchman
   {
       
      
      protected var spiritData:SpiritData;
      
      protected var instanceName:String = "";
      
      protected var view:SimpleSpiritView;
      
      protected var actionExecuter:ActionExecuter;
      
      protected var id:uint = 0;
      
      protected var spiritSkinID:uint = 0;
      
      protected var typeID:uint;
      
      protected var itemListener:Object;
      
      protected var lastClickTime:int = 0;
      
      protected var aiChips:Array;
      
      protected var effect:MovieClip;
      
      public var tips:String = "";
      
      public function SimpleSpiritLogic()
      {
         this.aiChips = [];
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
      
      public function changeSpiritDes(param1:SpiritDes, param2:int) : void
      {
         var _loc3_:String = null;
         this.spiritData.typeID = this.spiritData.avatarType = this.typeID = param1.id;
         this.spiritData.skinID = param2;
         this.spiritData.spiritDes = param1;
         this.spiritSkinID = param2;
         if(param2 != 0)
         {
            this.spiritData.typeID = this.spiritData.avatarType = this.typeID = 100000 + param1.id * 10 + (param2 - 1);
            _loc3_ = param1.avatar.split("spirit/")[0] + "spirit/" + (100000 + param1.id * 10 + (param2 - 1)) + "-.swf" + param1.avatar.split("-.swf")[1];
            this.view.wearAvatar(_loc3_,this.typeID,0,this.getMotionType());
         }
         else
         {
            this.view.wearAvatar(param1.avatar,this.typeID,0,this.getMotionType());
         }
      }
      
      public function getDirection() : int
      {
         if(this.spiritData != null)
         {
            return this.spiritData.direction;
         }
         return 0;
      }
      
      public function getMotionType() : int
      {
         if(this.spiritData != null)
         {
            return this.spiritData.motionType;
         }
         return 0;
      }
      
      public function setDirection(param1:int) : void
      {
         if(this.getDirection() == param1)
         {
            return;
         }
         this.spiritData.direction = param1;
         this.view.playMotion(this.spiritData.motionType,param1);
      }
      
      public function setMotionType(param1:int) : void
      {
         if(this.getMotionType() == param1)
         {
            return;
         }
         this.spiritData.motionType = param1;
         this.view.playMotion(param1,this.spiritData.direction);
      }
      
      public function setMotionAndDir(param1:int, param2:int) : void
      {
         if(this.getMotionType() == param1 && this.getDirection() == param2)
         {
            return;
         }
         this.spiritData.motionType = param1;
         this.spiritData.direction = param2;
         this.view.playMotion(param1,param2);
      }
      
      public function getPosition() : Point
      {
         return this.spiritData.locXY.clone();
      }
      
      public function setPosition(param1:Point) : void
      {
         this.view.setLocation(param1);
         this.spiritData.locXY.x = param1.x;
         this.spiritData.locXY.y = param1.y;
      }
      
      public function getSpeed() : Number
      {
         if(this.spiritData != null)
         {
            return this.spiritData.speed;
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
         var _loc2_:String = null;
         this.id = this.spiritData.id;
         this.typeID = this.spiritData.typeID;
         this.view.setLocation(this.spiritData.locXY);
         this.view.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.view.playMotion(this.spiritData.motionType,this.spiritData.direction);
         this.spiritSkinID = this.spiritData.skinID;
         if(this.spiritData.skinID != 0)
         {
            this.typeID = 100000 + this.spiritData.spiritDes.id * 10 + (this.spiritData.skinID - 1);
            _loc2_ = this.spiritData.spiritDes.avatar.split("spirit/")[0] + "spirit/" + (100000 + this.spiritData.spiritDes.id * 10 + (this.spiritData.skinID - 1)) + "-.swf" + this.spiritData.spiritDes.avatar.split("-.swf")[1];
            this.view.wearAvatar(_loc2_,this.typeID,this.spiritData.avatarVersion,this.spiritData.motionType);
         }
         else
         {
            this.view.wearAvatar(this.spiritData.spiritDes.avatar,this.spiritData.avatarType,this.spiritData.avatarVersion,this.spiritData.motionType);
         }
         this.view.setHeadIcon(this.spiritData.headType);
         this.view.setHeadTxt(this.spiritData.headTxt);
         this.view.tips = this.tips;
      }
      
      public function reset() : void
      {
         this.tips = "";
         this.deleteEffect();
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
         this.spiritData = null;
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
      
      public function getSpiritSkinID() : int
      {
         return this.spiritSkinID;
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
         this.spiritData = param1 as SpiritData;
      }
      
      public function getData() : Object
      {
         return this.spiritData;
      }
      
      public function attachView(param1:*) : void
      {
         if(param1 is SimpleSpiritView)
         {
            this.view = param1 as SimpleSpiritView;
            this.instanceName = (param1 as SimpleSpiritView).display.name;
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
      
      public function insertEffect(param1:uint = 0) : void
      {
         if(param1 != 1)
         {
            return;
         }
         if(this.effect == null)
         {
            this.effect = new PetEffectAsset();
         }
         this.effect.y = -10;
         this.effect.gotoAndPlay(2);
         this.getView().addChildAt(this.effect,0);
      }
      
      public function deleteEffect() : void
      {
         if(this.effect == null)
         {
            return;
         }
         this.effect.gotoAndStop("BLANK");
         if(this.effect.parent != null)
         {
            this.effect.parent.removeChild(this.effect);
         }
      }
   }
}
