package com.QQ.angel.world.npc.spirit
{
   import BitmapFont.font.v9.TextFieldBitmap;
   import BitmapFont.font.v9.TextFormatBitmap;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.assets.LianBD;
   import com.QQ.angel.world.assets.SpiritLV;
   import com.QQ.angel.world.events.ElementViewEvent;
   import com.QQ.angel.world.impl.BaseObjectView;
   import com.QQ.angel.world.vo.Avatar;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   
   public class SimpleSpiritView extends BaseObjectView
   {
      
      private static var ICONS:Array = [new LianBD(20,20)];
       
      
      protected var direction:int = 0;
      
      protected var resAdapter:IResAdapter;
      
      protected var currAvatarR:AvatarRequest;
      
      protected var avatarRequest:AvatarRequest;
      
      protected var gotCallBack:CFunction;
      
      protected var motionEvent:ElementViewEvent;
      
      protected var hasAvatar:Boolean = false;
      
      protected var headIcon:Bitmap;
      
      private var head_tfb:TextFieldBitmap;
      
      private var tipsAsset:SpiritLV;
      
      public function SimpleSpiritView(param1:IResAdapter, param2:uint = 0, param3:int = 0)
      {
         super();
         if(param1 == null)
         {
            throw new Error("SimpleSpiritView的资源请求适配器不能为NULL");
         }
         this.resAdapter = param1;
         setMouseEnabled(true);
         this.gotCallBack = new CFunction(this.onGotAvatarHandler,this);
         this.avatarRequest = new AvatarRequest(param2,param3,0,this.gotCallBack);
         this.currAvatarR = new AvatarRequest(param2,param3,0,this.gotCallBack);
         this.motionEvent = new ElementViewEvent(ElementViewEvent.ON_MOTION_CHANGE);
      }
      
      public function setHeadIcon(param1:int = 0) : void
      {
         if(param1 >= 2 || param1 < 0)
         {
            return;
         }
         if(this.headIcon == null)
         {
            this.headIcon = new Bitmap();
            this.headIcon.x = -10;
         }
         if(!contains(this.headIcon))
         {
            addChild(this.headIcon);
         }
         this.headIcon.bitmapData = ICONS[param1];
         this.updateHeadPos();
      }
      
      public function setHeadTxt(param1:String) : void
      {
         var _loc4_:uint = 0;
         if(param1 == null || param1 == "")
         {
            if(this.head_tfb != null)
            {
               if(contains(this.head_tfb))
               {
                  removeChild(this.head_tfb);
               }
            }
            return;
         }
         var _loc2_:TextFormatBitmap = new TextFormatBitmap();
         _loc2_.font = "DFPHaiBaoW12.MDF";
         _loc2_.size = 12;
         _loc2_.align = TextFormatAlign.CENTER;
         _loc2_.color = 16711680;
         _loc2_.letterSpacing = 3;
         if(this.head_tfb == null)
         {
            this.head_tfb = new TextFieldBitmap();
            this.head_tfb.width = 80;
            this.head_tfb.height = 15;
            this.head_tfb.defaultTextFormat = _loc2_;
         }
         if(!contains(this.head_tfb))
         {
            addChild(this.head_tfb);
         }
         var _loc3_:XML = XML(param1);
         if(_loc3_)
         {
            if(_loc3_.@color)
            {
               if(String(_loc3_.@color).split("#").length > 1)
               {
                  _loc4_ = uint("0x" + String(_loc3_.@color).split("#")[1]);
               }
               else
               {
                  _loc4_ = 16711680;
               }
            }
            _loc2_.color = _loc4_;
            this.head_tfb.text = _loc3_;
         }
         else
         {
            this.head_tfb.text = param1;
         }
         this.head_tfb.x = -(this.head_tfb.width * 0.5);
         this.updateHeadPos();
      }
      
      protected function updateHeadPos() : void
      {
         var _loc1_:Boolean = false;
         if(this.head_tfb != null && contains(this.head_tfb))
         {
            this.head_tfb.y = -body.height - 15;
            _loc1_ = true;
         }
         if(this.headIcon != null && contains(this.headIcon))
         {
            if(!_loc1_)
            {
               this.headIcon.y = -body.height - 20;
            }
            else
            {
               this.headIcon.y = this.head_tfb.y - this.head_tfb.height;
            }
         }
         if(bubble != null)
         {
            bubble.y = -body.height - 20;
         }
      }
      
      override protected function createClickArea() : void
      {
      }
      
      protected function findAvatar(param1:int, param2:Boolean = false, param3:Avatar = null) : void
      {
         if(!this.hasAvatar)
         {
            return;
         }
         this.currAvatarR.motionType = param1;
         var _loc4_:Avatar = currentAvatar;
         currentAvatar = param3 == null ? this.resAdapter.requestRes(this.currAvatarR) as Avatar : param3;
         if(_loc4_ != null)
         {
            this.resAdapter.disposeRes(_loc4_,false,param2 ? "unload" : "");
         }
      }
      
      protected function onGotAvatarHandler(param1:Avatar) : void
      {
         if(param1 == null)
         {
            this.avatarRequest.reset();
            return;
         }
         this.hasAvatar = true;
         this.currAvatarR.avatarType = this.avatarRequest.avatarType;
         this.currAvatarR.avatarVersion = this.avatarRequest.avatarVersion;
         this.findAvatar(this.currAvatarR.motionType,true,param1.frames != null ? param1 : null);
         var _loc2_:int = this.direction;
         this.direction = -1;
         this.avatarRequest.reset();
         this.playMotion(this.currAvatarR.motionType,_loc2_);
         this.updateHeadPos();
      }
      
      public function getDirection() : int
      {
         return this.direction;
      }
      
      public function getMotionType() : int
      {
         return this.currAvatarR.motionType;
      }
      
      public function playMotion(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         if(this.currAvatarR.motionType != param1)
         {
            _loc3_ = true;
            body.setYOffsets(null);
            this.findAvatar(param1);
            this.motionEvent.data = param1;
            dispatchEvent(this.motionEvent);
         }
         if(_loc3_ || this.direction != param2)
         {
            this.direction = param2;
            if(body != null && currentAvatar != null && currentAvatar.frames != null)
            {
               body.playFrames(currentAvatar.frames[param2]);
            }
         }
      }
      
      public function wearAvatar(param1:String, param2:uint, param3:int, param4:int) : void
      {
         if(this.currAvatarR.avatarURL == param1 && this.currAvatarR.avatarVersion == param3)
         {
            return;
         }
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
         }
         this.avatarRequest.avatarType = param2;
         this.avatarRequest.avatarURL = param1;
         this.avatarRequest.avatarVersion = param3;
         this.avatarRequest.motionType = param4;
         var _loc5_:Avatar;
         if((_loc5_ = this.resAdapter.requestRes(this.avatarRequest) as Avatar) != null)
         {
            this.onGotAvatarHandler(_loc5_);
         }
      }
      
      public function useTimerSelf() : Boolean
      {
         return false;
      }
      
      override public function onRender(param1:Event) : void
      {
         if(this.hasAvatar)
         {
            super.onRender(param1);
         }
      }
      
      public function set tips(param1:String) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.__over);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.__out);
         if(param1 != null && param1 != "")
         {
            if(this.tipsAsset == null)
            {
               this.tipsAsset = new SpiritLV();
            }
            this.tipsAsset.txt.text = param1;
            this.tipsAsset.bg.width = this.tipsAsset.txt.textWidth + 20;
            this.tipsAsset.y = -80;
            this.addEventListener(MouseEvent.MOUSE_OVER,this.__over);
            this.addEventListener(MouseEvent.MOUSE_OUT,this.__out);
         }
      }
      
      private function __over(param1:MouseEvent) : void
      {
         if(this.tipsAsset == null)
         {
            this.tipsAsset = new SpiritLV();
         }
         this.addChild(this.tipsAsset);
      }
      
      private function __out(param1:MouseEvent) : void
      {
         if(Boolean(this.tipsAsset) && Boolean(this.tipsAsset.parent))
         {
            this.tipsAsset.parent.removeChild(this.tipsAsset);
         }
      }
      
      public function reset() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_OVER,this.__over);
         this.removeEventListener(MouseEvent.MOUSE_OUT,this.__out);
         if(Boolean(this.tipsAsset) && Boolean(this.tipsAsset.parent))
         {
            this.tipsAsset.parent.removeChild(this.tipsAsset);
         }
         this.tipsAsset = null;
         if(!this.avatarRequest.isNull())
         {
            this.resAdapter.cancelRequest(this.avatarRequest);
            this.resAdapter.disposeRes(currentAvatar,true);
         }
         else
         {
            this.resAdapter.disposeRes(currentAvatar,false,"unload");
         }
         if(this.currAvatarR != null)
         {
            this.currAvatarR.reset(true);
         }
         if(this.avatarRequest != null)
         {
            this.avatarRequest.reset(true);
         }
         if(this.headIcon != null)
         {
            if(contains(this.headIcon))
            {
               removeChild(this.headIcon);
            }
            this.headIcon.bitmapData = null;
         }
         if(this.head_tfb != null)
         {
            this.head_tfb.text = "";
            if(contains(this.head_tfb))
            {
               removeChild(this.head_tfb);
            }
         }
         if(body != null)
         {
            body.dispose();
         }
         if(bubble != null)
         {
            bubble.setContent(null);
         }
         currentAvatar = null;
      }
      
      override public function unload() : void
      {
         super.unload();
         this.motionEvent = null;
         this.hasAvatar = false;
         this.reset();
      }
   }
}
