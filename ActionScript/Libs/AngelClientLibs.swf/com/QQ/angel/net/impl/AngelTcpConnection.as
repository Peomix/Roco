package com.QQ.angel.net.impl
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.net.protocol.ADFHead;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.net.ITCPProxy;
   import com.QQ.angel.net.center.FreePBRequestProxy;
   import com.QQ.angel.net.events.TCPConnEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   
   public class AngelTcpConnection extends EventDispatcher implements ITCPProxy
   {
      
      protected var policyPort:int = 843;
      
      protected var cHost:String = "";
      
      protected var cPort:int = 0;
      
      protected var socket:Socket;
      
      protected var inByteBuff:ByteBuffer;
      
      protected var outByteBuff:ByteBuffer;
      
      protected var emptyADF:ADF;
      
      protected var onADFEvent:TCPConnEvent;
      
      private var __id:int;
      
      public function AngelTcpConnection(param1:int = 0)
      {
         super();
         this.__id = param1;
         this.inByteBuff = new ByteBuffer();
         this.inByteBuff.allocate(0);
         this.outByteBuff = new ByteBuffer();
         this.outByteBuff.allocate(0);
         this.onADFEvent = new TCPConnEvent(TCPConnEvent.TCPCONN_ONADF,this.__id);
         this.socket = new Socket();
         this.socket.addEventListener(Event.CONNECT,this.onConnConnected);
         this.socket.addEventListener(Event.CLOSE,this.onConnClosed);
         this.socket.addEventListener(ProgressEvent.SOCKET_DATA,this.readSocketData);
         this.socket.addEventListener(IOErrorEvent.IO_ERROR,this.onConnError);
         this.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnError);
         this.setPolicyPort(DEFINE.POLICYPORT);
      }
      
      protected function onConnError(param1:Event) : void
      {
         var _loc2_:String = "[AngelTcpConnection] [error]";
         switch(param1.type)
         {
            case IOErrorEvent.IO_ERROR:
               _loc2_ += (param1 as IOErrorEvent).text;
               break;
            case SecurityErrorEvent.SECURITY_ERROR:
               _loc2_ += (param1 as SecurityErrorEvent).text;
         }
         var _loc3_:TCPConnEvent = new TCPConnEvent(TCPConnEvent.TCPCONN_ERROR,this.__id);
         _loc3_.message = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      protected function onConnConnected(param1:Event) : void
      {
         var _loc2_:TCPConnEvent = new TCPConnEvent(TCPConnEvent.TCPCONN_CONNECTED,this.__id);
         dispatchEvent(_loc2_);
      }
      
      protected function onConnClosed(param1:Event) : void
      {
         var _loc2_:TCPConnEvent = new TCPConnEvent(TCPConnEvent.TCPCONN_CLOSED,this.__id);
         dispatchEvent(_loc2_);
      }
      
      protected function tryReadADFHead() : ADFHead
      {
         var _loc2_:ADFHead = null;
         var _loc1_:int = ADFHead.canRead(this.socket);
         while(_loc1_ != ADFHead.NotEnBytes)
         {
            if(_loc1_ == ADFHead.HeadReady)
            {
               _loc2_ = new ADFHead();
               _loc2_.readExternal(this.socket);
               return _loc2_;
            }
            _loc1_ = ADFHead.canRead(this.socket);
         }
         return null;
      }
      
      protected function tryReadADFBody() : Boolean
      {
         var _loc1_:ByteArray = null;
         if(this.socket.bytesAvailable >= this.inByteBuff.limit)
         {
            this.inByteBuff.fill(this.socket);
            this.emptyADF.body = this.inByteBuff;
            this.onADFEvent.data = this.emptyADF;
            _loc1_ = this.inByteBuff.copyToByteArray();
            if(FreePBRequestProxy.isProtoBufId(this.emptyADF.head.cmdID))
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_RAW_DATA,[_loc1_,this.emptyADF.head]);
            }
            else
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_RAW_DATA,[_loc1_,this.emptyADF.head]);
            }
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_RAW_DATA,[_loc1_,this.emptyADF.head]);
            dispatchEvent(this.onADFEvent);
            return true;
         }
         return false;
      }
      
      protected function readSocketData(param1:ProgressEvent) : void
      {
         var _loc2_:ADFHead = null;
         if(this.emptyADF == null)
         {
            _loc2_ = this.tryReadADFHead();
            if(_loc2_ != null)
            {
               this.emptyADF = new ADF();
               this.emptyADF.head = _loc2_;
               this.inByteBuff.allocate(_loc2_.length);
            }
         }
         if(this.emptyADF != null)
         {
            if(this.tryReadADFBody())
            {
               this.emptyADF = null;
               if(this.socket.bytesAvailable > 0)
               {
                  this.readSocketData(null);
               }
            }
         }
      }
      
      public function getID() : int
      {
         return this.__id;
      }
      
      public function setTimeOut(param1:int) : void
      {
      }
      
      public function setPolicyPort(param1:int) : void
      {
         this.policyPort = param1;
      }
      
      public function connect(param1:String, param2:int) : void
      {
         this.cHost = param1;
         this.cPort = param2;
         this.reconnect();
      }
      
      public function reconnect() : void
      {
         var _loc1_:String = null;
         if(this.policyPort != 843)
         {
            _loc1_ = "xmlsocket://" + this.cHost + ":" + this.policyPort;
            Security.loadPolicyFile(_loc1_);
         }
         this.socket.connect(this.cHost,this.cPort);
      }
      
      public function isConnected() : Boolean
      {
         return this.socket.connected;
      }
      
      public function sendData(param1:ADF) : void
      {
         var _loc2_:ByteArray = null;
         if(this.socket.connected)
         {
            _loc2_ = new ByteArray();
            param1.writeExternal(_loc2_);
            if(FreePBRequestProxy.isProtoBufId(param1.head.cmdID))
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_SEND_A_PROTOBUF_RAW_DATA,[_loc2_,param1],this);
            }
            else
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_SEND_A_SOCKET_RAW_DATA,[_loc2_,param1],this);
            }
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_SEND_A_RAW_DATA,[_loc2_,param1],this);
            this.socket.writeBytes(_loc2_);
            this.socket.flush();
         }
      }
      
      public function close() : void
      {
         if(this.socket != null && this.socket.connected)
         {
            this.socket.close();
         }
      }
      
      public function dispose() : void
      {
         if(this.socket.connected)
         {
            this.socket.close();
         }
         this.socket.removeEventListener(Event.CONNECT,this.onConnConnected);
         this.socket.removeEventListener(Event.CLOSE,this.onConnClosed);
         this.socket.removeEventListener(ProgressEvent.SOCKET_DATA,this.readSocketData);
         this.socket.removeEventListener(IOErrorEvent.IO_ERROR,this.onConnError);
         this.socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onConnError);
         this.socket = null;
      }
   }
}

