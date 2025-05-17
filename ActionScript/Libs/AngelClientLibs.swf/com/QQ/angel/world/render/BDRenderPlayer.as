package com.QQ.angel.world.render
{
   import com.QQ.angel.api.events.IRenderListener;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class BDRenderPlayer extends Bitmap implements IRenderListener
   {
      
      private var __frames:Array;
      
      private var __yOffsets:Array;
      
      private var __totalFrames:int = 0;
      
      private var __pos:int = -1;
      
      private var __lastTimes:int = 0;
      
      private var __countTimes:int = 0;
      
      private var __labelEvent:BDFrameEvent;
      
      private var __endFrameEvent:BDFrameEvent;
      
      public function BDRenderPlayer(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false)
      {
         super(param1,param2,param3);
         this.__labelEvent = new BDFrameEvent(BDFrameEvent.ON_ENTERLABEL);
         this.__endFrameEvent = new BDFrameEvent(BDFrameEvent.ON_ENDFRAME);
      }
      
      public function onRender(param1:Event) : void
      {
         if(this.__frames == null || this.__frames.length == 0)
         {
            return;
         }
         if(this.__lastTimes > this.__countTimes)
         {
            ++this.__countTimes;
            return;
         }
         if(this.__pos >= this.__totalFrames)
         {
            this.__pos = 0;
            dispatchEvent(this.__endFrameEvent);
         }
         var _loc2_:BDFrame = this.__frames[this.__pos];
         bitmapData = _loc2_.img;
         var _loc3_:Point = _loc2_.offset;
         x = _loc3_.x;
         y = _loc3_.y;
         this.__lastTimes = _loc2_.times;
         this.__countTimes = 1;
         if(_loc2_.label != "")
         {
            this.__labelEvent.label = _loc2_.label;
            dispatchEvent(this.__labelEvent);
         }
         ++this.__pos;
      }
      
      public function hasRender() : Boolean
      {
         return true;
      }
      
      public function playFrames(param1:Array) : void
      {
         if(param1 == null || param1.length == 0)
         {
            trace("[BDRenderPlayer] 尝试播放一些空帧!!");
            return;
         }
         this.__totalFrames = param1.length;
         this.__frames = param1;
         this.__pos = -1;
         this.goTo(1);
      }
      
      public function goTo(param1:int = -1) : void
      {
         if(param1 <= 0 || param1 == this.__pos + 1 || param1 > this.__totalFrames)
         {
            return;
         }
         this.__pos = param1 - 1;
         this.__lastTimes = 0;
         this.__countTimes = 0;
         this.onRender(null);
      }
      
      public function setYOffsets(param1:Array) : void
      {
         this.__yOffsets = param1;
      }
      
      public function dispose() : void
      {
         bitmapData = null;
         this.__frames = null;
         this.__pos = 0;
         this.__countTimes = 0;
         this.__lastTimes = 0;
         this.__yOffsets = null;
      }
   }
}

