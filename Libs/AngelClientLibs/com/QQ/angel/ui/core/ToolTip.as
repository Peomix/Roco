package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.ui.IBubble;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   
   public class ToolTip
   {
      
      public static const DELAY_TIME:int = 200;
      
      private static var __instance:ToolTip;
       
      
      private var __stage:Stage;
      
      private var __container:DisplayObjectContainer;
      
      private var __bubble:IBubble;
      
      private var __tBubbles:Array;
      
      private var __showTimer:Timer;
      
      private var __currTarget:Object;
      
      private var __currMsg:String;
      
      public function ToolTip(param1:Stage, param2:DisplayObjectContainer)
      {
         super();
         if(__instance != null)
         {
            throw new Error("单态不能实例化!");
         }
         __instance = this;
         this.__stage = param1;
         this.__container = param2;
         this.__showTimer = new Timer(DELAY_TIME);
         this.__showTimer.addEventListener(TimerEvent.TIMER,this.onShowTime);
         this.__tBubbles = [];
         this.setEnabled(true);
      }
      
      public static function getInstance(param1:Stage = null, param2:DisplayObjectContainer = null) : ToolTip
      {
         if(__instance == null)
         {
            new ToolTip(param1,param2);
         }
         return __instance;
      }
      
      protected function onShowTime(param1:TimerEvent) : void
      {
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         this.__showTimer.stop();
         var _loc2_:Object = this.__currTarget;
         this.__currTarget = null;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:String = this.__currMsg;
         this.__currMsg = null;
         if(_loc2_.hasOwnProperty("tooltipType"))
         {
            this.__bubble = this.__tBubbles[_loc2_["tooltipType"]];
         }
         if(this.__bubble == null)
         {
            this.__bubble = this.__tBubbles[2];
         }
         if(_loc3_.indexOf("||") != -1)
         {
            _loc3_ = (_loc6_ = _loc3_.split("||"))[int(_loc6_.length * Math.random())];
         }
         this.__bubble.visible = true;
         this.__bubble.setContent(_loc3_);
         this.__container.addChild(this.__bubble.display);
         var _loc4_:Point = null;
         var _loc5_:Boolean = true;
         if(_loc2_.hasOwnProperty("tooltipPos") && _loc2_["tooltipPos"] != null)
         {
            _loc4_ = _loc2_["tooltipPos"] as Point;
            _loc5_ = false;
         }
         else
         {
            _loc4_ = new Point(_loc2_.width >> 1,0);
         }
         _loc4_ = (_loc2_ as DisplayObject).localToGlobal(_loc4_);
         this.__bubble.x = _loc4_.x;
         this.__bubble.y = _loc4_.y;
         if(_loc5_)
         {
            if((_loc7_ = this.__bubble.x + this.__bubble.width - 960) > 0)
            {
               this.__bubble.x -= _loc7_;
            }
            if(this.__bubble.y < 0)
            {
               this.__bubble.y = this.__bubble.height;
            }
         }
      }
      
      protected function onMouseOver(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         if(param1.target == this.__stage)
         {
            return;
         }
         var _loc2_:Object = param1.target;
         if(_loc2_.hasOwnProperty("tooltip"))
         {
            _loc3_ = _loc2_["tooltip"];
            if(_loc3_ == null || _loc3_ == "")
            {
               return;
            }
            this.__currTarget = _loc2_;
            this.__currMsg = _loc3_;
            this.__showTimer.start();
         }
      }
      
      protected function onMouseOut(param1:MouseEvent) : void
      {
         this.hiddenTips();
         this.__showTimer.reset();
         this.__currTarget = null;
         this.__currMsg = null;
      }
      
      public function setEnabled(param1:Boolean = false) : void
      {
         if(param1)
         {
            this.__stage.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            this.__stage.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
         else
         {
            this.__stage.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
            this.__stage.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOut);
         }
      }
      
      public function addBubble(param1:IBubble, param2:int) : void
      {
         this.__tBubbles[param2] = param1;
         param1.x = 970;
         param1.visible = false;
      }
      
      public function showTips(param1:String, param2:Point = null) : void
      {
         this.__bubble.visible = true;
         this.__bubble.setContent(param1);
         if(param2 != null)
         {
            this.__bubble.x = param2.x;
            this.__bubble.y = param2.y;
         }
      }
      
      public function hiddenTips() : void
      {
         if(this.__bubble == null)
         {
            return;
         }
         if(this.__bubble.visible)
         {
            this.__bubble.setContent(null);
            this.__bubble.visible = false;
            this.__container.removeChild(this.__bubble.display);
            this.__bubble.x = 970;
         }
         this.__bubble = null;
      }
   }
}
