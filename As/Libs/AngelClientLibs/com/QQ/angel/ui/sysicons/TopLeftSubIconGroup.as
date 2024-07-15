package com.QQ.angel.ui.sysicons
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.common.ISceneListener;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.*;
   import com.QQ.angel.utils.Tween;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class TopLeftSubIconGroup extends SysIconGroup implements ISceneListener
   {
       
      
      private var tooltipPos:Point;
      
      private var mc:BarAsset;
      
      public var LockIconExpand:Boolean = false;
      
      private var zeroX:int = 0;
      
      private var spaceX:int = 55;
      
      private var startX:int = 27;
      
      private var startY:int = -10;
      
      protected var _expand:* = null;
      
      public function TopLeftSubIconGroup()
      {
         this.mc = new BarAsset();
         super();
         this.tooltipPos = new Point(0,70);
         this.addChild(this.mc);
         this.mc.x = 6;
         this.mc.y = 75;
         this.mc.stop();
         this.mc.bgClose.visible = false;
         this.mc.bgOpen.visible = false;
         this.mc.bgClose.gotoAndStop(1);
         this.mc.bgOpen.gotoAndStop(1);
         this.mc.closeBtn.visible = false;
         this.mc.expandBtn.visible = false;
         this.mc.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_CONFIG_LOADED,this.onSceneConfigLoaded);
      }
      
      private function onSceneConfigLoaded(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:XML = null;
         if(Boolean(param2) && Boolean(param2.npcXML))
         {
            if((_loc5_ = new XML(param2.npcXML)).hasOwnProperty("SceneDes"))
            {
               if(_loc5_.SceneDes[0].hasOwnProperty("@closeSubIcons") && _loc5_.SceneDes[0].@closeSubIcons == "1")
               {
                  this.LockIconExpand = true;
               }
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function enterScene(param1:SceneDes) : void
      {
         if(Boolean(param1) && (param1.sceneID == 10000 || param1.sceneID == 11000))
         {
            this.visible = false;
         }
         else if(_icons.length > 0)
         {
            this.visible = true;
         }
      }
      
      public function leaveScene(param1:SceneDes) : void
      {
         this.LockIconExpand = false;
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "expandBtn":
               this.LockIconExpand = false;
               this.expandFunc(true);
               break;
            case "closeBtn":
               this.expandFunc(false);
         }
      }
      
      private function expandFunc(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         if(param1 == this._expand)
         {
            return;
         }
         if(_showIcons && _showIcons.length == 0 && param1 == true)
         {
            this._expand = false;
         }
         else
         {
            this._expand = param1;
         }
         if(_icons.length == 0)
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
         if(this._expand)
         {
            this.mc.bgClose.visible = false;
            this.mc.bgOpen.visible = true;
            this.mc.bgClose.gotoAndStop(1);
            if(this.mc.bgOpen.currentFrame == 1)
            {
               this.mc.bgOpen.gotoAndPlay(1);
            }
            this.mc.closeBtn.visible = true;
            this.mc.expandBtn.visible = false;
            _loc2_ = 0;
            while(_loc2_ < _showIcons.length)
            {
               _loc3_ = _showIcons[_loc2_];
               _loc3_.visible = true;
               Tween.to(_loc3_,0.2,{
                  "x":this.startX + _loc2_ * this.spaceX,
                  "alpha":1
               },null,null,(_showIcons.length - _loc2_ - 1) * 0.2);
               _loc2_++;
            }
         }
         else
         {
            this.mc.bgClose.visible = true;
            this.mc.bgOpen.visible = false;
            if(this.mc.bgClose.currentFrame == 1)
            {
               this.mc.bgClose.gotoAndPlay(1);
            }
            this.mc.bgOpen.gotoAndStop(1);
            this.mc.closeBtn.visible = false;
            this.mc.expandBtn.visible = true;
            _loc2_ = 0;
            while(_loc2_ < _showIcons.length)
            {
               _loc4_ = _showIcons[_loc2_];
               Tween.to(_loc4_,0.2,{
                  "x":0,
                  "alpha":0
               },null,this.delegateFunc(this.setVisible,_loc4_),_loc2_ * 0.2);
               _loc2_++;
            }
         }
      }
      
      public function set expand(param1:Boolean) : void
      {
         if(this.LockIconExpand)
         {
            this.expandFunc(false);
         }
         else
         {
            this.expandFunc(param1);
         }
      }
      
      private function setVisible(param1:Object) : void
      {
         if(param1)
         {
            param1.visible = false;
         }
      }
      
      private function delegateFunc(param1:Function, param2:Object) : Function
      {
         var func:Function = param1;
         var param:Object = param2;
         return function():void
         {
            func(param);
         };
      }
      
      override protected function addIconToStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && !this.mc.container.contains(_loc2_))
         {
            this.mc.container.addChild(_loc2_);
         }
         this.mc.visible = true;
         __global.sceneWatcher && __global.sceneWatcher.addSceneListener(this);
      }
      
      override protected function removeIconFromStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && this.mc.container.contains(_loc2_))
         {
            this.mc.container.removeChild(_loc2_);
         }
      }
      
      override protected function placeIcons() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:ISysIcon = null;
         _icons.sortOn("seat",Array.NUMERIC);
         _showIcons = _icons.filter(isIconEnable);
         var _loc1_:int = int(_icons.length);
         var _loc4_:int = 0;
         if(_loc1_ == 0)
         {
            this.expand = false;
         }
         else
         {
            this.expand = true;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc1_)
         {
            _loc2_ = _icons[_loc5_] as Sprite;
            _loc3_ = _icons[_loc5_] as ISysIcon;
            if(_loc2_ != null)
            {
               if(this._expand)
               {
                  if(_loc3_.enable)
                  {
                     _loc2_.x = this.startX + _loc4_ * this.spaceX;
                     _loc2_.visible = true;
                     _loc4_++;
                     this.addIconToStage(_loc3_);
                  }
                  else
                  {
                     this.removeIconFromStage(_loc3_);
                  }
               }
               else
               {
                  _loc2_.x = this.zeroX;
                  _loc2_.visible = false;
                  _loc2_.alpha = 0;
                  this.addIconToStage(_loc3_);
               }
               _loc2_.y = this.startY;
               _icons[_loc5_].tooltipPos = this.tooltipPos;
            }
            _loc5_++;
         }
      }
   }
}
