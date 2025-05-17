package com.QQ.angel.ui.sysicons
{
   import com.QQ.angel.ui.core.AImage;
   import com.QQ.angel.utils.AdjustColor;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   
   public class SysIcon extends MovieClip implements ISysIcon
   {
      
      public static const WIDTH:int = 64;
      
      public static const HEIGHT:int = 64;
      
      public static const MOUSE_OVER_WIDTH:int = 67;
      
      public static const MOUSE_OVER_HEIGHT:int = 67;
      
      public static const SACLE_WIDTH:Number = 1.07;
      
      public static const SACLE_HEIGHT:Number = 1.07;
      
      private var _data:SysIconData;
      
      private var _onClick:Function;
      
      private var _tooltipPos:Point;
      
      private var _filter:ColorMatrixFilter;
      
      protected var _AImage:AImage;
      
      private var _enable:Boolean = true;
      
      private var _seat:int = 10;
      
      public function SysIcon()
      {
         super();
         this._AImage = new AImage(WIDTH,HEIGHT);
         addChild(this._AImage);
         this.buttonMode = true;
         this.useHandCursor = true;
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
      
      public function set data(param1:SysIconData) : void
      {
         this._data = param1;
         if(this._data != null)
         {
            this._AImage.setPath(this._data.url);
            this.tooltip = this._data.tooltip;
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
      
      public function set tooltip(param1:String) : void
      {
         mouseChildren = false;
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
      
      protected function onIconOver(param1:MouseEvent = null) : void
      {
         this.filters = [this._filter];
         this.x -= MOUSE_OVER_WIDTH - WIDTH >> 1;
         this.y -= MOUSE_OVER_HEIGHT - HEIGHT >> 1;
         this.width = MOUSE_OVER_WIDTH;
         this.height = MOUSE_OVER_HEIGHT;
      }
      
      protected function onIconOut(param1:MouseEvent) : void
      {
         this.filters = [];
         this.x += MOUSE_OVER_WIDTH - WIDTH >> 1;
         this.y += MOUSE_OVER_HEIGHT - HEIGHT >> 1;
         this.width = WIDTH;
         this.height = HEIGHT;
      }
      
      protected function onIconClick(param1:MouseEvent) : void
      {
         if(this._onClick != null)
         {
            this._onClick(this);
         }
      }
   }
}

