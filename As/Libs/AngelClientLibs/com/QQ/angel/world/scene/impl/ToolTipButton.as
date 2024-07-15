package com.QQ.angel.world.scene.impl
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ToolTipButton
   {
      
      public static const L_UP:String = "up";
      
      public static const L_OVER:String = "over";
      
      public static const L_DOWN:String = "down";
       
      
      protected var target:MovieClip;
      
      public function ToolTipButton(param1:MovieClip)
      {
         super();
         this.target = param1;
         this.target.mouseChildren = false;
         this.target["tooltip"] = null;
         this.target["tooltipType"] = null;
         this.stateTo(L_UP);
         this.target.buttonMode = true;
         this.target.useHandCursor = true;
         this.target.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
         this.target.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         this.target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
         this.target.addEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
      }
      
      public function getTarget() : MovieClip
      {
         return this.target;
      }
      
      public function dispose() : void
      {
         this.target.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
         this.target.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         this.target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseEvent);
         this.target.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseEvent);
      }
      
      public function setTooltipPos(param1:Point) : void
      {
         this.target["tooltipPos"] = param1;
      }
      
      protected function stateTo(param1:String) : void
      {
         if(this.target.currentLabels.length > 1)
         {
            this.target.gotoAndStop(param1);
         }
      }
      
      protected function onMouseEvent(param1:MouseEvent) : void
      {
         switch(param1.type)
         {
            case MouseEvent.MOUSE_OVER:
               this.stateTo(L_OVER);
               break;
            case MouseEvent.MOUSE_OUT:
               this.stateTo(L_UP);
               break;
            case MouseEvent.MOUSE_DOWN:
               this.stateTo(L_DOWN);
               break;
            case MouseEvent.MOUSE_UP:
               this.stateTo(L_OVER);
         }
      }
   }
}
