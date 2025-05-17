package com.QQ.angel.common
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IGlobalEventAPI;
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.api.events.AngelDataEvent;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.data.entity.*;
   import com.QQ.angel.data.entity.combatsys.OpenCombatDes;
   import com.QQ.angel.data.entity.tasksys.model.IModelManager;
   import com.QQ.angel.logging.log;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.external.ExternalInterface;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class __global
   {
      
      public static var NPCCDesClsMap:Dictionary;
      
      private static var __sysApi:IAngelSysAPI;
      
      private static var __ui:ICommUIManager;
      
      private static var __roleSys:IRoleSysAPI;
      
      private static var __GEventAPI:IGlobalEventAPI;
      
      private static var __dataAPI:CommonDataAPI;
      
      private static var __sceneWatcher:SceneWatcher;
      
      public static var isDevelopment:Boolean = false;
      
      public static var isMainRoleVipInto:Boolean = false;
      
      private static var __inited:Boolean = false;
      
      private static var __onlyCall:CFunction = new CFunction(executeClick,__global,[null,false]);
      
      private static var _executeClickCallBackDic:Dictionary = new Dictionary();
      
      public function __global()
      {
         super();
      }
      
      public static function initialize(param1:IAngelSysAPI) : void
      {
         var sysApi:IAngelSysAPI = param1;
         if(__inited)
         {
            return;
         }
         try
         {
            __sysApi = sysApi;
            NPCCDesClsMap = new Dictionary();
            NPCCDesClsMap["NULL"] = NPCCDConvert;
            NPCCDesClsMap[AngelSysEvent.ON_OPEN_GAME] = OpenGameDes;
            NPCCDesClsMap["onOpenGame"] = OpenGameDes;
            NPCCDesClsMap[AngelSysEvent.ON_CHANGE_SCENE] = ChangeSceneDes;
            NPCCDesClsMap[AngelSysEvent.ON_OPEN_ASWIN] = OpenAsWinDes;
            NPCCDesClsMap[AngelSysEvent.ON_SCENECMD_CALL] = SceneCMDDes;
            NPCCDesClsMap["onOpenCombat"] = OpenCombatDes;
            NPCCDesClsMap[AngelSysEvent.ON_RUN_SCRIPT] = WorldScriptDes;
            NPCCDesClsMap["onTaskCall"] = OpenNPCTaskDes2;
            NPCCDesClsMap["onTaskCall2"] = DealTaskDes;
            NPCCDesClsMap[AngelSysEvent.ON_TASK_CALL] = OpenNPCTaskDes;
            NPCCDesClsMap[AngelSysEvent.ON_TIMES_PAPER] = OpenTimesPaper;
            NPCCDesClsMap[AngelSysEvent.ON_LOGIN_HOMESTEAD] = LoginHomesteadDes;
            NPCCDesClsMap["onPluginCall"] = PluginCallDes;
            NPCCDesClsMap[AngelSysEvent.ON_INVITE_FRIEND] = OpenInviteFriendDes;
            NPCCDesClsMap[AngelSysEvent.ON_RIDDLEIS_LAND] = null;
            NPCCDesClsMap[AngelSysEvent.ON_CHRISTMAS_TREE] = null;
            NPCCDesClsMap[AngelSysEvent.ON_LOGIN_MANOR] = LoginHomesteadDes;
            NPCCDesClsMap[AngelSysEvent.ON_MOVIE_AD_TEMP] = null;
            __roleSys = __sysApi.getWorldAPI().getRoleSysAPI();
            __GEventAPI = __sysApi.getGEventAPI();
            if(!__dataAPI)
            {
               __dataAPI = new CommonDataAPI(sysApi);
            }
            if(!__sceneWatcher)
            {
               __sceneWatcher = new SceneWatcher(sysApi);
            }
         }
         catch(e:Error)
         {
            return;
         }
         if(__roleSys != null && __GEventAPI != null && __dataAPI != null && __sceneWatcher != null)
         {
            __inited = true;
         }
         __global.GEventAPI.angelEventDispatcher.addEventListener("executeClickCallBack",executeClickCallBack);
      }
      
      public static function get UI() : ICommUIManager
      {
         if(__ui == null && __sysApi != null)
         {
            __ui = __sysApi.getUISysAPI().commUIManager;
         }
         return __ui;
      }
      
      public static function get MainRoleData() : RoleData
      {
         return __dataAPI.MainRoleData;
      }
      
      public static function get modelManager() : IModelManager
      {
         return __dataAPI.modelManager;
      }
      
      public static function get SysAPI() : IAngelSysAPI
      {
         return __sysApi;
      }
      
      public static function get GEventAPI() : IGlobalEventAPI
      {
         return __GEventAPI;
      }
      
      public static function get DataAPI() : CommonDataAPI
      {
         return __dataAPI;
      }
      
      public static function get sceneWatcher() : SceneWatcher
      {
         return __sceneWatcher;
      }
      
      public static function openGame(param1:OpenGameDes, param2:int = 0, param3:int = 0, param4:int = 0, param5:String = "", param6:String = "", param7:CFunction = null) : void
      {
         if(param1 == null)
         {
            param1 = new OpenGameDes();
            param1.gameType = param2;
            param1.gameID = param3;
            param1.gameParms = param5;
            param1.cGameID = param4;
            param1.handler = param7;
         }
         __GEventAPI.cmdExecuted("onOpenGame",param1);
      }
      
      public static function openCombat(param1:OpenCombatDes, param2:int = 0, param3:uint = 0, param4:String = "", param5:CFunction = null) : void
      {
         if(param1 == null)
         {
            param1 = new OpenCombatDes();
            param1.combatType = param2;
            param1.opponentID = param3;
            if(param4 != null && param4 != "")
            {
               param1.oppoentName = param4;
            }
            param1.handler = param5;
         }
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_OPEN_COMBAT,param1);
      }
      
      public static function openMultiCombat(param1:OpenCombatDes, param2:int = 10001, param3:uint = 0, param4:String = "", param5:CFunction = null) : void
      {
         if(param1 == null)
         {
            param1 = new OpenCombatDes();
            param1.combatType = param2;
            param1.opponentID = param3;
            if(param4 != null && param4 != "")
            {
               param1.oppoentName = param4;
            }
            param1.handler = param5;
         }
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_OPEN_MULTI_COMBAT,param1);
      }
      
      public static function openAsWin(param1:OpenAsWinDes, param2:Object = null) : void
      {
         if(param1 != null)
         {
            __sysApi.getExternalAPI().openASWindow(param1.src,param1.name,param1.isModal,param1.winPos,null,param1.params,true,param1.cache);
         }
         else if(param2 != null)
         {
            __sysApi.getExternalAPI().openASWindow(param2.id,param2.name,param2.isModal,param2.pos,param2.created,param2.params,true,param2.cache);
         }
      }
      
      public static function getMaxSceneVer(param1:int) : int
      {
         var conf:Object;
         var xmllist:XMLList;
         var ver:int = 0;
         var confs:Object = null;
         var xml:XML = null;
         var item:XML = null;
         var keyInt:int = 0;
         var sceneID:int = param1;
         ver = 1;
         confs = SysAPI.getGDataAPI().getGlobalVal(Constants.CONFS);
         if(confs == null)
         {
            return ver;
         }
         conf = confs["scene_conf"];
         if(conf == null)
         {
            return ver;
         }
         xml = conf is XML ? conf as XML : new XML(conf);
         if(xml == null)
         {
            return ver;
         }
         xmllist = xml.SceneDes.(@id == sceneID);
         for each(item in xmllist)
         {
            keyInt = int(item.@sceneVer);
            if(keyInt > ver)
            {
               ver = keyInt;
            }
         }
         return ver;
      }
      
      public static function changeScene(param1:ChangeSceneDes, param2:Object = null, param3:int = 1) : void
      {
         if(param1 == null)
         {
            param1 = new ChangeSceneDes();
            if(param2 is Array)
            {
               param1.randomIDs = param2 as Array;
            }
            else
            {
               param1.sceneID = int(param2);
            }
            param1.ver = param3;
         }
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_CHANGE_SCENE,param1);
      }
      
      public static function isInNewWorld() : Boolean
      {
         if(__sceneWatcher == null)
         {
            return false;
         }
         return __sceneWatcher.isInNewWorld;
      }
      
      public static function fireSceneEvent(param1:String, param2:*) : void
      {
         var _loc3_:SceneCMDDes = new SceneCMDDes();
         _loc3_.cmd = SceneCMDDes.EVENT_CMD;
         _loc3_.type = param1;
         _loc3_.params = param2;
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_SCENECMD_CALL,_loc3_);
      }
      
      public static function showMsgBox(param1:Object, param2:int = 1, param3:CFunction = null) : int
      {
         var _loc4_:ICommUIManager = UI;
         if(_loc4_ == null)
         {
            return 0;
         }
         var _loc5_:String = "";
         if(param1 is String)
         {
            _loc5_ = param1 as String;
         }
         else if(param1 != null)
         {
            _loc5_ = param1.msg;
            param2 = param1.hasOwnProperty("mode") ? int(param1.mode) : 1;
            param3 = param1.hasOwnProperty("handler") ? param1.handler : null;
         }
         return _loc4_.alert("",_loc5_,param2,param3);
      }
      
      public static function showMAlert(param1:MovieClip, param2:String = "", param3:String = "", param4:Function = null, param5:Function = null) : IWindow
      {
         return UI.mAlert(param1,param2,param3,param4,param5);
      }
      
      public static function openNPCDialog(param1:NPCDialogData, param2:Object = null) : void
      {
         if(param1 == null)
         {
            param1 = new NPCDialogData();
            param1.dialogs = param2.dialogs;
            escDialogData(param1.dialogs);
            param1.buttons = param2.buttons;
            param1.items = param2.items;
         }
         UI.showManagedWin(9,param1);
      }
      
      public static function buySomething(param1:uint) : void
      {
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_PURCHASE,{"id":param1});
      }
      
      public static function useMagicSkill(param1:Object) : void
      {
         var _loc2_:OpenMagicDes = param1 as OpenMagicDes;
         if(_loc2_ == null && param1 != null)
         {
            _loc2_ = new OpenMagicDes();
            _loc2_.actionType = param1.actionType;
            _loc2_.clientArg = param1.clientArg;
            _loc2_.dur = param1.dur;
            _loc2_.id = param1.id;
            _loc2_.magicType = param1.magicType;
            _loc2_.target = param1.target;
         }
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_MAGIC_CALL,_loc2_);
      }
      
      public static function checkUserInfo(param1:CheckUserInfoDes) : void
      {
         __GEventAPI.cmdExecuted(AngelSysEvent.ON_USER_INFO,param1);
      }
      
      public static function showItemPanel(param1:Array, param2:Function = null) : void
      {
         UI.showRewardArray(param1,param2);
      }
      
      public static function getNPCPath() : String
      {
         return DEFINE.COMM_ROOT + "res/npc/";
      }
      
      public static function getNPCPreview(param1:int) : String
      {
         return getNPCPath() + param1 + "/preview.png";
      }
      
      public static function escDialogText(param1:String, param2:String = "") : String
      {
         if(param2 == "")
         {
            param2 = MainRoleData.nickName;
         }
         return param1.replace(/\{name\}/g,param2);
      }
      
      public static function escDialogData(param1:Object) : Array
      {
         var _loc5_:Object = null;
         var _loc2_:String = MainRoleData.nickName;
         var _loc3_:Array = param1 as Array;
         if(_loc3_ == null)
         {
            _loc3_ = [param1];
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.hasOwnProperty("npcID"))
            {
               _loc5_.npcURL = getNPCPreview(_loc5_["npcID"]);
            }
            if(_loc5_.text != undefined && _loc5_.text != "")
            {
               _loc5_.text = escDialogText(_loc5_.text,_loc2_);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public static function executeClick(param1:*, param2:Boolean = true, param3:Function = null) : void
      {
         var _loc5_:String = null;
         var _loc7_:Object = null;
         if(param1 == null)
         {
            return;
         }
         var _loc4_:NPCCDConvert = param1 as NPCCDConvert;
         if(_loc4_ == null)
         {
            if(!(param1 is XML))
            {
               return;
            }
            _loc5_ = param1.@event;
            _loc4_ = createNPCCD(_loc5_);
            _loc4_.tranNPCClickDes(param1);
         }
         if(param2 && _loc4_.aimPos != null && _loc4_.distance != -1)
         {
            __onlyCall.params[0] = _loc4_;
            heroClosedExec(_loc4_.aimPos,_loc4_.distance,__onlyCall);
            return;
         }
         __onlyCall.params[0] = null;
         _loc5_ = _loc4_.event;
         if(_loc4_.fire)
         {
            __global.DataAPI.fireClickToCGI(_loc4_.npcID,true);
         }
         var _loc6_:Array = _loc4_.logArgs;
         if(_loc6_ != null)
         {
            log(_loc6_[0],_loc6_[1]);
         }
         if(_loc5_ == "ACTIVE")
         {
            _loc7_ = _loc4_.target;
            if(_loc7_ != null && Boolean(_loc7_.hasOwnProperty("setActiveNPC")))
            {
               _loc7_["setActiveNPC"](_loc4_["funName"]);
            }
         }
         else if(_loc5_ != "NULL")
         {
            __global.GEventAPI.cmdExecuted(_loc5_,_loc4_);
         }
         if(param3 != null)
         {
            _executeClickCallBackDic[_loc4_] = param3;
         }
      }
      
      private static function executeClickCallBack(param1:AngelDataEvent) : void
      {
         if(_executeClickCallBackDic[param1.data] != null)
         {
            (_executeClickCallBackDic[param1.data] as Function)();
            _executeClickCallBackDic[param1.data] = null;
            delete _executeClickCallBackDic[param1.data];
         }
      }
      
      public static function createNPCCD(param1:String) : NPCCDConvert
      {
         var _loc2_:Class = NPCCDesClsMap[param1] as Class;
         if(_loc2_ == null)
         {
            throw new AngelError("[__global] 没有找到对[" + param1 + "]类型的配置解析类!");
         }
         var _loc3_:NPCCDConvert = new _loc2_() as NPCCDConvert;
         _loc3_.event = param1;
         return _loc3_;
      }
      
      public static function heroClosedExec(param1:Point, param2:int = 0, param3:CFunction = null) : void
      {
         if(__roleSys == null)
         {
            return;
         }
         if(!(param1 is Point))
         {
            trace("[__global] SceneCmdType.CLOSE_ACTION所带参数[{aim:point,dis:int,callBack:CFunction}}]不正确!");
            return;
         }
         if(!(param3 is CFunction))
         {
            __roleSys.mainRoleWalk(param1);
            return;
         }
         if(param2 < 0 || param2 >= 1000)
         {
            param3.invoke();
            return;
         }
         var _loc4_:Number = __roleSys.distanceToMR(param1.clone());
         if(_loc4_ <= uint(param2))
         {
            param3.invoke();
            return;
         }
         var _loc5_:WalkAndThenDes = new WalkAndThenDes();
         _loc5_.aim = param1;
         _loc5_.dis = param2;
         _loc5_.callBack = param3;
         __roleSys.mainRoleWalk(_loc5_);
      }
      
      public static function setSysUIState(param1:int) : void
      {
         var _loc2_:AngelSysEvent = new AngelSysEvent(AngelSysEvent.ON_SYS_EVENT);
         _loc2_.data = new SysEventDes();
         _loc2_.data.type = SysEventDes.SET_SYSUI_STATE;
         _loc2_.data.data = param1;
         __GEventAPI.angelEventDispatcher.dispatchEvent(_loc2_);
      }
      
      public static function setMute(param1:Boolean) : void
      {
         __sysApi.getMediaSysAPI().setMute(param1);
      }
      
      public static function getAvataPreview(param1:uint, param2:uint = 100, param3:uint = 0, param4:uint = 0) : BitmapData
      {
         var _loc9_:Matrix = null;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:IResAdapter = __sysApi.getResSysAPI().getResAdapter(Constants.AVATAR_RES);
         var _loc6_:GotAvatarImgDes = new GotAvatarImgDes();
         _loc6_.uin = param1;
         _loc6_.motionType = param4;
         _loc6_.avatarVer = param2;
         var _loc7_:BitmapData = _loc5_.requestRes(_loc6_) as BitmapData;
         _loc6_.uin = 0;
         if(_loc7_ == null)
         {
            _loc7_ = _loc5_.requestRes(_loc6_) as BitmapData;
         }
         if(_loc7_ == null)
         {
            return null;
         }
         var _loc8_:BitmapData = new BitmapData(100,100,true,16777215);
         if(_loc7_.height == 400)
         {
            _loc9_ = new Matrix();
            _loc10_ = 300 / _loc7_.width;
            _loc11_ = 300 / _loc7_.height;
            _loc9_.translate(-26,-38);
            _loc9_.scale(_loc10_,_loc11_);
            _loc8_.draw(_loc7_,_loc9_,null,null,null,true);
         }
         else
         {
            _loc8_.copyPixels(_loc7_,new Rectangle(0,0,100,100),new Point(0,0));
         }
         return _loc8_;
      }
      
      public static function getPtloginSignLength() : uint
      {
         var _loc1_:ServerInfo = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         if(_loc1_)
         {
            if(_loc1_.pskey)
            {
               return _loc1_.pskey.length + 2;
            }
            if(_loc1_.skey)
            {
               return _loc1_.skey.length + 2;
            }
         }
         return 12;
      }
      
      public static function WritePtloginSign(param1:IDataOutput) : void
      {
         var _loc2_:ServerInfo = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         if(_loc2_)
         {
            if(_loc2_.pskey)
            {
               param1.writeShort(_loc2_.pskey.length);
               DEFINE.WriteChars(param1,_loc2_.pskey,_loc2_.pskey.length);
               return;
            }
            if(_loc2_.skey)
            {
               param1.writeShort(_loc2_.skey.length);
               DEFINE.WriteChars(param1,_loc2_.skey,_loc2_.skey.length);
               return;
            }
         }
         param1.writeShort(10);
         DEFINE.WriteChars(param1,"0123456789",10);
      }
      
      public static function linkToVipPayPage(param1:Object = null) : int
      {
         var _loc2_:String = "https://pay.qq.com/ipay/index.shtml?c=lkwg";
         var _loc3_:int = -1;
         if(ExternalInterface.available)
         {
            _loc3_ = ExternalInterface.call("get_platfrom_src");
         }
         navigateToPayment(1);
         var _loc4_:IEventDispatcher = GEventAPI.angelEventDispatcher;
         var _loc5_:Event = new Event("vipPay");
         _loc4_.dispatchEvent(_loc5_);
         return _loc3_;
      }
      
      public static function linkToRocoDiamondPayPage(param1:int = 100) : void
      {
         navigateToPayment(0,param1);
      }
      
      public static function navigateToPayment(param1:int, param2:int = 100) : void
      {
         var _loc3_:ServerInfo = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         var _loc4_:Object = {
            "type":param1,
            "num":param2,
            "access_token":_loc3_.pskey,
            "openid":_loc3_.skey,
            "uin":_loc3_.uin,
            "angel_key":_loc3_.sessionKey
         };
         openPaymentPage(_loc4_);
      }
      
      public static function directPurchase(param1:String) : *
      {
         var info:ServerInfo;
         var params:Object;
         var url:String = param1;
         ExternalInterface.addCallback("purchaseCallBack",function():*
         {
            __global.SysAPI.getGEventAPI().angelEventDispatcher.dispatchEvent(new Event("Activity_purchase"));
         });
         info = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         params = {
            "url":url,
            "type":2,
            "num":0,
            "access_token":info.pskey,
            "openid":info.skey,
            "uin":info.uin,
            "angel_key":info.sessionKey
         };
         openPaymentPage(params);
      }
      
      public static function openPaymentPage(param1:Object) : *
      {
         var _loc2_:String = objectToJsonString(param1);
         if(ExternalInterface.available)
         {
            ExternalInterface.call("startPay",_loc2_);
         }
         else
         {
            trace("ExternalInterface不可用");
         }
      }
      
      public static function objectToJsonString(param1:Object) : String
      {
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc2_:* = "{";
         var _loc3_:Boolean = true;
         for(_loc4_ in param1)
         {
            if(!_loc3_)
            {
               _loc2_ += ",";
            }
            _loc5_ = param1[_loc4_];
            if(_loc5_ is String)
            {
               _loc2_ += "\"" + _loc4_ + "\":\"" + _loc5_ + "\"";
            }
            else if(_loc5_ is Number || _loc5_ is Boolean)
            {
               _loc2_ += "\"" + _loc4_ + "\":" + _loc5_;
            }
            else if(_loc5_ is Object)
            {
               _loc2_ += "\"" + _loc4_ + "\":" + objectToJsonString(_loc5_);
            }
            _loc3_ = false;
         }
         return _loc2_ + "}";
      }
      
      public static function showVipConfirm() : *
      {
         __global.showMsgBox("充值VIP才能享有特权，是否前往开通？",2,new CFunction(function(param1:int):*
         {
            if(param1 == 1)
            {
               linkToVipPayPage();
            }
         }));
      }
      
      public static function showRocoDiamondConfirm(param1:int = 100) : *
      {
         var num:int = param1;
         __global.showMsgBox("当前洛克钻数量不足，是否前往充值？",2,new CFunction(function(param1:int):*
         {
            if(param1 == 1)
            {
               linkToRocoDiamondPayPage(num);
            }
         }));
      }
      
      public static function ReadPtloginSign(param1:IDataInput) : String
      {
         var _loc2_:uint = uint(param1.readUnsignedShort());
         var _loc3_:String = DEFINE.ReadChars(param1,_loc2_);
         var _loc4_:ServerInfo = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         if(_loc4_)
         {
            if(_loc2_ == 10)
            {
               _loc4_.skey = _loc3_;
            }
            else
            {
               _loc4_.pskey = _loc3_;
            }
         }
         return _loc3_;
      }
      
      public static function getCookie(param1:String) : String
      {
         var _loc2_:String = null;
         if(ExternalInterface.available)
         {
            _loc2_ = ExternalInterface.call("getCookie",param1);
         }
         return _loc2_;
      }
      
      public static function setVerifyCodeImage(param1:DisplayObjectContainer, param2:Function) : void
      {
         var verifyCodeLoader:Loader = null;
         var completeHandler:Function = null;
         var parent:DisplayObjectContainer = param1;
         var cb:Function = param2;
         completeHandler = function(param1:Event):void
         {
            verifyCodeLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
            var _loc2_:String = getCookie("verifysession");
            cb && cb(_loc2_);
         };
         var fileUrl:String = "https://captcha.qq.com/getimage?aid=37000201&" + Math.random();
         verifyCodeLoader = new Loader();
         verifyCodeLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
         verifyCodeLoader.load(new URLRequest(fileUrl));
         if(parent)
         {
            while(parent.numChildren > 0)
            {
               parent.removeChildAt(0);
            }
            parent.addChild(verifyCodeLoader);
         }
      }
   }
}

