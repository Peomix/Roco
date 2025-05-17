package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.events.AngelDataEvent;
   import com.QQ.angel.api.events.AngelNetSysEvent;
   import com.QQ.angel.api.net.HttpRequest;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.IDataReceiver;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.data.entity.ServerInfo;
   import com.QQ.angel.net.IHttpProxy;
   import com.QQ.angel.net.INetSystem;
   import com.QQ.angel.net.ITCPProxy;
   import com.QQ.angel.net.ProtoNet.*;
   import com.QQ.angel.net.events.TCPConnEvent;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.utils.Dictionary;
   
   public class AngelNetSystem extends EventDispatcher implements INetSystem, IGreenSystem, IAngelSysAPIAware
   {
      
      public static const VERSION:String = "1.0";
      
      private static var __SerialNum:uint = 0;
      
      public static var MSG_CLOSE_SCOKET_CHILDWARD:String = "您的账号已被家长设定为暂时无法登录游戏。如有疑问，请拨打服务热线0755-86013799进行咨询。共筑绿色健康游戏环境，感谢您的理解与支持。";
      
      protected var adfProcessors:ADFProcessors;
      
      protected var adfReceivers:ADFReceivers;
      
      protected var tcpProxy:ITCPProxy;
      
      protected var httpProxy:IHttpProxy;
      
      protected var reflashLoader:ReflashKeyLoader;
      
      protected var tcpCls:Class;
      
      protected var tcpID:int = 0;
      
      protected var tcpProxyMap:Dictionary;
      
      protected var angelSysApi:IAngelSysAPI;
      
      protected var gDispatcher:IEventDispatcher;
      
      private var closeSocketMsg:String = "";
      
      public function AngelNetSystem()
      {
         super();
      }
      
      private function onPushChildWard(param1:int, param2:Object) : void
      {
         if(param1 == 206321)
         {
            this.closeSocketMsg = MSG_CLOSE_SCOKET_CHILDWARD;
            NetManager.BeKickedOff = true;
         }
      }
      
      protected function onConnStateChange(param1:TCPConnEvent) : void
      {
         var _loc2_:AngelNetSysEvent = new AngelNetSysEvent(AngelNetSysEvent.ON_STATE_CHANGE);
         switch(param1.type)
         {
            case TCPConnEvent.TCPCONN_CONNECTED:
               _loc2_.currState = AngelNetSysEvent.NS_CONNETED;
               trace("[AngelNetSystem] tcpID:" + param1.getTCPID() + "连接成功!");
               NetManager.addDataProcessor(206321,RemindMsgPush,this.onPushChildWard);
               break;
            case TCPConnEvent.TCPCONN_CLOSED:
               _loc2_.currState = AngelNetSysEvent.NS_CLOSED;
               _loc2_.message = this.closeSocketMsg;
               trace("[AngelNetSystem] tcpID:" + param1.getTCPID() + "连接关闭!");
               break;
            case TCPConnEvent.TCPCONN_ERROR:
               _loc2_.currState = AngelNetSysEvent.NS_ERROR;
               _loc2_.message = param1.message;
               trace("[AngelNetSystem] tcpID:" + param1.getTCPID() + "连接错误," + "             message:" + param1.message);
         }
         _loc2_.data = param1.getTCPID();
         this.gDispatcher.dispatchEvent(_loc2_);
      }
      
      protected function sendADFHandler(param1:AngelDataEvent) : void
      {
         this.trySendData(param1.dataType,param1.data);
      }
      
      protected function onReceiveADFHandler(param1:TCPConnEvent) : void
      {
         var _loc3_:Object = null;
         var _loc2_:ADF = param1.data as ADF;
         if(_loc2_ != null)
         {
            _loc3_ = this.adfProcessors.decode(_loc2_);
            _loc2_.body = _loc3_;
            this.adfReceivers.onDataReceive(_loc2_);
         }
         else
         {
            trace("[NetSystem] AngelNetSystem收到一个空的ADF!!");
         }
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysApi = param1;
      }
      
      public function initialize(... rest) : void
      {
         this.gDispatcher = this.angelSysApi.getGEventAPI().angelEventDispatcher;
         this.adfProcessors = new ADFProcessors();
         this.adfReceivers = new ADFReceivers(this);
         P_FreeRequest.setNetSys(this);
         this.tcpProxyMap = new Dictionary();
         if(rest[0] is ITCPProxy)
         {
            this.tcpCls = rest[0]["constructor"];
            this.tcpProxy = rest[0];
            this.tcpProxyMap[this.tcpProxy.getID()] = this.tcpProxy;
            this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_CONNECTED,this.onConnStateChange);
            this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_TIMEOUT,this.onConnStateChange);
            this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_CLOSED,this.onConnStateChange);
            this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_ERROR,this.onConnStateChange);
            this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_ONADF,this.onReceiveADFHandler);
         }
         else if(rest[0] is Class)
         {
            this.tcpCls = rest[0];
         }
         this.httpProxy = new AngelHttpProxy();
         var _loc2_:ServerInfo = this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         this.reflashLoader = new ReflashKeyLoader(_loc2_);
         this.reflashLoader.start();
      }
      
      public function createTCPProxy(param1:Boolean = true) : ITCPProxy
      {
         ++this.tcpID;
         if(param1)
         {
            this.tcpProxy = new LingerTcpConnection(this.tcpID) as ITCPProxy;
         }
         else
         {
            this.tcpProxy = new UNLingerTcpConnetion(this.tcpID);
         }
         this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_CONNECTED,this.onConnStateChange);
         this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_TIMEOUT,this.onConnStateChange);
         this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_CLOSED,this.onConnStateChange);
         this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_ERROR,this.onConnStateChange);
         this.tcpProxy.addEventListener(TCPConnEvent.TCPCONN_ONADF,this.onReceiveADFHandler);
         this.tcpProxyMap[this.tcpProxy.getID()] = this.tcpProxy;
         return this.tcpProxy;
      }
      
      public function setMainTcpProxy(param1:int) : void
      {
         var _loc2_:ITCPProxy = this.getTCPProxy(param1);
         if(_loc2_ == null)
         {
            return;
         }
         this.tcpProxy = _loc2_;
      }
      
      public function disposeTCPProxy(param1:int) : void
      {
         var _loc2_:ITCPProxy = this.tcpProxyMap[param1] as ITCPProxy;
         if(_loc2_ != null)
         {
            _loc2_.removeEventListener(TCPConnEvent.TCPCONN_CONNECTED,this.onConnStateChange);
            _loc2_.removeEventListener(TCPConnEvent.TCPCONN_TIMEOUT,this.onConnStateChange);
            _loc2_.removeEventListener(TCPConnEvent.TCPCONN_CLOSED,this.onConnStateChange);
            _loc2_.removeEventListener(TCPConnEvent.TCPCONN_ERROR,this.onConnStateChange);
            _loc2_.removeEventListener(TCPConnEvent.TCPCONN_ONADF,this.onReceiveADFHandler);
            _loc2_.dispose();
            trace("[AngelNetSystem] tcpID:" + _loc2_.getID() + "被系统回收！");
         }
         delete this.tcpProxyMap[param1];
      }
      
      public function connect(param1:String, param2:int) : void
      {
         this.tcpProxy.connect(param1,param2);
      }
      
      public function isConnected() : Boolean
      {
         if(this.tcpProxy == null)
         {
            return false;
         }
         return this.tcpProxy.isConnected();
      }
      
      public function finalize() : void
      {
         var _loc1_:Object = null;
         var _loc2_:ITCPProxy = null;
         if(this.adfProcessors != null)
         {
            this.adfReceivers.removeEventListener(AngelDataEvent.TRYSENDADF,this.sendADFHandler);
            this.adfProcessors.dispose();
            this.adfReceivers.dispose();
            this.adfProcessors = null;
            this.adfReceivers = null;
         }
         this.tcpProxy = null;
         for each(_loc1_ in this.tcpProxyMap)
         {
            _loc2_ = _loc1_ as ITCPProxy;
            if(_loc2_ != null)
            {
               this.disposeTCPProxy(_loc2_.getID());
            }
         }
         if(this.httpProxy != null)
         {
            this.httpProxy.dispose();
            this.httpProxy = null;
         }
      }
      
      public function getHttpProxy() : IHttpProxy
      {
         return this.httpProxy;
      }
      
      public function addDataProcessor(param1:IDataProcessor) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.adfProcessors.add(param1);
      }
      
      public function removeDataProcessor(param1:IDataProcessor) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.adfProcessors.remove(param1);
      }
      
      public function getTCPProxy(param1:int = -1) : ITCPProxy
      {
         if(param1 == -1)
         {
            return this.tcpProxy;
         }
         return this.tcpProxyMap[param1] as ITCPProxy;
      }
      
      public function trySendData(param1:int, param2:Object, param3:Boolean = false, param4:int = -1) : uint
      {
         ++__SerialNum;
         var _loc5_:ADF = this.adfProcessors.encode(param2,param1,param3 ? __SerialNum : 0);
         var _loc6_:ITCPProxy = this.getTCPProxy(param4);
         if(_loc6_.isConnected() == false || _loc5_ == null)
         {
            if(!(_loc6_ is UNLingerTcpConnetion))
            {
               return 0;
            }
            _loc6_.sendData(_loc5_);
         }
         else
         {
            _loc6_.sendData(_loc5_);
         }
         return __SerialNum;
      }
      
      public function addDataReceiver(param1:IDataReceiver) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.adfReceivers.add(param1);
      }
      
      public function removeDataReceiver(param1:IDataReceiver) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.adfReceivers.remove(param1);
      }
      
      public function sendHttpRequest(param1:HttpRequest) : String
      {
         if(this.httpProxy == null)
         {
            return "";
         }
         return this.httpProxy.sendHttpRequest(param1);
      }
      
      public function cancelHttpRequest(param1:String) : Boolean
      {
         if(this.httpProxy == null)
         {
            return false;
         }
         return this.httpProxy.cancelHttpRequest(param1);
      }
      
      public function getURLLoader() : URLLoader
      {
         var _loc1_:ServerInfo = this.angelSysApi.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         return new AngelURLLoader(_loc1_);
      }
      
      public function createURLLoader(param1:Boolean = false, param2:int = -1) : URLLoader
      {
         var _loc3_:AngelURLLoader = this.getURLLoader() as AngelURLLoader;
         _loc3_.setNoCache(param1);
         _loc3_.setTimeOut(param2);
         return _loc3_;
      }
   }
}

