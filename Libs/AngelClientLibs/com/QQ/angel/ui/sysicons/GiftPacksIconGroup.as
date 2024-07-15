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
   import flash.utils.Dictionary;
   
   public class GiftPacksIconGroup extends SysIconGroup implements ISceneListener
   {
       
      
      private var _expand:* = null;
      
      private const OneIconPos_X:int = 12;
      
      private const OneIconPos_Y:int = -56;
      
      private const Start_X:int = -16;
      
      private const Start_Y:int = -52;
      
      private const Space_X:int = 60;
      
      private const tooltipPos:Point = new Point(0,70);
      
      private var _resBar:GiftPacksIconBar;
      
      private var _effectDict:Dictionary;
      
      public var LockIconExpand:Boolean = false;
      
      public function GiftPacksIconGroup()
      {
         super();
         this._resBar = new GiftPacksIconBar();
         addChild(this._resBar);
         this._resBar.x = 920;
         this._resBar.y = 115;
         this._resBar.gotoAndStop(1);
         this._resBar.bgClose.visible = false;
         this._resBar.bgOpen.visible = false;
         this._resBar.bgClose.gotoAndStop(1);
         this._resBar.bgOpen.gotoAndStop(1);
         this._resBar.closeBtn.visible = false;
         this._resBar.expandBtn.visible = false;
         this._resBar.addEventListener(MouseEvent.CLICK,this.onBarClick);
         this._resBar.visible = false;
         this._effectDict = new Dictionary();
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
      
      private function onBarClick(param1:MouseEvent) : void
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
      
      override protected function addIconToStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && !this._resBar.container.contains(_loc2_))
         {
            this._resBar.container.addChildAt(_loc2_,0);
         }
         this._resBar.visible = true;
         __global.sceneWatcher && __global.sceneWatcher.addSceneListener(this);
      }
      
      override protected function removeIconFromStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && this._resBar.container.contains(_loc2_))
         {
            this._resBar.container.removeChild(_loc2_);
         }
      }
      
      override protected function placeIcons() : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:ISysIcon = null;
         var _loc5_:int = 0;
         _icons.sortOn("seat",Array.NUMERIC);
         _showIcons = _icons.filter(isIconEnable);
         var _loc1_:uint = _icons.length;
         var _loc4_:int = 0;
         if(_loc1_ <= 0)
         {
            this.visible = false;
            this.expand = false;
         }
         else
         {
            this.expand = true;
            this.visible = true;
            if(_loc1_ <= 1)
            {
               _loc2_ = _icons[0] as Sprite;
               _loc3_ = _loc2_ as ISysIcon;
               _loc2_.visible = true;
               _loc2_.alpha = 1;
               _icons[0].tooltipPos = this.tooltipPos;
               _loc2_.x = this.OneIconPos_X;
               _loc2_.y = this.OneIconPos_Y;
               if(_loc3_.enable)
               {
                  this.addIconToStage(_loc2_ as ISysIcon);
               }
               else
               {
                  this.removeIconFromStage(_loc3_);
               }
            }
            else
            {
               _loc5_ = 0;
               while(_loc5_ < _loc1_)
               {
                  _loc3_ = _icons[_loc5_] as ISysIcon;
                  _loc2_ = _icons[_loc5_] as Sprite;
                  if(_loc2_ != null)
                  {
                     if(this.expand)
                     {
                        if(_loc3_.enable)
                        {
                           _loc2_.x = this.Start_X - _loc4_ * this.Space_X;
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
                        _loc2_.x = this.OneIconPos_X;
                        if(_loc2_.hasOwnProperty("_isAlwaysShow") && _loc2_["_isAlwaysShow"] == true)
                        {
                           _loc2_.x = this.Start_X - _loc4_ * this.Space_X;
                           _loc2_.visible = true;
                           _loc4_++;
                           this.addIconToStage(_loc3_);
                        }
                        else
                        {
                           _loc2_.visible = false;
                           this.addIconToStage(_loc3_);
                        }
                     }
                     _loc2_.y = this.Start_Y;
                     _icons[_loc5_].tooltipPos = this.tooltipPos;
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      public function enterScene(param1:SceneDes) : void
      {
         if(Boolean(param1) && (param1.sceneID == 10000 || param1.sceneID == 11000))
         {
            this.visible = false;
         }
         else
         {
            this.visible = true;
         }
      }
      
      public function leaveScene(param1:SceneDes) : void
      {
         this.LockIconExpand = false;
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
      
      public function get expand() : Boolean
      {
         return this._expand;
      }
      
      public function updateEffect(param1:uint, param2:Boolean) : void
      {
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
      
      private function expandFunc(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc4_:Sprite = null;
         this._expand = param1;
         var _loc3_:uint = _showIcons.length;
         if(_loc3_ <= 1)
         {
            return;
         }
         if(this._expand)
         {
            this._resBar.bgClose.visible = false;
            this._resBar.bgOpen.visible = true;
            this._resBar.bgClose.gotoAndStop(1);
            if(this._resBar.bgOpen.currentFrame == 1)
            {
               this._resBar.bgOpen.gotoAndPlay(1);
            }
            this._resBar.closeBtn.visible = true;
            this._resBar.expandBtn.visible = false;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               (_loc4_ = _showIcons[_loc2_]).visible = true;
               Tween.to(_loc4_,0.2,{
                  "x":this.Start_X - _loc2_ * this.Space_X,
                  "alpha":1
               },null,null,(_loc3_ - _loc2_ - 1) * 0.2);
               _loc2_++;
            }
         }
         else
         {
            this._resBar.bgClose.visible = true;
            this._resBar.bgOpen.visible = false;
            if(this._resBar.bgClose.currentFrame == 1)
            {
               this._resBar.bgClose.gotoAndPlay(1);
            }
            this._resBar.bgOpen.gotoAndStop(1);
            this._resBar.closeBtn.visible = false;
            this._resBar.expandBtn.visible = true;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               if(!(_loc4_ = _showIcons[_loc2_]).hasOwnProperty("_isAlwaysShow") || _loc4_.hasOwnProperty("_isAlwaysShow") && _loc4_["_isAlwaysShow"] == false)
               {
                  Tween.to(_loc4_,0.2,{
                     "x":0,
                     "alpha":0
                  },null,this.delegateFunc(this.setVisible,_loc4_),(_loc3_ - _loc2_ - 1) * 0.2);
               }
               _loc2_++;
            }
         }
      }
   }
}
