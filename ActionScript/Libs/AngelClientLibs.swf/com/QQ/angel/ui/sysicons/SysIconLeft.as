package com.QQ.angel.ui.sysicons
{
   import com.QQ.angel.ui.core.TooltipButton;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class SysIconLeft extends SysIcon
   {
      
      private var _btnMc:TooltipButton;
      
      public function SysIconLeft()
      {
         super();
         this._btnMc = new TooltipButton(new SysIconLeftUI());
         DisplayObjectContainer(this._btnMc.getTarget().getChildAt(0)).addChild(_AImage);
         this._btnMc.getTarget().visible = false;
         _AImage.addEventListener(Event.COMPLETE,function(param1:Event):void
         {
            param1.currentTarget.removeEventListener(param1.type,arguments.callee);
            _btnMc.getTarget().visible = true;
         });
         addChild(this._btnMc.getTarget());
      }
      
      override public function set tooltipPos(param1:Point) : void
      {
         super.tooltipPos = param1;
         this._btnMc.getTarget().tooltipPos = param1;
      }
      
      override public function set tooltip(param1:String) : void
      {
         mouseChildren = true;
         this._btnMc.getTarget().tooltip = param1;
      }
      
      override protected function onIconOver(param1:MouseEvent = null) : void
      {
      }
      
      override protected function onIconOut(param1:MouseEvent) : void
      {
      }
   }
}

