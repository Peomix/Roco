package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.net.protocol.ADF;
   import flash.events.Event;
   
   public class UNLingerTcpConnetion extends AngelTcpConnection
   {
       
      
      protected var isConnecting:Boolean = false;
      
      public function UNLingerTcpConnetion(param1:int = 0)
      {
         super(param1);
      }
      
      override protected function onConnError(param1:Event) : void
      {
         this.isConnecting = false;
         super.onConnError(param1);
      }
      
      private function sendInitialData() : void
      {
         socket.writeMultiByte("tgw_l7_forward\r\nHost: dir.17roco.qq.com:443\r\n\r\n","utf-8");
         socket.flush();
      }
      
      override protected function onConnConnected(param1:Event) : void
      {
         super.onConnConnected(param1);
         this.sendInitialData();
         this.isConnecting = false;
      }
      
      override public function connect(param1:String, param2:int) : void
      {
         cHost = param1;
         cPort = param2;
         this.reset();
         super.connect(cHost,cPort);
      }
      
      override public function sendData(param1:ADF) : void
      {
         if(isConnected())
         {
            super.sendData(param1);
         }
         else if(!this.isConnecting)
         {
            this.reconnect();
            this.isConnecting = true;
         }
      }
      
      override public function reconnect() : void
      {
         this.isConnecting = true;
         super.reconnect();
      }
      
      public function reset() : void
      {
         close();
         this.isConnecting = false;
      }
   }
}
