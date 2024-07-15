package com.QQ.angel.world.actions
{
   import com.QQ.angel.api.IResourceSysAPI;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.action.AbstractAction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.MakeMagicDes;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   
   public class ThrowAction extends AbstractAction
   {
       
      
      protected var makeMSDes:MakeMagicDes;
      
      protected var sceneLogic:IAngelSceneLogic;
      
      protected var container:DisplayObjectContainer;
      
      protected var resM:IResourceSysAPI;
      
      protected var object:Sprite;
      
      protected var shadow:MovieClip;
      
      protected var t:int = 0;
      
      protected var duration:Number;
      
      protected var peak:Number;
      
      protected var change_x:Number;
      
      protected var change_y:Number;
      
      protected var change_height1:Number;
      
      protected var change_height2:Number;
      
      protected var max_height:Number = -100;
      
      protected var start_height:Number = -2;
      
      protected var start_x:Number;
      
      protected var start_y:Number;
      
      protected var target_x:Number;
      
      protected var target_y:Number;
      
      protected var hasResLoad:Boolean = false;
      
      protected var hasReplace:Boolean = false;
      
      protected var state:int = 0;
      
      public function ThrowAction(param1:Object)
      {
         this.makeMSDes = param1 as MakeMagicDes;
         super(ActionsIntro.ThrowAction);
      }
      
      protected function findDistance(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         return Math.sqrt(_loc6_ * _loc6_ + _loc5_ * _loc5_);
      }
      
      protected function findAngle(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = param3 - param1;
         var _loc6_:Number = param4 - param2;
         var _loc7_:Number;
         return (_loc7_ = int(Math.atan2(_loc6_,_loc5_) * 57.29578 - 90)) < 0 ? _loc7_ + 360 : _loc7_;
      }
      
      protected function findDirection(param1:Number) : Number
      {
         var _loc2_:Number = Math.round(param1 / 45) + 1;
         return _loc2_ > 8 ? 1 : _loc2_;
      }
      
      protected function mathLinearTween(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param3 * param1 / param4 + param2;
      }
      
      protected function mathEaseOutQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 /= param4;
         return -param3 * param1 * (param1 - 2) + param2;
      }
      
      protected function mathEaseInQuad(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 /= param4;
         return param3 * param1 * param1 + param2;
      }
      
      protected function startNotRender(param1:Object) : Boolean
      {
         if(__global.SysAPI.getIsRender())
         {
            return false;
         }
         return true;
      }
      
      protected function curseResLoaded(param1:LoadTaskEvent) : void
      {
         var _loc3_:MovieClip = null;
         if(this.makeMSDes == null)
         {
            return;
         }
         var _loc2_:Sprite = this.resM.borrowObj(this.makeMSDes.useMS.id) as Sprite;
         if(this.container.contains(this.object))
         {
            _loc2_.x = this.object.x;
            _loc2_.y = this.object.y;
            if(_loc2_.numChildren)
            {
               _loc3_ = _loc2_.getChildAt(0) as MovieClip;
               _loc3_.gotoAndStop(1);
               _loc3_.y = this.shadow.y;
            }
            if(this.t < this.duration)
            {
               this.container.removeChild(this.object);
               this.shadow = _loc3_;
               this.object = _loc2_;
               this.container.addChild(this.object);
               this.hasReplace = true;
            }
         }
      }
      
      override public function start(param1:Object) : void
      {
         var _loc6_:* = undefined;
         var _loc7_:CFunction = null;
         var _loc8_:ColorTransform = null;
         if(this.startNotRender(param1))
         {
            return;
         }
         this.sceneLogic = param1 as IAngelSceneLogic;
         if(this.sceneLogic == null)
         {
            return;
         }
         this.resM = __global.SysAPI.getResSysAPI();
         this.container = __global.SysAPI.getUISysAPI().getEffectContainer();
         var _loc2_:Point = __global.SysAPI.getWorldAPI().getSceneAPI().getSceneLogic().getContainer().localToGlobal(this.makeMSDes.userPos);
         this.start_x = _loc2_.x;
         this.start_y = _loc2_.y - 60;
         this.target_x = this.makeMSDes.aimPos.x;
         this.target_y = this.makeMSDes.aimPos.y;
         var _loc3_:Number = this.target_x - this.start_x;
         if(_loc3_ > 40)
         {
            this.start_x += 40;
         }
         else if(_loc3_ < -40)
         {
            this.start_x -= 40;
         }
         if(!this.makeMSDes.isClient)
         {
            if((_loc6_ = this.resM.borrowObj(this.makeMSDes.useMS.id)) is CFunction)
            {
               _loc7_ = _loc6_ as CFunction;
               _loc6_.handler = this.curseResLoaded;
               this.object = this.resM.borrowObj(1027) as Sprite;
               (_loc8_ = this.object.transform.colorTransform).alphaMultiplier = 0.3;
               _loc8_.redMultiplier = 0;
               _loc8_.blueMultiplier = 1;
               _loc8_.greenMultiplier = 0.8;
               _loc8_.blueOffset = 255;
               this.object.transform.colorTransform = _loc8_;
               this.hasResLoad = true;
            }
            else
            {
               this.object = this.resM.borrowObj(this.makeMSDes.useMS.id) as Sprite;
            }
         }
         else
         {
            this.object = this.makeMSDes.openMSDes.clientArg as Sprite;
         }
         if(this.object.numChildren)
         {
            this.shadow = this.object.getChildAt(0) as MovieClip;
         }
         else
         {
            this.shadow = new MovieClip();
            this.object.addChild(this.shadow);
         }
         this.shadow.gotoAndStop(1);
         this.object.mouseChildren = false;
         this.object.mouseEnabled = false;
         this.object.cacheAsBitmap = true;
         this.object.x = this.start_x;
         this.object.y = this.start_y;
         this.container.addChild(this.object);
         var _loc4_:Number = this.findDistance(this.start_x,this.start_y,this.target_x,this.target_y);
         var _loc5_:Number = this.findAngle(this.start_x,this.start_y,this.target_x,this.target_y);
         this.duration = _loc4_ / 20;
         this.change_x = this.target_x - this.start_x;
         this.change_y = this.target_y - this.start_y;
         this.peak = this.duration / 2;
         this.change_height1 = this.max_height - this.start_height;
         this.change_height2 = -this.max_height;
         this.shadow.y = this.start_height;
         this.t = 0;
         setFinished(false);
      }
      
      override public function onAct(param1:Object) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         if(this.state != 0)
         {
            return;
         }
         ++this.t;
         if(this.t < this.duration)
         {
            this.object.x = this.mathLinearTween(this.t,this.start_x,this.change_x,this.duration);
            this.object.y = this.mathLinearTween(this.t,this.start_y,this.change_y,this.duration);
            if(this.t < this.peak)
            {
               this.shadow.y = this.mathEaseOutQuad(this.t,this.start_height,this.change_height1,this.peak);
            }
            else
            {
               this.shadow.y = this.mathEaseInQuad(this.t - this.peak,this.max_height,this.change_height2,this.peak);
            }
         }
         else
         {
            this.object.x = this.target_x;
            this.object.y = this.target_y;
            this.shadow.y = 0;
            this.state = 1;
            if(this.makeMSDes.isClient)
            {
               _loc3_ = this.makeMSDes.openMSDes.id;
            }
            else
            {
               _loc3_ = this.makeMSDes.useMS.id;
            }
            this.sceneLogic.itemAcceptMagic(_loc3_,new Point(this.target_x,this.target_y),this.makeMSDes.userUin);
            if(this.hasResLoad && !this.hasReplace)
            {
               this.onMVEndHandler(null);
               return;
            }
            this.object.cacheAsBitmap = false;
            this.shadow.addEventListener("onMVEnd",this.onMVEndHandler);
            if(this.shadow.totalFrames == 1)
            {
               this.onMVEndHandler(null);
            }
            else
            {
               this.shadow.play();
            }
         }
      }
      
      override public function giveUp() : Boolean
      {
         if(this.state != 0 && this.shadow != null)
         {
            this.shadow.removeEventListener("onMVEnd",this.onMVEndHandler);
         }
         if(this.object != null)
         {
            this.shadow.stop();
            this.object.cacheAsBitmap = false;
            this.container.removeChild(this.object);
            if(!this.makeMSDes.isClient)
            {
               if(!this.hasResLoad || this.hasReplace)
               {
                  this.resM.giveBackObj(this.makeMSDes.useMS.id,this.object);
               }
            }
            else if(this.object.hasOwnProperty("dispose"))
            {
               this.object["dispose"]();
            }
            this.object = null;
            this.shadow = null;
         }
         this.sceneLogic = null;
         this.makeMSDes = null;
         this.resM = null;
         this.container = null;
         return super.giveUp();
      }
      
      protected function onMVEndHandler(param1:Event) : void
      {
         this.giveUp();
      }
   }
}
