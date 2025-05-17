package com.QQ.angel.ui.sysicons
{
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.common.__global;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public class TopRightIconGroup extends SysIconGroup
   {
      
      private var tooltipPos:Point;
      
      private var exIconListDic:Dictionary = new Dictionary();
      
      public function TopRightIconGroup()
      {
         super();
         this.tooltipPos = new Point(-10,70);
      }
      
      override public function addSysIconAt(param1:ISysIcon, param2:int) : ISysIcon
      {
         param1.seat = param2;
         setStatus(param1);
         var _loc3_:ISysIcon = getIconBySeat(param2);
         if(_loc3_)
         {
            this.addExIconList(param2,param1);
         }
         else
         {
            _icons.push(param1);
            this.placeIcons();
         }
         addIconToList(param1);
         return param1;
      }
      
      override public function addIconAt(param1:SysIconData, param2:int) : ISysIcon
      {
         var _loc3_:Class = null;
         var _loc4_:ISysIcon = null;
         if(param1.url.search(".swf") == -1)
         {
            _loc3_ = getSysIconClass();
            _loc4_ = new _loc3_() as SysIcon;
         }
         else
         {
            _loc3_ = getSysSWFIconClass();
            _loc4_ = new _loc3_() as SysSWFIcon;
         }
         _loc4_.data = param1;
         _loc4_.seat = param2;
         setStatus(_loc4_);
         var _loc5_:ISysIcon = getIconBySeat(param2);
         if(_loc5_)
         {
            this.addExIconList(param2,_loc4_);
         }
         else
         {
            _icons.push(_loc4_);
            this.placeIcons();
         }
         addIconToList(_loc4_);
         return _loc4_;
      }
      
      private function addExIconList(param1:int, param2:ISysIcon) : void
      {
         var _loc4_:ISysIcon = null;
         if(this.exIconListDic[param1] == null)
         {
            _loc4_ = getIconBySeat(param1);
            this.exIconListDic[param1] = new ExIconListData(_loc4_,this);
         }
         var _loc3_:ExIconListData = this.exIconListDic[param1];
         _loc3_.addIcon(param2);
      }
      
      override protected function placeIcons() : void
      {
         var _loc2_:Sprite = null;
         var _loc6_:ISysIcon = null;
         var _loc9_:* = undefined;
         var _loc10_:AngelSysEvent = null;
         _icons.sortOn("seat",Array.NUMERIC);
         _showIcons = _icons.filter(isIconEnable);
         var _loc1_:int = int(_icons.length);
         var _loc3_:int = 60;
         var _loc4_:int = 10;
         var _loc5_:int = 5;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc1_)
         {
            _loc2_ = _icons[_loc8_] as Sprite;
            _loc6_ = _icons[_loc8_] as ISysIcon;
            if(_loc2_ != null)
            {
               if(_loc6_.enable)
               {
                  _loc2_.x = 960 - (_loc7_ + 1) * _loc3_ - _loc4_;
                  _loc2_.y = _loc5_;
                  if(_icons[_loc8_].tooltipPos == null)
                  {
                     _icons[_loc8_].tooltipPos = this.tooltipPos;
                  }
                  _loc7_++;
                  addIconToStage(_loc6_);
               }
               else
               {
                  removeIconFromStage(_loc6_);
               }
            }
            _loc8_++;
         }
         for(_loc9_ in this.exIconListDic)
         {
            if(this.exIconListDic[_loc9_])
            {
               this.exIconListDic[_loc9_].update();
            }
         }
         _loc10_ = new AngelSysEvent("TopRightIconRefresh");
         __global.SysAPI.getGEventAPI().angelEventDispatcher.dispatchEvent(_loc10_);
      }
   }
}

import flash.display.Sprite;
import flash.events.MouseEvent;

class ExIconListData
{
   
   public var firstIcon:Sprite;
   
   public var icons:Array = [];
   
   public var bg:IconListBg = new IconListBg();
   
   public function ExIconListData(param1:ISysIcon, param2:Sprite)
   {
      super();
      this.firstIcon = param1 as Sprite;
      param2.addChildAt(this.bg,0);
      this.icons.push(param1);
      this.firstIcon.addEventListener(MouseEvent.ROLL_OVER,this.onMouse);
      this.firstIcon.addEventListener(MouseEvent.ROLL_OUT,this.onMouse);
      this.bg.addEventListener(MouseEvent.ROLL_OVER,this.onMouse);
      this.bg.addEventListener(MouseEvent.ROLL_OUT,this.onMouse);
      this.update();
      this.bg.visible = false;
      this.bg.bg.x = 1;
   }
   
   public function addIcon(param1:ISysIcon) : void
   {
      var _loc2_:Sprite = param1 as Sprite;
      _loc2_.x = 0;
      _loc2_.y = this.length * 70;
      this.bg.addChild(_loc2_);
      this.icons.push(param1);
      this.update();
   }
   
   public function update() : void
   {
      this.bg.x = this.firstIcon.x;
      this.bg.y = this.firstIcon.y;
      this.bg.bg.height = this.length * 70;
   }
   
   private function onMouse(param1:MouseEvent) : void
   {
      if(param1.type == MouseEvent.ROLL_OVER)
      {
         this.bg.visible = true;
      }
      else
      {
         this.bg.visible = false;
      }
   }
   
   public function get length() : int
   {
      return this.icons.length;
   }
}
