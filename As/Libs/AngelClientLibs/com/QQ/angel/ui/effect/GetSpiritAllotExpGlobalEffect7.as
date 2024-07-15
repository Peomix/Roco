package com.QQ.angel.ui.effect
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.ui.effect.GetSpiritAllotExpGlobalEffect7")]
   public class GetSpiritAllotExpGlobalEffect7 extends MovieClip implements IEffectController
   {
      
      public static const LAST_MILISECONDS:int = 7000;
       
      
      public var messageText:TextField;
      
      public var icon:MovieClip;
      
      public var bg:MovieClip;
      
      public var container:DisplayObjectContainer;
      
      protected var endHandler:CFunction;
      
      private var _timer:Timer;
      
      public function GetSpiritAllotExpGlobalEffect7(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         this.messageText.autoSize = TextFieldAutoSize.LEFT;
         this.messageText.multiline = false;
         y = 50;
         this._timer = new Timer(LAST_MILISECONDS);
      }
      
      public function setDuration(param1:int) : void
      {
         if(this._timer)
         {
            this._timer.delay = param1;
         }
      }
      
      protected function onStopHandler(param1:TimerEvent) : void
      {
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER,this.onStopHandler);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         if(this.messageText)
         {
            this.messageText.removeEventListener(TextEvent.LINK,this.linkHandler);
         }
         var _loc2_:CFunction = this.endHandler;
         this.endHandler = null;
         if(_loc2_ != null)
         {
            _loc2_.invoke();
         }
      }
      
      public function start(param1:Object, param2:CFunction = null) : void
      {
         this.endHandler = param2;
         this.container.addChild(this);
         if(param1 is String)
         {
            this.messageText.htmlText = param1 as String;
            this.messageText.addEventListener(TextEvent.LINK,this.linkHandler);
            this.bg.width = this.messageText.textWidth + 160;
            x = 960 - this.width >> 1;
         }
         this._timer.addEventListener(TimerEvent.TIMER,this.onStopHandler);
         this._timer.start();
      }
      
      private function linkHandler(param1:TextEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = param1.text.split(",");
         if(_loc2_[0] == "changeScene")
         {
            _loc3_ = _loc2_[1] as String;
            if((_loc4_ = _loc3_.split("_")).length > 0)
            {
               _loc3_ = _loc4_[Math.floor(Math.random() * _loc4_.length)];
            }
            if(__global.MainRoleData.isInBombat)
            {
               __global.UI.alert("","在战斗结束前不要离开这里哦!");
            }
            else
            {
               __global.changeScene(null,parseInt(_loc3_),0);
            }
         }
      }
   }
}
