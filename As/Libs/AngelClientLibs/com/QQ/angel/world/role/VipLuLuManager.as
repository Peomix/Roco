package com.QQ.angel.world.role
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.world.IHenchman;
   import com.QQ.angel.api.world.role.IRole;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.OpenAsWinDes;
   import com.QQ.angel.world.npc.chip.FollowAIChip;
   import com.QQ.angel.world.npc.lulu.VipLuluLogic;
   import com.QQ.angel.world.npc.lulu.VipLuluView;
   import com.QQ.angel.world.vo.VipLuluData;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class VipLuLuManager
   {
       
      
      protected var sRAdapter:VipLuluResAdapter;
      
      protected var layer:ILayer;
      
      protected var sList:Array;
      
      protected var sPools:Array;
      
      public function VipLuLuManager()
      {
         super();
         this.sRAdapter = new VipLuluResAdapter();
         this.sRAdapter.initialize();
         this.sList = [];
         this.sPools = [];
      }
      
      protected function getVipLuluByUin(param1:uint) : VipLuluLogic
      {
         var _loc3_:VipLuluLogic = null;
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
      
      public function setLuluVisible(param1:uint) : void
      {
         var _loc2_:VipLuluLogic = null;
         var _loc3_:Boolean = DEFINE.SET_AVATA_VISIBLE == 0 ? false : true;
         _loc2_ = this.getVipLuluByUin(param1);
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
      
      protected function borrowVipLulu() : VipLuluLogic
      {
         var _loc1_:VipLuluLogic = null;
         if(this.sPools.length == 0)
         {
            _loc1_ = new VipLuluLogic();
            _loc1_.attachView(new VipLuluView(this.sRAdapter));
            return _loc1_;
         }
         return this.sPools.pop() as VipLuluLogic;
      }
      
      protected function returnLulu(param1:VipLuluLogic) : void
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
         var _loc2_:VipLuluData = null;
         var _loc3_:OpenAsWinDes = null;
         if(param1 is VipLuluLogic)
         {
            _loc2_ = (param1 as VipLuluLogic).getData() as VipLuluData;
            if(_loc2_ != null)
            {
               if(__global.MainRoleData.id != _loc2_.uin)
               {
                  return;
               }
               _loc3_ = new OpenAsWinDes();
               _loc3_.winPos = new Point(0,0);
               _loc3_.src = "activityApp://3475/ui3475";
               _loc3_.name = "";
               _loc3_.params = {
                  "ui":"NpcClick",
                  "args":null
               };
               _loc3_.cache = false;
               _loc3_.isModal = true;
               __global.openAsWin(_loc3_);
            }
            return;
         }
      }
      
      public function createVipLulu(param1:IRole, param2:int, param3:Boolean = true) : void
      {
         var _loc4_:uint = uint(param1.getID());
         var _loc5_:VipLuluLogic;
         if((_loc5_ = param3 ? this.getVipLuluByUin(_loc4_) : null) != null)
         {
            if(_loc5_.getVipLevel() == param2)
            {
               return;
            }
            _loc5_.changeLuluVip(param2);
            return;
         }
         _loc5_ = this.borrowVipLulu();
         var _loc6_:VipLuluData = new VipLuluData();
         _loc6_.id = _loc6_.uin = _loc4_;
         _loc6_.vipLevel = param2;
         _loc6_.direction = param1.getDirection();
         _loc6_.locXY = new Point();
         _loc6_.speed = param1.getSpeed();
         _loc5_.setData(_loc6_);
         _loc5_.addClickListener(this);
         var _loc7_:FollowAIChip;
         (_loc7_ = new FollowAIChip()).setMaster(param1);
         _loc5_.insertChip(_loc7_);
         _loc5_.initialize();
         this.layer.addElement(_loc5_);
         this.sList.push(_loc5_);
         this.setLuluVisible(_loc4_);
      }
      
      public function delVipLuluByUin(param1:uint) : void
      {
         var _loc2_:VipLuluLogic = null;
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
         this.returnLulu(_loc2_);
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
         var _loc1_:VipLuluLogic = null;
         var _loc2_:int = int(this.sList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = this.sList[_loc2_];
            if(_loc1_ != null)
            {
               this.layer.removeElement(_loc1_);
               this.returnLulu(_loc1_);
            }
            _loc2_--;
         }
         this.sList = [];
         this.layer = null;
      }
   }
}

import com.QQ.angel.api.res.IResAdapter;
import com.QQ.angel.api.res.IResLoadTaskManager;
import com.QQ.angel.api.world.role.RoleMotion;
import com.QQ.angel.res.AvatarRequest;
import com.QQ.angel.world.assets.VIP_1_2;
import com.QQ.angel.world.assets.VIP_3_4;
import com.QQ.angel.world.assets.VIP_5_6;
import com.QQ.angel.world.render.MotionFCS;
import com.QQ.angel.world.res.AvatarAssetProcess;
import com.QQ.angel.world.vo.Avatar;
import flash.display.BitmapData;
import flash.utils.Dictionary;

class VipLuluResAdapter implements IResAdapter
{
    
   
   protected var pngCache:Dictionary;
   
   protected var avatarCache:Dictionary;
   
   protected var mFrameCounts:Dictionary;
   
   public function VipLuluResAdapter()
   {
      super();
   }
   
   public function initialize(... rest) : void
   {
      this.pngCache = new Dictionary();
      this.pngCache[0] = VIP_1_2;
      this.pngCache[1] = VIP_3_4;
      this.pngCache[2] = VIP_5_6;
      this.avatarCache = new Dictionary();
      this.mFrameCounts = new Dictionary();
      this.mFrameCounts[RoleMotion.STAND] = new MotionFCS(RoleMotion.STAND,[1,1,1,1],null,[60,60,60,60]);
   }
   
   protected function getVipLuluAvatar(param1:uint) : Avatar
   {
      var _loc3_:Class = null;
      var _loc4_:BitmapData = null;
      var _loc2_:Avatar = this.avatarCache[param1];
      if(_loc2_ == null)
      {
         _loc3_ = this.pngCache[param1];
         if(_loc3_ != null)
         {
            _loc4_ = new _loc3_(200,100) as BitmapData;
            this.avatarCache[param1] = _loc2_ = AvatarAssetProcess.processToAvatar(_loc4_,RoleMotion.STAND,this.mFrameCounts,true);
         }
      }
      return _loc2_;
   }
   
   public function finalize() : void
   {
   }
   
   public function setResLoadTaskManager(param1:IResLoadTaskManager) : void
   {
   }
   
   public function requestRes(... rest) : Object
   {
      var _loc2_:AvatarRequest = rest[0];
      if(_loc2_ == null)
      {
         return null;
      }
      return this.getVipLuluAvatar(_loc2_.avatarType);
   }
   
   public function cancelRequest(... rest) : Boolean
   {
      return false;
   }
   
   public function disposeRes(... rest) : void
   {
   }
   
   public function getAdapterResType() : String
   {
      return "vipLuluRes";
   }
   
   public function removeAllCacheRes() : void
   {
   }
   
   public function stopAllResRequest() : void
   {
   }
}
