package com.QQ.angel.ui.effect
{
   import BitmapFont.font.v9.TextFieldBitmap;
   import BitmapFont.font.v9.TextFormatBitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.effect.Effect2Item")]
   public class Effect2Item extends MovieClip
   {
       
      
      public var msg_mc:MovieClip;
      
      public var msg_txt:TextField;
      
      public var txtf:TextFormat;
      
      private var tfb:TextFieldBitmap;
      
      public function Effect2Item()
      {
         var _loc1_:GlowFilter = null;
         super();
         mouseEnabled = false;
         mouseChildren = false;
         x = 480;
         y = 120;
         _loc1_ = new GlowFilter(16711680,1,5,5,4,BitmapFilterQuality.HIGH,false,false);
         this.tfb = new TextFieldBitmap();
         this.tfb.width = 315;
         this.tfb.height = 24;
         this.tfb.x = -this.tfb.width >> 1;
         this.msg_mc.addChild(this.tfb);
         this.tfb.filters = [_loc1_];
         addFrameScript(18,this.onNextEvent);
         addFrameScript(totalFrames - 1,this.onEndMVEvent);
      }
      
      public function hasNextEvent() : Boolean
      {
         return currentFrame <= 19;
      }
      
      protected function onNextEvent() : void
      {
         dispatchEvent(new Event("onNext"));
      }
      
      protected function onEndMVEvent() : void
      {
         dispatchEvent(new Event("onMVEnd"));
         stop();
      }
      
      public function playData(param1:String, param2:uint, param3:uint = 16777215) : void
      {
         var _loc5_:GlowFilter;
         var _loc4_:Array;
         (_loc5_ = (_loc4_ = this.tfb.filters)[0]).color = param2 == 16777215 ? 16711680 : param2;
         this.tfb.filters = _loc4_;
         var _loc6_:TextFormatBitmap;
         (_loc6_ = new TextFormatBitmap()).font = "DFPHaiBaoW12.MDF";
         _loc6_.size = 20;
         _loc6_.align = TextFormatAlign.CENTER;
         _loc6_.color = param3;
         _loc6_.letterSpacing = 3;
         this.tfb.defaultTextFormat = _loc6_;
         this.tfb.text = param1;
         gotoAndPlay(1);
      }
   }
}
