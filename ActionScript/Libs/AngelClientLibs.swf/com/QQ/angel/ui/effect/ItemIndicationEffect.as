package com.QQ.angel.ui.effect
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.text.TextField;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol164")]
   public class ItemIndicationEffect extends MovieClip implements IEffectController
   {
      
      public var labelText:TextField;
      
      protected var container:DisplayObjectContainer;
      
      protected var endHandler:CFunction;
      
      private var _timer:Timer;
      
      public function ItemIndicationEffect(param1:DisplayObjectContainer)
      {
         super();
         this.container = param1;
         this.mouseChildren = false;
         this.mouseEnabled = false;
         this._timer = new Timer(5000);
         this._timer.addEventListener(TimerEvent.TIMER,this.onStopHandler);
      }
      
      protected function onStopHandler(param1:TimerEvent) : void
      {
         this._timer.stop();
         if(this.container.contains(this))
         {
            this.container.removeChild(this);
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
         if(param1 is Array)
         {
            this.labelText.text = param1[0] as String;
            this.x = int(param1[1]);
            this.y = int(param1[2]);
         }
         this.container.addChild(this);
         this._timer.start();
      }
   }
}

