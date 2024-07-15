package com.QQ.angel.world.npc.guardianPet
{
   import com.QQ.angel.api.world.IAIChip;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.action.ActionExecuter;
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.data.entity.combatsys.GuardianPetDes;
   import com.QQ.angel.world.assets.PetEffectAsset;
   import com.QQ.angel.world.vo.GuardianPetData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.getTimer;
   
   public class GuardianPetLogic extends EventDispatcher implements IMotionItem, IActor, IHenchman
   {
       
      
      protected var guardianPetData:GuardianPetData;
      
      protected var view:GuardianPetView;
      
      protected var instanceName:String = "";
      
      protected var actionExecuter:ActionExecuter;
      
      protected var id:uint = 0;
      
      protected var typeID:uint;
      
      protected var itemListener:Object;
      
      protected var lastClickTime:int = 0;
      
      protected var aiChips:Array;
      
      protected var effect:MovieClip;
      
      public function GuardianPetLogic()
      {
         this.aiChips = [];
         super();
         this.actionExecuter = new ActionExecuter(this);
      }
      
      protected function onGuardianPetClick(param1:MouseEvent) : void
      {
         var _loc2_:int = getTimer();
         if(Boolean(this.itemListener) && !this.itemListener.isFrequency(_loc2_ - this.lastClickTime))
         {
            this.itemListener.onItemClick(this);
            this.lastClickTime = _loc2_;
         }
         else
         {
            trace("GuardianPet的点击频率过高！");
         }
      }
      
      public function changeGuardianPetDes(param1:GuardianPetDes) : void
      {
         this.guardianPetData.avatarType = this.guardianPetData.typeID = this.typeID = param1.id;
         this.guardianPetData.guardianPetDes = param1;
         this.view.wearAvatar(param1.avatar,this.typeID,0,this.getMotionType());
      }
      
      public function getDirection() : int
      {
         if(this.guardianPetData)
         {
            return this.guardianPetData.direction;
         }
         return 0;
      }
      
      public function getMotionType() : int
      {
         if(this.guardianPetData)
         {
            return this.guardianPetData.motionType;
         }
         return 0;
      }
      
      public function setDirection(param1:int) : void
      {
         if(this.getDirection() == param1)
         {
            return;
         }
         this.guardianPetData.direction = param1;
         this.view.playMotion(this.guardianPetData.motionType,param1);
      }
      
      public function setMotionType(param1:int) : void
      {
         if(this.getMotionType() == param1)
         {
            return;
         }
         this.guardianPetData.motionType = param1;
         this.view.playMotion(param1,this.guardianPetData.direction);
      }
      
      public function setMotionAndDir(param1:int, param2:int) : void
      {
         if(this.getMotionType() == param1 && this.getDirection() == param2)
         {
            return;
         }
         this.guardianPetData.motionType = param1;
         this.guardianPetData.direction = param2;
         this.view.playMotion(param1,param2);
      }
      
      public function getPosition() : Point
      {
         return this.guardianPetData.locXY.clone();
      }
      
      public function setPosition(param1:Point) : void
      {
         this.view.setLocation(param1);
         this.guardianPetData.locXY.x = param1.x;
         this.guardianPetData.locXY.y = param1.y;
      }
      
      public function getSpeed() : Number
      {
         if(this.guardianPetData)
         {
            return this.guardianPetData.speed;
         }
         return 0;
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
         this.id = this.guardianPetData.id;
         this.view.setLocation(this.guardianPetData.locXY);
         this.view.addEventListener(MouseEvent.CLICK,this.onGuardianPetClick);
         this.view.playMotion(this.guardianPetData.motionType,this.guardianPetData.direction);
         this.view.wearAvatar(this.guardianPetData.guardianPetDes.avatar,this.guardianPetData.avatarType,this.guardianPetData.avatarVersion,this.guardianPetData.motionType);
      }
      
      public function reset() : void
      {
         this.deleteEffect();
         this.pullOutChip(0);
         this.actionExecuter.clear();
         this.view.reset();
         this.itemListener = null;
         this.view.removeEventListener(MouseEvent.CLICK,this.onGuardianPetClick);
      }
      
      public function finalize() : void
      {
         this.pullOutChip(0);
         this.actionExecuter.clear();
         this.view.removeEventListener(MouseEvent.CLICK,this.onGuardianPetClick);
         this.view.unload();
         this.guardianPetData = null;
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
         this.guardianPetData = param1 as GuardianPetData;
      }
      
      public function getData() : Object
      {
         return this.guardianPetData;
      }
      
      public function attachView(param1:*) : void
      {
         if(param1 is GuardianPetView)
         {
            this.view = param1 as GuardianPetView;
            this.instanceName = (param1 as GuardianPetView).display.name;
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
         if(param1 == null || this.aiChips.indexOf(param1) != -1)
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
      
      public function insertEffect(param1:uint) : void
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
         if(this.effect.parent)
         {
            this.effect.parent.removeChild(this.effect);
         }
      }
   }
}
