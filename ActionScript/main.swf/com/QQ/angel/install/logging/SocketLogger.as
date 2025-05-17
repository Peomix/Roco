package com.QQ.angel.install.logging
{
   import com.QQ.angel.install.logging.protobuf.*;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.events.TimerEvent;
   import flash.net.Socket;
   import flash.system.Security;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   
   public class SocketLogger extends EventDispatcher
   {
      
      private static var _instance:SocketLogger;
      
      private static const RECONN_TIME:int = 1;
      
      private static const STAT_LOGIN_CMD:int = 0;
      
      private static const STAT_LOG_CMD:int = 1;
      
      private static const HEART_BEAT_CMD:int = 2;
      
      private static const CLIENT_LOG:int = 3;
      
      private var _isComponentInitialized:Boolean = false;
      
      private var adfsQueue:Array;
      
      private var timer:Timer;
      
      private var logHost:String = "172.25.40.120";
      
      private var angel_uin:uint;
      
      private var angel_key:String;
      
      private var logPort:int = 9000;
      
      private var serialNum:int;
      
      private var socket:Socket;
      
      private var socketClosed:Boolean;
      
      public function SocketLogger(param1:uint, param2:String)
      {
         super();
         angel_uin = param1;
         angel_key = param2;
         adfsQueue = [];
         socketClosed = false;
         initSocket();
         timer = new Timer(8 * 60 * 1000);
         timer.addEventListener(TimerEvent.TIMER,onTimer);
      }
      
      public static function getInstance(param1:uint = 0, param2:String = "") : SocketLogger
      {
         if(_instance == null)
         {
            _instance = new SocketLogger(param1,param2);
         }
         return _instance;
      }
      
      private function onConn(param1:Event) : void
      {
         var _loc2_:int = 0;
         switch(param1.type)
         {
            case Event.CONNECT:
               socketClosed = false;
               sendInitialData();
               break;
            case ProgressEvent.SOCKET_DATA:
               _isComponentInitialized = true;
               _loc2_ = 0;
               while(_loc2_ < adfsQueue.length)
               {
                  sendData(adfsQueue[_loc2_] as ADF);
                  _loc2_++;
               }
               adfsQueue = [];
               timer.start();
               break;
            case Event.CLOSE:
            case IOErrorEvent.IO_ERROR:
            case SecurityErrorEvent.SECURITY_ERROR:
               socketClosed = true;
               timer.stop();
         }
      }
      
      public function log(param1:uint, param2:uint) : void
      {
         if(socketClosed)
         {
            return;
         }
         var _loc3_:ADF = encode(STAT_LOG_CMD,writeLog(param1,param2));
         if(socket.connected)
         {
            sendData(_loc3_);
         }
         else
         {
            adfsQueue.push(_loc3_);
         }
      }
      
      protected function sendData(param1:ADF) : void
      {
         var _loc2_:ByteArray = null;
         if(socket.connected && _isComponentInitialized)
         {
            _loc2_ = new ByteArray();
            param1.writeExternal(_loc2_);
            socket.writeBytes(_loc2_);
            socket.flush();
         }
      }
      
      protected function loginServer() : void
      {
         var _loc1_:ADF = encode(STAT_LOGIN_CMD,wirteLogin(angel_key));
         if(socket.connected)
         {
            sendData(_loc1_);
         }
         else
         {
            adfsQueue.push(_loc1_);
         }
      }
      
      protected function encode(param1:uint, param2:ByteArray, param3:Boolean = true) : ADF
      {
         var _loc4_:ADF = ADF.CreateADF(param1,angel_uin);
         if(param3)
         {
            _loc4_.head.uiSerialNum = serialNum;
            ++serialNum;
         }
         _loc4_.body = param2;
         return _loc4_;
      }
      
      protected function wirteLogin(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:WritingBuffer = new WritingBuffer();
         if(param1)
         {
            WriteUtils.writeTag(_loc3_,WritingBuffer.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_STRING(_loc3_,param1);
            _loc3_.toNormal(_loc2_);
            return _loc2_;
         }
         return null;
      }
      
      protected function writeClientLog(param1:String) : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:WritingBuffer = new WritingBuffer();
         WriteUtils.writeTag(_loc3_,WritingBuffer.LENGTH_DELIMITED,1);
         WriteUtils.write$TYPE_STRING(_loc3_,param1);
         _loc3_.toNormal(_loc2_);
         return _loc2_;
      }
      
      protected function removeListeners() : void
      {
         socket.removeEventListener(Event.CONNECT,onConn);
         socket.removeEventListener(Event.CLOSE,onConn);
         socket.removeEventListener(ProgressEvent.SOCKET_DATA,onConn);
         socket.removeEventListener(IOErrorEvent.IO_ERROR,onConn);
         socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onConn);
      }
      
      protected function initSocket() : void
      {
         var _loc1_:String = null;
         socket = new Socket();
         socket.addEventListener(Event.CONNECT,onConn);
         socket.addEventListener(Event.CLOSE,onConn);
         socket.addEventListener(ProgressEvent.SOCKET_DATA,onConn);
         socket.addEventListener(IOErrorEvent.IO_ERROR,onConn);
         socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onConn);
         if(logPort != 843)
         {
            _loc1_ = "xmlsocket://" + logHost + ":" + logPort;
            Security.loadPolicyFile(_loc1_);
         }
         socket.connect(logHost,logPort);
         loginServer();
      }
      
      protected function heartBeat() : void
      {
         var _loc1_:ADF = encode(HEART_BEAT_CMD,null,false);
         if(socket.connected)
         {
            sendData(_loc1_);
         }
      }
      
      protected function writeLog(param1:int = -1, param2:int = -1) : ByteArray
      {
         var _loc3_:ByteArray = new ByteArray();
         var _loc4_:WritingBuffer = new WritingBuffer();
         if(param1 >= 0 && param2 >= 0)
         {
            WriteUtils.writeTag(_loc4_,WritingBuffer.VARINT,1);
            WriteUtils.write$TYPE_UINT32(_loc4_,param2);
            WriteUtils.writeTag(_loc4_,WritingBuffer.VARINT,2);
            WriteUtils.write$TYPE_UINT32(_loc4_,param1);
            _loc4_.toNormal(_loc3_);
            return _loc3_;
         }
         return null;
      }
      
      private function sendInitialData() : void
      {
         socket.writeMultiByte("tgw_l7_forward\r\nHost:stat.17roco.qq.com:9000\r\n\r\n","utf-8");
         socket.flush();
      }
      
      public function dispose() : void
      {
         timer.stop();
         timer.removeEventListener(TimerEvent.TIMER,onTimer);
         timer = null;
         if(socket.connected)
         {
            socket.close();
         }
         removeListeners();
         socket = null;
      }
      
      public function logClient(param1:String) : void
      {
         if(socketClosed)
         {
            return;
         }
         var _loc2_:ADF = encode(CLIENT_LOG,writeClientLog(param1));
         if(socket.connected)
         {
            sendData(_loc2_);
         }
         else
         {
            adfsQueue.push(_loc2_);
         }
      }
      
      protected function onTimer(param1:TimerEvent) : void
      {
         heartBeat();
      }
   }
}

