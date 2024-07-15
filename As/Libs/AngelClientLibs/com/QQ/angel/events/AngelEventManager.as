package com.QQ.angel.events
{
   import com.QQ.angel.api.IAngelCMDExec;
   import com.QQ.angel.api.IGlobalEventAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.events.IRenderListener;
   import com.QQ.angel.api.events.ITickListener;
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.data.entity.CmdExeDes;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class AngelEventManager implements IGlobalEventAPI, IAngelCMDExec
   {
      
      public static const TICK_DELAY:int = 30;
       
      
      private var _globalDispatcher:EventDispatcher;
      
      private var _commands:Dictionary;
      
      private var _cmdListeners:Dictionary;
      
      private var _timer:Timer;
      
      private var _renderTimer:Timer;
      
      private var _sprite:Sprite;
      
      private var _lastTime:int;
      
      public function AngelEventManager()
      {
         super();
         this._globalDispatcher = new EventDispatcher();
         this._commands = new Dictionary();
         this._cmdListeners = new Dictionary();
         this._timer = new Timer(TICK_DELAY);
         this._timer.start();
         this._sprite = new Sprite();
         this._renderTimer = new Timer(70);
         this._renderTimer.start();
         this._lastTime = getTimer();
      }
      
      protected function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = getTimer();
         var _loc3_:int = _loc2_ - this._lastTime;
         this._lastTime = _loc2_;
      }
      
      public function setRenderTimer(param1:Boolean = false) : void
      {
         if(param1)
         {
            this._renderTimer.start();
         }
         else
         {
            this._renderTimer.stop();
         }
      }
      
      public function addTickListener(param1:ITickListener) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._sprite.addEventListener(Event.ENTER_FRAME,param1.onTickEvent);
      }
      
      public function removeTickListener(param1:ITickListener) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._sprite.removeEventListener(Event.ENTER_FRAME,param1.onTickEvent);
      }
      
      public function addRenderListener(param1:IRenderListener) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._renderTimer.addEventListener(TimerEvent.TIMER,param1.onRender);
      }
      
      public function removeRenderListener(param1:IRenderListener) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._renderTimer.removeEventListener(TimerEvent.TIMER,param1.onRender);
      }
      
      public function get angelEventDispatcher() : IEventDispatcher
      {
         return this._globalDispatcher;
      }
      
      public function addCmdListener(param1:String, param2:Object) : void
      {
         if(param2 == null || !(param2 is ICmdListener) && !(param2 is IPlugProgram))
         {
            throw new Error("注册的CMDLISTENER不是ICmdListener或者IPlugProgram!!");
         }
         if(this._cmdListeners[param1] != null)
         {
            throw new Error("注册两个ICmdListener都注册了" + param1 + "的侦听!");
         }
         this._cmdListeners[param1] = param2;
      }
      
      public function removeCmdListener(param1:String) : void
      {
         delete this._cmdListeners[param1];
      }
      
      public function cmdExecuted(param1:String, param2:Object) : void
      {
         var _loc3_:Object = this._cmdListeners[param1];
         if(_loc3_ != null)
         {
            _loc3_.call(param2);
            return;
         }
         var _loc4_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.CMDLIS_NOT_FOUND);
         var _loc5_:CmdExeDes;
         (_loc5_ = new CmdExeDes()).cmdType = param1;
         _loc5_.arg = param2;
         _loc4_.data = _loc5_;
         this.angelEventDispatcher.dispatchEvent(_loc4_);
      }
   }
}
