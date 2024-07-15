package com.QQ.angel.ui.sysicons
{
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.common.__global;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class SysIconGroup extends Sprite implements ISysIconGroup
   {
       
      
      protected var _icons:Array;
      
      public var showIconArray:Array = null;
      
      public var hideIconArray:Array = null;
      
      protected var _showIcons:Array;
      
      public function SysIconGroup()
      {
         this._showIcons = [];
         super();
         this._icons = [];
      }
      
      protected function setStatus(param1:ISysIcon) : void
      {
         if(this.showIconArray == null || this.showIconArray.indexOf(param1.tooltip) != -1)
         {
            param1.enable = true;
         }
         else
         {
            param1.enable = false;
         }
         if(Boolean(this.hideIconArray) && this.hideIconArray.indexOf(param1.tooltip) != -1)
         {
            param1.enable = false;
         }
      }
      
      public function refreshIcons(param1:Array, param2:Array) : void
      {
         var _loc3_:ISysIcon = null;
         this.showIconArray = param1;
         this.hideIconArray = param2;
         for each(_loc3_ in this._icons)
         {
            this.setStatus(_loc3_);
         }
         this.placeIcons();
      }
      
      protected function getSysIconClass() : Class
      {
         return SysIcon;
      }
      
      protected function getSysSWFIconClass() : Class
      {
         return SysSWFIcon;
      }
      
      public function addSysIcon(param1:ISysIcon) : ISysIcon
      {
         this.setStatus(param1);
         this._icons.push(param1);
         this.placeIcons();
         this.addIconToList(param1);
         return param1;
      }
      
      public function getSysIconByToolTip(param1:String) : ISysIcon
      {
         var _loc2_:ISysIcon = null;
         for each(_loc2_ in this._icons)
         {
            if(_loc2_.tooltip == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getSysIconPosByToolTip(param1:String) : Point
      {
         var _loc2_:ISysIcon = null;
         var _loc3_:Sprite = null;
         var _loc4_:Point = null;
         var _loc5_:Point = null;
         for each(_loc2_ in this._icons)
         {
            if(_loc2_.tooltip == param1)
            {
               _loc3_ = _loc2_ as Sprite;
               if(_loc2_.enable == false)
               {
                  _loc5_ = new Point(_loc3_.x,_loc3_.y);
                  _loc2_.enable = true;
                  this.placeIcons();
                  _loc4_ = new Point();
                  _loc4_ = _loc3_.localToGlobal(_loc4_);
                  _loc2_.enable = false;
                  this.placeIcons();
                  _loc3_.x = _loc5_.x;
                  _loc3_.y = _loc5_.y;
               }
               else
               {
                  _loc4_ = new Point();
                  _loc4_ = _loc3_.localToGlobal(_loc4_);
               }
               return _loc4_;
            }
         }
         return null;
      }
      
      public function addIcon(param1:SysIconData) : ISysIcon
      {
         var _loc2_:Class = null;
         var _loc3_:ISysIcon = null;
         if(param1.url.search(".swf") == -1)
         {
            _loc2_ = this.getSysIconClass();
            _loc3_ = new _loc2_() as SysIcon;
         }
         else
         {
            _loc2_ = this.getSysSWFIconClass();
            _loc3_ = new _loc2_() as SysSWFIcon;
         }
         _loc3_.data = param1;
         this._icons.push(_loc3_);
         this.setStatus(_loc3_);
         this.placeIcons();
         this.addIconToList(_loc3_);
         return _loc3_;
      }
      
      public function addSysIconAt(param1:ISysIcon, param2:int) : ISysIcon
      {
         param1.seat = param2;
         this._icons.push(param1);
         this.setStatus(param1);
         this.placeIcons();
         this.addIconToList(param1);
         return param1;
      }
      
      public function addIconAt(param1:SysIconData, param2:int) : ISysIcon
      {
         var _loc3_:Class = null;
         var _loc4_:ISysIcon = null;
         if(param1.url.search(".swf") == -1)
         {
            _loc3_ = this.getSysIconClass();
            _loc4_ = new _loc3_() as SysIcon;
         }
         else
         {
            _loc3_ = this.getSysSWFIconClass();
            _loc4_ = new _loc3_() as SysSWFIcon;
         }
         _loc4_.data = param1;
         _loc4_.seat = param2;
         this.setStatus(_loc4_);
         this._icons.push(_loc4_);
         this.placeIcons();
         this.addIconToList(_loc4_);
         return _loc4_;
      }
      
      protected function addIconToList(param1:ISysIcon) : void
      {
         var _loc2_:AngelSysEvent = null;
         if(Boolean(__global.GEventAPI) && Boolean(__global.GEventAPI.angelEventDispatcher))
         {
            _loc2_ = new AngelSysEvent("AngelTopIconAdd");
            _loc2_.data = param1;
            __global.GEventAPI.angelEventDispatcher.dispatchEvent(_loc2_);
         }
      }
      
      public function removeIcon(param1:ISysIcon) : Boolean
      {
         var _loc2_:int = int(this._icons.length);
         var _loc3_:int = -1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(this._icons[_loc4_] == param1)
            {
               this.removeIconFromStage(param1);
               param1.dispose();
               this._icons.splice(_loc4_,1);
               this.placeIcons();
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function removeIconAt(param1:int) : Boolean
      {
         var _loc2_:ISysIcon = this._icons[param1] as ISysIcon;
         if(_loc2_ != null)
         {
            this.removeIconFromStage(_loc2_);
            _loc2_.dispose();
            this._icons.splice(param1,1);
            this.placeIcons();
            return true;
         }
         return false;
      }
      
      public function addSysIconBetween(param1:ISysIcon, param2:String, param3:String) : ISysIcon
      {
         return this.addSysIcon(param1);
      }
      
      public function addIconBetween(param1:SysIconData, param2:String, param3:String) : ISysIcon
      {
         return this.addIcon(param1);
      }
      
      public function getIconsNum() : uint
      {
         if(this._icons)
         {
            return this._icons.length;
         }
         return 0;
      }
      
      public function getIconAt(param1:int) : ISysIcon
      {
         if(param1 >= this._icons.length)
         {
            return null;
         }
         return this._icons[param1] as ISysIcon;
      }
      
      protected function getIconBySeat(param1:int) : ISysIcon
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._icons.length)
         {
            if((this._icons[_loc2_] as ISysIcon).seat == param1)
            {
               return this._icons[_loc2_] as ISysIcon;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function clearIcons() : void
      {
         var _loc2_:ISysIcon = null;
         var _loc1_:int = int(this._icons.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._icons[_loc3_] as ISysIcon;
            if(_loc2_ != null)
            {
               this.removeIconFromStage(_loc2_);
               _loc2_.dispose();
            }
            _loc3_++;
         }
         this._icons = [];
      }
      
      private function getAddableIndex(param1:int) : int
      {
         if(param1 < 0)
         {
            return 0;
         }
         if(param1 > this._icons.length)
         {
            return this._icons.length;
         }
         return param1;
      }
      
      protected function addIconToStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && !this.contains(_loc2_))
         {
            addChild(_loc2_);
         }
      }
      
      protected function removeIconFromStage(param1:ISysIcon) : void
      {
         var _loc2_:Sprite = param1 as Sprite;
         if(_loc2_ != null && this.contains(_loc2_))
         {
            removeChild(_loc2_);
         }
      }
      
      protected function isIconEnable(param1:*, param2:int, param3:Array) : Boolean
      {
         return param1.enable;
      }
      
      protected function placeIcons() : void
      {
         var _loc2_:Sprite = null;
         var _loc1_:int = int(this._icons.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._icons[_loc3_] as Sprite;
            if(_loc2_ != null)
            {
               _loc2_.x = _loc3_ * 60;
               _loc2_.y = _loc3_ * 60;
            }
            this.addIconToStage(_loc2_ as ISysIcon);
            _loc3_++;
         }
      }
   }
}
