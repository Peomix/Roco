package com.QQ.angel.world.role
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.world.npc.chip.FollowAIChip;
   import com.QQ.angel.world.npc.spirit.SimpleSpiritLogic;
   import com.QQ.angel.world.npc.spirit.SimpleSpiritView;
   import com.QQ.angel.world.vo.SpiritData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class RoleSpiritsManager
   {
       
      
      protected var sRAdapter:IResAdapter;
      
      protected var spiritDesProxy:IDataProxy;
      
      protected var layer:ILayer;
      
      protected var sList:Array;
      
      protected var sPools:Array;
      
      public function RoleSpiritsManager(param1:RMArgsContext)
      {
         super();
         this.sRAdapter = param1.petSkinAdapter;
         this.spiritDesProxy = param1.spiritDesProxy;
         this.sList = [];
         this.sPools = [];
      }
      
      public function getHenchManByUin(param1:uint) : SimpleSpiritLogic
      {
         var _loc3_:SimpleSpiritLogic = null;
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
      
      public function setSpiritVisible(param1:uint) : void
      {
         var _loc2_:SimpleSpiritLogic = null;
         var _loc3_:Boolean = DEFINE.SET_AVATA_VISIBLE == 0 ? false : true;
         _loc2_ = this.getHenchManByUin(param1);
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
      
      protected function borrowSpirit() : SimpleSpiritLogic
      {
         var _loc1_:SimpleSpiritLogic = null;
         if(this.sPools.length == 0)
         {
            _loc1_ = new SimpleSpiritLogic();
            _loc1_.attachView(new SimpleSpiritView(this.sRAdapter));
            return _loc1_;
         }
         return this.sPools.pop() as SimpleSpiritLogic;
      }
      
      protected function returnSpirit(param1:SimpleSpiritLogic) : void
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
         var _loc2_:SpiritData = null;
         if(param1 is SimpleSpiritLogic)
         {
            _loc2_ = (param1 as SimpleSpiritLogic).getData() as SpiritData;
            if(_loc2_ != null)
            {
               __global.GEventAPI.cmdExecuted(AngelSysEvent.ON_SPIRIT_BAG,_loc2_.uin);
            }
            return;
         }
      }
      
      public function createHenchman(param1:IRole, param2:uint, param3:Boolean = true) : void
      {
         var _loc4_:uint = uint(param1.getID());
         var _loc5_:SimpleSpiritLogic = param3 ? this.getHenchManByUin(_loc4_) : null;
         var _loc6_:* = param2 >> 28 & 15;
         param2 &= 268435455;
         if(_loc5_ != null)
         {
            if(_loc5_.getTypeID() == param2 && _loc5_.getSpiritSkinID() == _loc6_)
            {
               return;
            }
            _loc5_.changeSpiritDes(this.spiritDesProxy.select(param2) as SpiritDes,_loc6_);
            return;
         }
         _loc5_ = this.borrowSpirit();
         var _loc7_:SpiritData = new SpiritData();
         _loc7_.id = _loc7_.uin = _loc4_;
         _loc7_.skinID = _loc6_;
         _loc7_.spiritDes = this.spiritDesProxy.select(param2) as SpiritDes;
         _loc7_.avatarType = _loc7_.typeID = param2;
         _loc7_.motionType = param1.getMotionType();
         _loc7_.direction = param1.getDirection();
         _loc7_.locXY = new Point();
         _loc7_.speed = 3.5;
         _loc5_.setData(_loc7_);
         _loc5_.addClickListener(this);
         var _loc8_:FollowAIChip;
         (_loc8_ = new FollowAIChip()).setMaster(param1);
         _loc5_.insertChip(_loc8_);
         _loc5_.initialize();
         this.layer.addElement(_loc5_);
         this.sList.push(_loc5_);
         this.setSpiritVisible(_loc4_);
      }
      
      public function delHenchmanByUin(param1:uint) : void
      {
         var _loc2_:SimpleSpiritLogic = null;
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
         if(_loc2_ == null)
         {
            return;
         }
         this.layer.removeElement(_loc2_);
         this.returnSpirit(_loc2_);
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
         var _loc1_:SimpleSpiritLogic = null;
         var _loc2_:int = int(this.sList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = this.sList[_loc2_];
            if(_loc1_ != null)
            {
               this.layer.removeElement(_loc1_);
               this.returnSpirit(_loc1_);
            }
            _loc2_--;
         }
         this.sList = [];
         this.layer = null;
      }
   }
}
