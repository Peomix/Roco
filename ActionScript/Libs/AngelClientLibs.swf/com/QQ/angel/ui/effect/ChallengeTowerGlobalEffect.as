package com.QQ.angel.ui.effect
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.ui.core.textfield.ImageTextField;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TextEvent;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol180")]
   public class ChallengeTowerGlobalEffect extends MovieClip implements IEffectController
   {
      
      public static const LAST_MILISECONDS:int = 4000;
      
      public var messageText:TextField;
      
      public var proxyMessageText:ImageTextField;
      
      public var icon:MovieClip;
      
      public var bg:MovieClip;
      
      public var container:DisplayObjectContainer;
      
      protected var endHandler:CFunction;
      
      private var _timer:Timer;
      
      public function ChallengeTowerGlobalEffect(param1:DisplayObjectContainer)
      {
         super();
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this.container = param1;
         this.messageText.autoSize = TextFieldAutoSize.LEFT;
         this.messageText.multiline = false;
         this.proxyMessageText = new ImageTextField();
         this.proxyMessageText.copyTextStyle(this.messageText);
         this.addChild(this.proxyMessageText);
         this.proxyMessageText.x = this.messageText.x;
         this.proxyMessageText.y = this.messageText.y;
         this.messageText.htmlText = "";
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
         if(this.proxyMessageText)
         {
            this.proxyMessageText.textFiled.removeEventListener(TextEvent.LINK,this.linkHandler);
            this.proxyMessageText.dispose();
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
            this.proxyMessageText.htmlText = param1 as String;
            if((param1 as String).indexOf("href") != -1)
            {
               this.mouseChildren = true;
               this.mouseEnabled = true;
               this.proxyMessageText.textFiled.addEventListener(TextEvent.LINK,this.linkHandler);
            }
            else
            {
               this.mouseChildren = false;
               this.mouseEnabled = false;
            }
            this.bg.width = this.proxyMessageText.width + 160;
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
            _loc4_ = _loc3_.split("_");
            if(_loc4_.length > 0)
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
         if(_loc2_[0] == "KingChampionship")
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC,["AroundSystems",{"type":"openKingFight"}]);
         }
      }
   }
}

