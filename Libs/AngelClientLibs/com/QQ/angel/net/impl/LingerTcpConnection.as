package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   
   public class LingerTcpConnection extends AngelTcpConnection
   {
       
      
      protected var timer:Timer;
      
      protected var lastTime:int = 0;
      
      public function LingerTcpConnection(param1:int = 0)
      {
         super(param1);
         this.timer = new Timer(1000 * 180);
         this.timer.addEventListener(TimerEvent.TIMER,this.onHelloTime);
      }
      
      public static function log(param1:*) : void
      {
      }
      
      protected function onHelloTime(param1:TimerEvent) : void
      {
         if(getTimer() > this.lastTime + 120000)
         {
            this.sendData(ProtocolHelper.CreateADF(ADFCmdsType.T_HELLO));
         }
      }
      
      private function sendInitialData() : void
      {
         socket.writeMultiByte("tgw_l7_forward\r\nHost: " + cHost + ":" + cPort + "\r\n\r\n","utf-8");
         socket.flush();
      }
      
      override protected function onConnConnected(param1:Event) : void
      {
         super.onConnConnected(param1);
         log("onConnConnected:" + "tgw_l7_forward\r\nHost: " + cHost + ":" + cPort + "\r\n\r\n");
         this.sendInitialData();
         this.timer.start();
      }
      
      override protected function onConnClosed(param1:Event) : void
      {
         super.onConnClosed(param1);
         this.timer.stop();
      }
      
      override public function sendData(param1:ADF) : void
      {
         super.sendData(param1);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.timer.removeEventListener(TimerEvent.TIMER,this.onHelloTime);
         this.timer = null;
      }
   }
}
