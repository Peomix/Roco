package com.QQ.angel.world.role
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.combatsys.GuardianPetDes;
   import com.QQ.angel.world.npc.chip.FollowAIChip;
   import com.QQ.angel.world.npc.guardianPet.GuardianPetLogic;
   import com.QQ.angel.world.npc.guardianPet.GuardianPetView;
   import com.QQ.angel.world.vo.GuardianPetData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class GuardianPetManager
   {
      
      protected var sRAdapter:IResAdapter;
      
      protected var guardianPetDesProxy:IDataProxy;
      
      protected var layer:ILayer;
      
      protected var sList:Array;
      
      protected var sPools:Array;
      
      public function GuardianPetManager(param1:RMArgsContext)
      {
         super();
         this.sRAdapter = param1.guardianPetSkinAdapter;
         this.guardianPetDesProxy = param1.guardianPetDesProxy;
         this.sList = [];
         this.sPools = [];
      }
      
      protected function getGuardianPetByUin(param1:uint) : GuardianPetLogic
      {
         var _loc3_:GuardianPetLogic = null;
         var _loc2_:int = int(this.sList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.sList[_loc2_];
            if(_loc3_.getID() == param1)
            {
               return _loc3_;
            }
            _loc2_--;
         }
         return null;
      }
      
      public function setGuardianPetVisible(param1:uint) : void
      {
         var _loc2_:GuardianPetLogic = null;
         var _loc3_:Boolean = DEFINE.SET_AVATA_VISIBLE == 0 ? false : true;
         _loc2_ = this.getGuardianPetByUin(param1);
         if(param1 == __global.MainRoleData.id)
         {
            if(_loc2_ != null)
            {
               Sprite(_loc2_.getView()).visible = true;
            }
         }
         else if(_loc2_ != null)
         {
            Sprite(_loc2_.getView()).visible = _loc3_;
         }
      }
      
      protected function borrowGuardianPet() : GuardianPetLogic
      {
         var _loc1_:GuardianPetLogic = null;
         if(this.sPools.length == 0)
         {
            _loc1_ = new GuardianPetLogic();
            _loc1_.attachView(new GuardianPetView(this.sRAdapter));
            return _loc1_;
         }
         return this.sPools.pop() as GuardianPetLogic;
      }
      
      protected function returnGuardianPet(param1:GuardianPetLogic) : void
      {
         param1.reset();
         this.sPools.push(param1);
      }
      
      public function isFrequency(param1:int) : Boolean
      {
         return param1 < 500;
      }
      
      public function onItemClick(param1:Object) : void
      {
         var _loc2_:GuardianPetData = null;
         if(param1 is GuardianPetLogic)
         {
            _loc2_ = (param1 as GuardianPetLogic).getData() as GuardianPetData;
            if(_loc2_ != null)
            {
               if(_loc2_.uin != __global.MainRoleData.uin)
               {
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC,["GuardianPet",_loc2_.uin]);
               }
               else
               {
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC,["GuardianPet","ui"]);
               }
            }
         }
      }
      
      public function createGuardianPet(param1:IRole, param2:uint, param3:Boolean = true) : void
      {
         var _loc4_:uint = uint(param1.getID());
         var _loc5_:GuardianPetLogic = param3 ? this.getGuardianPetByUin(_loc4_) : null;
         if(null != _loc5_)
         {
            if(_loc5_.getTypeID() == param2)
            {
               return;
            }
            _loc5_.changeGuardianPetDes(this.guardianPetDesProxy.select(param2) as GuardianPetDes);
            return;
         }
         _loc5_ = this.borrowGuardianPet();
         var _loc6_:GuardianPetData = new GuardianPetData();
         _loc6_.id = _loc6_.uin = _loc4_;
         _loc6_.guardianPetDes = this.guardianPetDesProxy.select(param2) as GuardianPetDes;
         _loc6_.avatarType = _loc6_.typeID = param2;
         _loc6_.motionType = param1.getMotionType();
         _loc6_.direction = param1.getDirection();
         _loc6_.locXY = new Point();
         _loc6_.speed = 3.5;
         _loc5_.setData(_loc6_);
         _loc5_.addClickListener(this);
         var _loc7_:FollowAIChip = new FollowAIChip();
         _loc7_.setMaster(param1);
         _loc5_.insertChip(_loc7_);
         _loc5_.initialize();
         this.layer.addElement(_loc5_);
         this.sList.push(_loc5_);
         this.setGuardianPetVisible(_loc4_);
      }
      
      public function delGuardianPetByUin(param1:uint) : void
      {
         var _loc2_:GuardianPetLogic = null;
         var _loc3_:int = int(this.sList.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = this.sList[_loc3_];
            if(_loc2_.getID() == param1)
            {
               this.sList.splice(_loc3_,1);
               break;
            }
            _loc2_ = null;
            _loc3_--;
         }
         if(null == _loc2_)
         {
            return;
         }
         this.layer.removeElement(_loc2_);
         this.returnGuardianPet(_loc2_);
      }
      
      public function bindLayer(param1:ILayer) : void
      {
         this.layer = param1;
      }
      
      public function onTick() : void
      {
         var _loc2_:IHenchman = null;
         var _loc1_:int = int(this.sList.length - 1);
         while(_loc1_ >= 0)
         {
            _loc2_ = this.sList[_loc1_];
            _loc2_.onTick();
            _loc1_--;
         }
      }
      
      public function getID() : uint
      {
         return 0;
      }
      
      public function removeAll() : void
      {
         var _loc1_:GuardianPetLogic = null;
         var _loc2_:int = int(this.sList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = this.sList[_loc2_];
            if(_loc1_ != null)
            {
               this.layer.removeElement(_loc1_);
               this.returnGuardianPet(_loc1_);
            }
            _loc2_--;
         }
         this.sList = [];
         this.layer = null;
      }
   }
}

