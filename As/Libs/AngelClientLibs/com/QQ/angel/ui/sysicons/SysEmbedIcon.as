package com.QQ.angel.ui.sysicons
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SysEmbedIcon extends Sprite implements ISysIcon
   {
       
      
      private var _onClick:Function;
      
      private var _data:SysIconData;
      
      private var _display:DisplayObject;
      
      private var _tooltipPos:Point;
      
      private var _tooltip:String;
      
      public var _isAlwaysShow:Boolean = false;
      
      public var _layoutTpye:int = 0;
      
      private var _enable:Boolean = true;
      
      private var _seat:int = 10;
      
      public function SysEmbedIcon(param1:DisplayObject, param2:Function = null, param3:String = null, param4:Point = null, param5:Boolean = false)
      {
         super();
         this._isAlwaysShow = param5;
         this._display = param1;
         this._onClick = param2;
         this.addChild(this._display);
         this._data = new SysIconData();
         if(Boolean(this._display) && this._display is MovieClip)
         {
            (this._display as MovieClip).buttonMode = true;
            (this._display as MovieClip).mouseEnabled = true;
            this.tooltip = param3;
            this.tooltipPos = param4;
            if(param3 == null || param3 == "")
            {
               (this._display as MovieClip).mouseChildren = true;
            }
            else
            {
               (this._display as MovieClip).mouseChildren = false;
            }
         }
         this._display.addEventListener(MouseEvent.CLICK,this.onIconClick);
      }
      
      public function dispose() : void
      {
         this._display.removeEventListener(MouseEvent.CLICK,this.onIconClick);
         this.data = null;
         this.onClick = null;
         this._tooltipPos = null;
         this._display = null;
      }
      
      public function set data(param1:SysIconData) : void
      {
         this._data = param1;
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
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         if(this._display is MovieClip)
         {
            (this._display as MovieClip).tooltip = this._tooltip;
         }
      }
      
      public function get tooltipPos() : Point
      {
         return this._tooltipPos;
      }
      
      public function set tooltipPos(param1:Point) : void
      {
         this._tooltipPos = param1;
         if(this._display is MovieClip)
         {
            (this._display as MovieClip).tooltipPos = this._tooltipPos;
         }
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
