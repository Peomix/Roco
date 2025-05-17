package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.ServerInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   
   public class ReflashKeyLoader extends AngelURLLoader
   {
      
      protected var timer:Timer;
      
      protected var tryTime:int = 0;
      
      public function ReflashKeyLoader(param1:ServerInfo)
      {
         super(param1);
      }
      
      protected function onReflashKey(param1:TimerEvent) : void
      {
         this.tryTime = 0;
         this.reLoadKey();
      }
      
      protected function reLoadKey() : Boolean
      {
         ++this.tryTime;
         if(this.tryTime > 3)
         {
            return false;
         }
         load(new URLRequest(DEFINE.FASTCGI_ROOT + "sign2"));
         return true;
      }
      
      override protected function onLoadComplete(param1:Event) : void
      {
         super.onLoadComplete(param1);
         var _loc2_:XML = new XML(data);
         if(_loc2_.result != null && _loc2_.result == 0)
         {
            serverInfo.sessionKey = _loc2_.angel_key;
            trace("[ReflashKeyLoader] 签名更新成功: " + serverInfo.sessionKey);
         }
         else
         {
            trace("[ReflashKeyLoader] 签名更新失败(错误原因:" + _loc2_.result + ")");
            this.onLoadError(null);
         }
      }
      
      override protected function onLoadError(param1:IOErrorEvent) : void
      {
         trace("[ReflashKeyLoader] 签名更新失败! 原因:" + (param1 != null ? param1.text : ""));
         if(this.reLoadKey())
         {
            trace("[ReflashKeyLoader] 签名更新重试!");
         }
      }
      
      public function start() : void
      {
         this.timer = new Timer(20 * 60 * 1000);
         this.timer.addEventListener(TimerEvent.TIMER,this.onReflashKey);
         this.timer.start();
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.timer.removeEventListener(TimerEvent.TIMER,this.onReflashKey);
      }
   }
}

