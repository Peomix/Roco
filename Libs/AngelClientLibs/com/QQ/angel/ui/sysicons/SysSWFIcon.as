package com.QQ.angel.ui.sysicons
{
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.ui.core.Animation;
   import com.QQ.angel.utils.AdjustColor;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class SysSWFIcon extends Animation implements ISysIcon
   {
      
      public static const WIDTH:int = 54;
      
      public static const HEIGHT:int = 54;
      
      public static const MOUSE_OVER_WIDTH:int = 58;
      
      public static const MOUSE_OVER_HEIGHT:int = 58;
      
      public static const SACLE_WIDTH:Number = 1.04;
      
      public static const SACLE_HEIGHT:Number = 1.04;
       
      
      private var _data:SysIconData;
      
      private var _onClick:Function;
      
      private var _tooltipPos:Point;
      
      private var _filter:ColorMatrixFilter;
      
      private var _enable:Boolean = true;
      
      private var _seat:int = 10;
      
      public function SysSWFIcon()
      {
         super(WIDTH,HEIGHT);
         this.buttonMode = true;
         this.useHandCursor = true;
         this.mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onIconOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onIconOut);
         addEventListener(MouseEvent.CLICK,this.onIconClick);
         this.initFilter();
      }
      
      public function dispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onIconOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onIconOut);
         removeEventListener(MouseEvent.CLICK,this.onIconClick);
         this.data = null;
         this.onClick = null;
         this.filters = [];
      }
      
      override protected function onImageLoaded(param1:LoadTaskEvent) : void
      {
         isLoading = false;
         var _loc2_:ResData = param1.resData;
         if(_loc2_ != null)
         {
            content = _loc2_.content as DisplayObject;
            if(com.QQ.angel.ui.§core:Animation§.content)
            {
               addChild(com.QQ.angel.ui.§core:Animation§.content);
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function set data(param1:SysIconData) : void
      {
         this._data = param1;
         if(this._data != null)
         {
            setPath(this._data.url);
         }
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         this._enable = param1;
      }
      
      public function get seat() : int
      {
         return this._seat;
      }
      
      public function set seat(param1:int) : void
      {
         this._seat = param1;
      }
      
      public function set onClick(param1:Function) : void
      {
         this._onClick = param1;
      }
      
      public function get tooltip() : String
      {
         return this._data != null ? this._data.tooltip : null;
      }
      
      public function get tooltipPos() : Point
      {
         return this._tooltipPos;
      }
      
      public function set tooltipPos(param1:Point) : void
      {
         this._tooltipPos = param1;
      }
      
      private function initFilter() : void
      {
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = 20;
         _loc1_.contrast = 10;
         _loc1_.hue = 0;
         _loc1_.saturation = 0;
         this._filter = new ColorMatrixFilter();
         this._filter.matrix = _loc1_.CalculateFinalFlatArray();
      }
      
      private function onIconOver(param1:MouseEvent = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.filters = [this._filter];
         this.x -= 2;
         this.y -= 2;
         this.width *= SACLE_WIDTH;
         this.height *= SACLE_HEIGHT;
      }
      
      private function onIconOut(param1:MouseEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         this.filters = [];
         this.x += 2;
         this.y += 2;
         this.width /= SACLE_WIDTH;
         this.height /= SACLE_HEIGHT;
      }
      
      private function onIconClick(param1:MouseEvent) : void
      {
         if(this._onClick != null)
         {
            this._onClick(this);
         }
      }
   }
}
