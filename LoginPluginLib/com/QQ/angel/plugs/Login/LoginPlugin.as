package com.QQ.angel.plugs.Login
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.plug.IPlugProgram;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.ServerInfo;
   import com.QQ.angel.logging.AngelLogger;
   import com.QQ.angel.logging.log;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.INetSystem;
   import com.QQ.angel.net.ITCPProxy;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.events.TCPConnEvent;
   import com.QQ.angel.plugs.Login.data.LoginDataRepply;
   import com.QQ.angel.plugs.Login.data.RangeDataList;
   import com.QQ.angel.plugs.Login.data.RecommendDataList;
   import com.QQ.angel.plugs.Login.data.RoomData;
   import com.QQ.angel.plugs.Login.processor.*;
   import com.QQ.angel.plugs.Login.ui2.AngelLoginUI2;
   import com.QQ.angel.plugs.Login.ui2.UIAgeRule;
   import com.QQ.angel.plugs.Login.ui2.UIResRule;
   import com.QQ.angel.plugs.Login.ui2.components.CommSerItem;
   import com.QQ.angel.plugs.Login.ui2.events.LoginUIEvent;
   import com.QQ.angel.plugs.Login.utils.AngelURLLoader;
   import com.QQ.angel.plugs.Login.utils.SvrNameEngine;
   import com.QQ.angel.ui.filters.FilterFactory;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.utils.getTimer;
   import mx.utils.StringUtil;
   
   public class LoginPlugin extends Sprite implements IPlugProgram
   {
       
      
      private var platfromSrcProcessor:PlatfromSrcProcessor;
      
      private var dirBeginTime:int = 0;
      
      private var count:int;
      
      private var loginUI2:AngelLoginUI2;
      
      private var dirReqData:Object;
      
      private var loginProcessor:LoginDataProcessor;
      
      private var system:IAngelSysAPI;
      
      private var recommendProcessor:RecommendDataProcessor;
      
      private var myParam:int;
      
      private var dirConn:ITCPProxy;
      
      private var isDirConnect:Boolean = false;
      
      private var _name:String;
      
      private var svrNameEngine:SvrNameEngine;
      
      private var recommendData:RecommendDataList;
      
      private var rangeData:RangeDataList;
      
      public var login_btn:SimpleButton;
      
      private var serverInfo:ServerInfo;
      
      private var initalProcessor:InitialComponentDataProcessor;
      
      private var roomLoginConn:ITCPProxy;
      
      private var ageRule:UIAgeRule;
      
      private var fastLoginProcessor:FastLoginDataProcessor;
      
      private var rangeReqSpeed:Boolean = false;
      
      private var plugins:Array;
      
      private var uiRule:UIResRule;
      
      private var _sendLoginReqList:Array;
      
      private var _isDirComponentInitialized:Boolean = false;
      
      private var zoneBeginTime:int = 0;
      
      private var m_isAgree:Boolean = true;
      
      private var rangeProcessor:RangeDataProcessor;
      
      private var _sendDirReqList:Array;
      
      private var _isLoginComponentInitialized:Boolean = false;
      
      private var loginRoom:RoomData;
      
      private var globalData:IGlobalDataAPI;
      
      private var receiver:LoginReceiver;
      
      private var cgiLoader:AngelURLLoader;
      
      public function LoginPlugin()
      {
         loginProcessor = new LoginDataProcessor();
         recommendProcessor = new RecommendDataProcessor();
         rangeProcessor = new RangeDataProcessor();
         fastLoginProcessor = new FastLoginDataProcessor();
         platfromSrcProcessor = new PlatfromSrcProcessor();
         initalProcessor = new InitialComponentDataProcessor();
         dirReqData = {
            "hisRoomCount":2,
            "hotRoomCount":0,
            "lessRoomCount":0,
            "otherRoomCount":0,
            "uin":""
         };
         svrNameEngine = new SvrNameEngine();
         _sendDirReqList = [];
         _sendLoginReqList = [];
         super();
      }
      
      private static function onAPlugInstaled(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:LoginPlugin;
         if(Boolean((_loc5_ = LoginPlugin(param4)).plugins) && _loc5_.plugins.indexOf(String(param2[2])) != -1)
         {
            ++_loc5_.count;
            if(_loc5_.count >= _loc5_.plugins.length - 2)
            {
               tti(400);
               trace("统计结束上报统计结果");
               ttiSendLog();
               CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_ON_A_PLUGIN_INSTALLED,onAPlugInstaled,param4);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onSceneRoleDataLoaded(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         tti(301);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ROLE_DATA_LOADED,onSceneRoleDataLoaded,param4);
         return CallbackCenter.EVENT_OK;
      }
      
      public static function tti(param1:int, param2:int = 1) : void
      {
         var obj:* = undefined;
         var step:int = param1;
         var cmd:int = param2;
         if(ExternalInterface.available)
         {
            try
            {
               obj = ExternalInterface.call("tti",cmd,step);
            }
            catch(e:Error)
            {
               trace("调用页面js  function tti失败！" + e.toString());
            }
         }
      }
      
      public static function ttiSendLog() : void
      {
         var obj:* = undefined;
         if(ExternalInterface.available)
         {
            try
            {
               obj = ExternalInterface.call("ttiToString",1);
               if(obj)
               {
                  AngelLogger.getLogger().logClient(2,obj as String);
               }
               if(obj == null)
               {
                  trace("调用页面js function ttiToString失败！");
               }
            }
            catch(e:Error)
            {
               trace("调用页面js  function ttiToString失败！" + e.toString());
            }
         }
      }
      
      private function setUpTtiManager() : void
      {
         tti(201);
         plugins = ["ControlBar","Chat","Owl","Magic","TopLeftIconBar","TopRightIconBar","Works","SceneAssist","PK","Mail","Guide","Combat","ExbnScript","Login"];
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_NEW_SCENE_ROLE_DATA_LOADED,onSceneRoleDataLoaded,this);
         if(Boolean(plugins) && plugins.length > 0)
         {
            CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_ON_A_PLUGIN_INSTALLED,onAPlugInstaled,this);
         }
      }
      
      private function onTCPConnect(param1:TCPConnEvent) : void
      {
         loginUI2.setWaiting(false);
         var _loc2_:int = int(param1.getTCPID());
         if(roomLoginConn != null && _loc2_ == roomLoginConn.getID())
         {
            serverInfo.roomID = loginRoom.roomIndex;
            serverInfo.roomName = svrNameEngine.getNameByID(loginRoom.roomIndex);
            sendLoginConnData(ADFCmdsType.T_LoginRoom,{
               "roomID":loginRoom.roomIndex,
               "key":serverInfo.sessionKey,
               "uin":serverInfo.uin
            });
         }
      }
      
      private function loadDataComplete(param1:Event) : void
      {
         loginUI2.mouseEnabled = true;
         loginUI2.mouseChildren = true;
         var _loc2_:XML = new XML(cgiLoader.data);
         if(int(_loc2_.result[0].value[0]) != 0)
         {
            return;
         }
         switch(myParam)
         {
            case 0:
               if(int(_loc2_.state[0]) == 0)
               {
               }
               break;
            case 1:
               cgiLoader.removeEventListener(Event.COMPLETE,loadDataComplete);
         }
      }
      
      private function rangeReq(param1:LoginUIEvent) : void
      {
         param1.data.sessionKey = serverInfo.sessionKey;
         sendDirConnData(ADFCmdsType.T_DIR_RANGE_REQ,param1.data);
         trace("列表请求:" + param1.data);
      }
      
      private function sendPlatfromSrc() : void
      {
         var obj:* = undefined;
         var i:int = 0;
         if(ExternalInterface.available)
         {
            try
            {
               obj = ExternalInterface.call("get_platfrom_src");
               if(obj != null)
               {
                  i = parseInt(obj);
                  receiver.sendDataToServer(204836,i);
                  trace("调用页面js function get_platfrom_src返回值:" + i);
               }
               else
               {
                  trace("返回值为空：调用页面js function get_platfrom_src失败！" + obj);
               }
            }
            catch(e:Error)
            {
               trace("调用页面js  function get_platfrom_src失败！" + e.toString());
            }
         }
      }
      
      public function finalize() : Boolean
      {
         addListener(loginUI2,false);
         if(dirConn)
         {
            listenerTcpConn(dirConn,false);
            (system.getNetSysAPI() as INetSystem).disposeTCPProxy(dirConn.getID());
            dirConn = null;
         }
         if(roomLoginConn)
         {
            listenerTcpConn(roomLoginConn,false);
            roomLoginConn = null;
         }
         if(loginProcessor)
         {
            system.getNetSysAPI().removeDataProcessor(loginProcessor);
            loginProcessor = null;
         }
         if(fastLoginProcessor)
         {
            system.getNetSysAPI().removeDataProcessor(fastLoginProcessor);
            fastLoginProcessor = null;
         }
         if(receiver)
         {
            system.getNetSysAPI().removeDataReceiver(receiver);
            receiver.finalize();
            receiver = null;
         }
         loginRoom = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         return false;
      }
      
      private function connectSvr(param1:ITCPProxy, param2:String, param3:uint) : void
      {
         var conn:ITCPProxy = param1;
         var host:String = param2;
         var port:uint = param3;
         if(zoneBeginTime != -1)
         {
            zoneBeginTime = getTimer();
            isDirConnect = false;
         }
         loginUI2.setWaiting(true);
         try
         {
            _isLoginComponentInitialized = false;
            conn.connect(StringUtil.substitute("zone{0}.17roco.qq.com",host),port);
         }
         catch(e:Error)
         {
            loginUI2.setWaiting(false);
         }
      }
      
      protected function onPageStow(param1:MouseEvent) : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("window.top.AddFav");
         }
      }
      
      private function recommendReq(param1:LoginUIEvent) : void
      {
         trace("推荐请求:" + dirReqData);
         dirReqData.sessionKey = serverInfo.sessionKey;
         sendDirConnData(ADFCmdsType.T_DIR_RECOMMEND_REQ,dirReqData);
      }
      
      protected function record(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:Array = null;
         if(param1)
         {
            if(param2)
            {
               if(dirBeginTime != -1)
               {
                  log(getTimer() - dirBeginTime,5);
                  dirBeginTime = -1;
               }
            }
            else if(zoneBeginTime != -1)
            {
               log(getTimer() - zoneBeginTime,7);
               zoneBeginTime = -1;
            }
         }
         else
         {
            if(param2)
            {
               if(dirBeginTime != -1)
               {
                  log(getTimer() - dirBeginTime,4);
               }
               dirBeginTime = -1;
            }
            else if(zoneBeginTime != -1)
            {
               log(getTimer() - zoneBeginTime,6);
               zoneBeginTime = -1;
            }
            _loc3_ = Capabilities.version.split(" ")[1].split(",");
            if(int(_loc3_[0]) < 10)
            {
               log(58,1);
            }
            else if(int(_loc3_[0]) == 10)
            {
               if(int(_loc3_[1]) == 0)
               {
                  log(59,1);
               }
               else if(int(_loc3_[1]) == 1)
               {
                  log(60,1);
               }
               else if(int(_loc3_[1]) == 2)
               {
                  log(61,1);
               }
               else if(int(_loc3_[1]) == 3)
               {
                  log(62,1);
               }
               else if(int(_loc3_[1]) > 3)
               {
                  log(63,1);
               }
            }
            else if(int(_loc3_[0]) > 10)
            {
               log(63,1);
            }
         }
      }
      
      public function call(param1:Object) : *
      {
         trace("LoginPlugin Debug version get call args = " + param1);
         system.getUISysAPI().getPlugContainer().addChild(this);
      }
      
      protected function listenerTcpConn(param1:ITCPProxy, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.addEventListener(TCPConnEvent.TCPCONN_CONNECTED,onTCPConnect);
            param1.addEventListener(TCPConnEvent.TCPCONN_ERROR,onTCPConnectError);
         }
         else
         {
            param1.removeEventListener(TCPConnEvent.TCPCONN_CONNECTED,onTCPConnect);
            param1.removeEventListener(TCPConnEvent.TCPCONN_ERROR,onTCPConnectError);
         }
      }
      
      private function onError(param1:uint) : void
      {
      }
      
      private function dataHandle(param1:uint, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:LoginDataRepply = null;
         var _loc6_:SceneDes = null;
         var _loc7_:AngelSysEvent = null;
         var _loc8_:RoomData = null;
         switch(param1)
         {
            case ADFCmdsType.T_LoginRoom:
               sendPlatfromSrc();
               _loc5_ = param2 as LoginDataRepply;
               trace("登录返回码:",_loc5_.returnCode.message);
               if(_loc5_.returnCode.code == -101)
               {
                  this.loginUI2.setTooManyPeople(true);
               }
               else if(_loc5_.returnCode.code == -143)
               {
                  this.loginUI2.setTooManyTime(true);
               }
               else if(_loc5_.returnCode.code == -103)
               {
                  this.loginUI2.setWrongRoom(true);
               }
               else if(_loc5_.returnCode.code == -207)
               {
                  this.loginUI2.setErroChildWardMsg(true);
               }
               else if(_loc5_.returnCode.code < 0)
               {
                  this.loginUI2.setErroRefreshMsg(true);
               }
               else
               {
                  globalData.addGlobalVal(Constants.MAIN_ROLE_INFO,_loc5_.mainRole);
                  serverInfo.isFirstLogin = _loc5_.firstLogin == 1;
                  (_loc6_ = new SceneDes()).sceneID = _loc5_.sceneID;
                  _loc6_.ver = _loc5_.sceneVer;
                  globalData.addGlobalVal(Constants.WANT_TO_SCENE,_loc6_);
                  (_loc7_ = new AngelSysEvent(AngelSysEvent.LOGIN_OK)).data = getPlugName();
                  ProtocolHelper.USERUIN = _loc5_.mainRole.uin;
                  system.getGEventAPI().angelEventDispatcher.dispatchEvent(_loc7_);
               }
               record(false,false);
               break;
            case ADFCmdsType.T_DIR_INITIAL_COMPONENT:
               _isDirComponentInitialized = true;
               sendDirConnData();
               break;
            case ADFCmdsType.T_ROOM_INITIAL_COMPONENT:
               _isLoginComponentInitialized = true;
               sendLoginConnData();
               break;
            case ADFCmdsType.T_DIR_RECOMMEND_REPLY:
               if(param2 is RecommendDataList)
               {
                  recommendData = param2 as RecommendDataList;
                  _loc3_ = recommendData.roomInfos;
                  setRoomName(_loc3_);
                  loginUI2.setData(AngelLoginUI2.RECOMMEND_TYPE,recommendData.roomInfos);
                  recommendData.roomInfos = null;
                  openRuleApp();
               }
               record(false,true);
               break;
            case ADFCmdsType.T_DIR_RANGE_REPLY:
               rangeData = param2 as RangeDataList;
               if(Boolean(rangeData) && !rangeData.returnCode.isError())
               {
                  if(rangeReqSpeed && rangeData.roomCount == 1)
                  {
                     if((_loc8_ = rangeData.roomInfos[0] as RoomData).roomStat == 0)
                     {
                        loginReq(null,_loc8_);
                     }
                     else
                     {
                        this.loginUI2.setWrongRoom(true);
                     }
                  }
                  else
                  {
                     _loc3_ = rangeData.roomInfos;
                     setRoomName(_loc3_);
                     loginUI2.setData(AngelLoginUI2.RANGE_TYPE,rangeData.roomInfos,svrNameEngine.getTotal());
                     rangeData.roomInfos = null;
                  }
               }
               else
               {
                  loginUI2.setWrongRoom(true);
               }
               break;
            case ADFCmdsType.T_DIR_FAST_GETIN:
               if(param2)
               {
                  if(_loc8_ = param2 as RoomData)
                  {
                     loginReq(null,_loc8_);
                  }
               }
         }
      }
      
      private function loginReq(param1:LoginUIEvent, param2:RoomData = null) : void
      {
         if(!m_isAgree)
         {
            uiRule.visible = true;
            return;
         }
         if(param1 != null)
         {
            param2 = param1.data as RoomData;
         }
         if(this.roomLoginConn == null)
         {
            roomLoginConn = (system.getNetSysAPI() as INetSystem).createTCPProxy();
            roomLoginConn.getID();
            listenerTcpConn(roomLoginConn);
         }
         loginRoom = param2;
         connectSvr(roomLoginConn,param2.roomZoneID.toString(),param2.roomPort);
         tti(300);
      }
      
      private function onUIRuleClick(param1:MouseEvent) : void
      {
         var _loc2_:Object = param1.target;
         var _loc3_:String = String(param1.target.name);
         switch(_loc3_)
         {
            case "btnTick":
               if(uiRule.btnTick.currentFrame == 1)
               {
                  uiRule.btnTick.gotoAndStop(2);
                  uiRule.btnAgree.visible = true;
               }
               else
               {
                  uiRule.btnTick.gotoAndStop(1);
                  uiRule.btnAgree.visible = false;
               }
               break;
            case "btnAgree":
               uiRule.visible = false;
               break;
            case "btnLink0":
               navigateToURL(new URLRequest("http://game.qq.com/contract.shtml"));
               break;
            case "btnLink1":
               navigateToURL(new URLRequest("https://privacy.qq.com/"));
               break;
            case "btnAge":
               ageRule.visible = true;
               break;
            case "btnCloseAge":
               ageRule.visible = false;
         }
      }
      
      private function addListener(param1:AngelLoginUI2, param2:Boolean = true) : void
      {
         if(param2)
         {
            param1.addEventListener(LoginUIEvent.LOGIN_REQ,loginReq);
            param1.addEventListener(LoginUIEvent.RANGE_REQ,rangeReq);
            param1.addEventListener(LoginUIEvent.RECOMMAND_REQ,recommendReq);
            param1.addEventListener(LoginUIEvent.SPEED_IN,onSpeedIn);
            param1.addEventListener(LoginUIEvent.FAST_LOGIN,fastLoginReq);
         }
         else
         {
            param1.removeEventListener(LoginUIEvent.LOGIN_REQ,loginReq);
            param1.removeEventListener(LoginUIEvent.RANGE_REQ,rangeReq);
            param1.removeEventListener(LoginUIEvent.RECOMMAND_REQ,recommendReq);
            param1.removeEventListener(LoginUIEvent.SPEED_IN,onSpeedIn);
            param1.removeEventListener(LoginUIEvent.FAST_LOGIN,fastLoginReq);
         }
      }
      
      private function setRoomName(param1:Array) : void
      {
         var _loc2_:RoomData = null;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = param1[_loc3_] as RoomData;
            _loc2_.roomName = _loc2_.roomIndex + " " + svrNameEngine.getNameByID(_loc2_.roomIndex);
            _loc3_++;
         }
      }
      
      public function initialize() : Boolean
      {
         var confs:Object = null;
         var listConf:Object = null;
         var serverlistxml:XML = null;
         trace("LoginPlugin Debug version initialize!!");
         CommSerItem.grayFilter = FilterFactory.createGrayFilter();
         loginUI2 = new AngelLoginUI2();
         addListener(loginUI2);
         addChild(loginUI2);
         loginUI2.stow_btn.addEventListener(MouseEvent.CLICK,onPageStow);
         loginUI2.chooseBtn.gotoAndStop(m_isAgree ? 1 : 2);
         loginUI2.chooseBtn.buttonMode = true;
         loginUI2.chooseBtn.mouseChildren = false;
         loginUI2.chooseBtn.addEventListener(MouseEvent.CLICK,function(param1:*):*
         {
            m_isAgree = !m_isAgree;
            loginUI2.chooseBtn.gotoAndStop(m_isAgree ? 1 : 2);
         });
         uiRule = new UIResRule();
         uiRule.visible = false;
         uiRule.addEventListener(MouseEvent.CLICK,onUIRuleClick);
         addChild(uiRule);
         ageRule = new UIAgeRule();
         ageRule.visible = false;
         ageRule.addEventListener(MouseEvent.CLICK,onUIRuleClick);
         addChild(ageRule);
         loginUI2.btnAge.addEventListener(MouseEvent.CLICK,onUIRuleClick);
         if(system)
         {
            receiver = new LoginReceiver(system);
            receiver.setLoading(loginUI2);
            confs = system.getGDataAPI().getGlobalVal(Constants.CONFS);
            listConf = confs["RoomList"];
            confs["RoomList"] = null;
            serverlistxml = listConf is XML ? listConf as XML : new XML(listConf);
            svrNameEngine.initialize(serverlistxml);
            system.getNetSysAPI().addDataProcessor(loginProcessor);
            system.getNetSysAPI().addDataProcessor(recommendProcessor);
            system.getNetSysAPI().addDataProcessor(rangeProcessor);
            system.getNetSysAPI().addDataProcessor(fastLoginProcessor);
            system.getNetSysAPI().addDataProcessor(platfromSrcProcessor);
            system.getNetSysAPI().addDataProcessor(initalProcessor);
            system.getNetSysAPI().addDataReceiver(receiver);
            receiver.handle = dataHandle;
            globalData = system.getGDataAPI();
            serverInfo = globalData.getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
            ProtocolHelper.USERUIN = serverInfo.uin;
            tryConnectToDir();
            setUpTtiManager();
            return true;
         }
         throw new Error("LoginPlug:System获取失败..");
      }
      
      protected function onLoadError(param1:IOErrorEvent) : void
      {
         loginUI2.mouseEnabled = true;
         loginUI2.mouseChildren = true;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         system = param1;
      }
      
      public function getPlugName() : String
      {
         return this._name;
      }
      
      public function getEDispatcher() : IEventDispatcher
      {
         return null;
      }
      
      private function tryConnectToDir() : void
      {
         if(!dirConn)
         {
            dirConn = (system.getNetSysAPI() as INetSystem).createTCPProxy(false);
            listenerTcpConn(dirConn);
         }
         loginUI2.setWaiting(true);
         dirConn.connect(serverInfo.dirHost,serverInfo.dirPort);
         dirReqData["uin"] = serverInfo.uin;
         dirReqData.sessionKey = serverInfo.sessionKey;
         sendDirConnData(ADFCmdsType.T_DIR_RECOMMEND_REQ,dirReqData);
         if(dirBeginTime != -1)
         {
            dirBeginTime = getTimer();
            isDirConnect = true;
         }
      }
      
      public function setPlugName(param1:String) : void
      {
         this._name = param1;
      }
      
      private function openRuleApp() : void
      {
         loginUI2.mouseEnabled = false;
         loginUI2.mouseChildren = false;
         sendCgi("privacy_agreement?cmd=0",0);
      }
      
      private function sendCgi(param1:String, param2:int) : void
      {
         if(cgiLoader == null)
         {
            cgiLoader = new AngelURLLoader(serverInfo);
            cgiLoader.setNoCache(true);
            cgiLoader.setTimeOut(-1);
            cgiLoader.addEventListener(Event.COMPLETE,loadDataComplete,false,1);
            cgiLoader.addEventListener(IOErrorEvent.IO_ERROR,onLoadError,false,1);
         }
         myParam = param2;
         cgiLoader.load(new URLRequest(DEFINE.CGI_ROOT + param1 + "&unkown=" + (!!serverInfo.pskey ? serverInfo.pskey : serverInfo.skey) + "&skey=" + serverInfo.skey));
      }
      
      private function onTCPConnectError(param1:TCPConnEvent) : void
      {
         loginUI2.setWaiting(false);
         loginUI2.setErroMsg(true);
         record(true,isDirConnect);
      }
      
      private function sendLoginConnData(param1:int = -1, param2:Object = null) : void
      {
         var _loc3_:Array = null;
         if(param1 != -1)
         {
            _sendLoginReqList[_sendLoginReqList.length] = [param1,param2];
         }
         if(_isLoginComponentInitialized)
         {
            if(this.roomLoginConn.isConnected())
            {
               while(_sendLoginReqList.length > 0)
               {
                  _loc3_ = _sendLoginReqList.shift();
                  receiver.sendData(this.roomLoginConn.getID(),_loc3_[0],_loc3_[1]);
               }
            }
            else
            {
               _isLoginComponentInitialized = false;
               loginUI2.setWaiting(true);
               this.roomLoginConn.reconnect();
            }
         }
      }
      
      private function fastLoginReq(param1:LoginUIEvent) : void
      {
         if(!m_isAgree)
         {
            uiRule.visible = true;
            return;
         }
         var _loc2_:Object = {"sessionKey":serverInfo.sessionKey};
         sendDirConnData(ADFCmdsType.T_DIR_FAST_GETIN,_loc2_);
         tti(300);
      }
      
      private function onSpeedIn(param1:LoginUIEvent) : void
      {
         if(!m_isAgree)
         {
            uiRule.visible = true;
            return;
         }
         rangeReqSpeed = true;
         var _loc2_:int = int(param1.data);
         sendDirConnData(ADFCmdsType.T_DIR_RANGE_REQ,{
            "start":_loc2_,
            "stop":_loc2_,
            "sessionKey":serverInfo.sessionKey
         });
         tti(300);
      }
      
      private function sendDirConnData(param1:int = -1, param2:Object = null) : void
      {
         var _loc3_:Array = null;
         if(param1 != -1)
         {
            _sendDirReqList[_sendDirReqList.length] = [param1,param2];
         }
         if(_isDirComponentInitialized)
         {
            if(this.dirConn.isConnected())
            {
               while(_sendDirReqList.length > 0)
               {
                  _loc3_ = _sendDirReqList.shift();
                  receiver.sendData(this.dirConn.getID(),_loc3_[0],_loc3_[1]);
               }
            }
            else
            {
               _isDirComponentInitialized = false;
               loginUI2.setWaiting(true);
               this.dirConn.reconnect();
            }
         }
      }
   }
}
