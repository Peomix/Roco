package com.QQ.angel.external
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelApp;
   import com.QQ.angel.api.IAngelCMDExec;
   import com.QQ.angel.api.IAngelCMDExecAware;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IExternalAPI;
   import com.QQ.angel.api.IParamsAware;
   import com.QQ.angel.api.IXMLScriptParamsAware;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.events.WindowEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.OpenAsWinDes;
   import com.QQ.angel.data.entity.SysResInfo;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.external.ExternalInterface;
   import flash.geom.Point;
   import flash.net.LocalConnection;
   import flash.system.ApplicationDomain;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class AngelExternalManger implements IExternalAPI, IAngelSysAPIAware, ICmdListener
   {
       
      
      protected var myRoot:Sprite;
      
      protected var defaultRate:int;
      
      protected var openAsWinParam:Object;
      
      protected var asWinsCache:Dictionary;
      
      protected var angelSysApi:IAngelSysAPI;
      
      protected var winResInfo:SysResInfo;
      
      protected var gcDelayID:int;
      
      protected var commUI:ICommUIManager;
      
      protected var hostKey:String;
      
      protected var clientKey:String;
      
      private var m_recent:Boolean;
      
      public function AngelExternalManger(param1:Sprite)
      {
         super();
         this.myRoot = param1;
         this.defaultRate = param1.stage.frameRate;
         this.myRoot.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
         this.winResInfo = new SysResInfo();
         this.winResInfo.reset();
         this.winResInfo.callBack = new CFunction(this.onWCLoaded,this);
         this.winResInfo.loadingViewType = 5;
         this.winResInfo.contents = [""];
         this.asWinsCache = new Dictionary();
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_APP_BY_STRING,AngelExternalManger.onApplyOpenAsWinString,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_APP_BY_DES,AngelExternalManger.onApplyOpenAsWinDes,this);
      }
      
      private static function onApplyOpenAsWinString(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:OpenAsWinDes;
         (_loc5_ = new OpenAsWinDes()).src = param2 as String;
         _loc5_.winPos = new Point(0,0);
         _loc5_.name = "";
         _loc5_.isModal = true;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_APP_BY_DES,_loc5_,param3);
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onApplyOpenAsWinDes(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:AngelExternalManger = AngelExternalManger(param4);
         var _loc6_:OpenAsWinDes = param2 as OpenAsWinDes;
         _loc5_.m_recent = false;
         if(_loc6_)
         {
            _loc5_.m_recent = _loc5_._openASWindow(_loc6_.src,_loc6_.name,_loc6_.isModal,_loc6_.winPos,_loc6_.created,_loc6_.params,true,_loc6_.cache,_loc6_.xmlScriptParams);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      protected function keyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.F5)
         {
            this.reflashHTML();
         }
      }
      
      protected function onWCClosing(param1:WindowEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:IAngelApp = null;
         var _loc2_:IWindow = param1.target as IWindow;
         if(_loc2_ != null && _loc2_.closeAction == "close")
         {
            _loc2_.removeEventListener(WindowEvent.CLOSING,this.onWCClosing);
            _loc3_ = "";
            for(_loc4_ in this.asWinsCache)
            {
               if(this.asWinsCache[_loc4_] == _loc2_)
               {
                  _loc3_ = _loc4_;
                  delete this.asWinsCache[_loc4_];
                  break;
               }
            }
            if(_loc3_ != "")
            {
               this.ccGC(3000);
            }
         }
         else if((_loc5_ = _loc2_.getContent() as IAngelApp) != null)
         {
            _loc5_.inactivate();
         }
      }
      
      protected function onWCLoaded(param1:LoadTaskEvent, param2:* = null) : void
      {
         var _loc3_:ResData = null;
         var _loc6_:Point = null;
         var _loc7_:IAngelApp = null;
         var _loc4_:IWindow = null;
         var _loc5_:*;
         if((_loc5_ = param2) == null && param1 != null)
         {
            _loc3_ = param1.resData;
            if(_loc3_ != null && _loc3_.content is Array)
            {
               _loc5_ = _loc3_.content[0];
            }
         }
         if(_loc5_ != null)
         {
            if(this.commUI == null)
            {
               this.commUI = this.angelSysApi.getUISysAPI().commUIManager;
            }
            if((_loc4_ = this.commUI.createScaleWinow(_loc5_,this.openAsWinParam == null ? false : Boolean(this.openAsWinParam.isModal))) != null)
            {
               if(_loc5_ is IAngelSysAPIAware)
               {
                  (_loc5_ as IAngelSysAPIAware).setAngelSysAPI(this.angelSysApi);
               }
               else if(_loc5_ is IAngelCMDExecAware)
               {
                  (_loc5_ as IAngelCMDExecAware).setAngelCMDExec(this.angelSysApi.getGEventAPI() as IAngelCMDExec);
               }
               if(_loc5_ is IParamsAware)
               {
                  (_loc5_ as IParamsAware).setParams(this.openAsWinParam == null ? null : this.openAsWinParam.params);
               }
               if(_loc5_ is IXMLScriptParamsAware)
               {
                  (_loc5_ as IXMLScriptParamsAware).setScriptParams(this.openAsWinParam == null ? null : this.openAsWinParam.xmlScriptParams);
               }
               if(_loc5_ is IAngelApp)
               {
                  _loc7_ = _loc5_ as IAngelApp;
                  if(this.openAsWinParam != null && Boolean(this.openAsWinParam.cache))
                  {
                     _loc4_.closeAction = "hide";
                  }
                  _loc7_.setup();
                  _loc7_.activate();
               }
               if((_loc6_ = this.openAsWinParam == null ? null : this.openAsWinParam.pos) != null)
               {
                  _loc4_.moveTo(_loc6_.x,_loc6_.y);
               }
               else
               {
                  _loc4_.center();
               }
               if(this.openAsWinParam != null && Boolean(this.openAsWinParam.managed))
               {
                  this.asWinsCache[this.openAsWinParam.source] = _loc4_;
                  _loc4_.addEventListener(WindowEvent.CLOSING,this.onWCClosing);
               }
            }
         }
         if(this.openAsWinParam != null && this.openAsWinParam.created != null)
         {
            this.openAsWinParam.created(_loc4_);
         }
         this.openAsWinParam = null;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysApi = param1;
         this.angelSysApi.getGEventAPI().addCmdListener(AngelSysEvent.ON_OPEN_ASWIN,this);
      }
      
      public function call(param1:Object) : *
      {
         var _loc2_:OpenAsWinDes = param1 as OpenAsWinDes;
         if(_loc2_ == null)
         {
            return;
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_APP_BY_DES,_loc2_,this);
      }
      
      public function openASWindow(param1:String, param2:String, param3:Boolean = false, param4:Point = null, param5:Function = null, param6:Object = null, param7:Boolean = true, param8:Boolean = false, param9:Object = null) : Boolean
      {
         var _loc10_:OpenAsWinDes;
         (_loc10_ = new OpenAsWinDes()).src = param1;
         _loc10_.name = param2;
         _loc10_.isModal = param3;
         _loc10_.winPos = param4;
         _loc10_.created = param5;
         _loc10_.params = param6;
         _loc10_.cache = param8;
         _loc10_.xmlScriptParams = param9;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_APP_BY_DES,_loc10_,this);
         _loc10_.dispose();
         _loc10_ = null;
         return this.m_recent;
      }
      
      private function _openASWindow(param1:String, param2:String, param3:Boolean = false, param4:Point = null, param5:Function = null, param6:Object = null, param7:Boolean = true, param8:Boolean = false, param9:Object = null) : Boolean
      {
         var _loc11_:ApplicationDomain = null;
         var _loc12_:Class = null;
         var _loc13_:* = undefined;
         if(this.openAsWinParam != null)
         {
            return false;
         }
         this.openAsWinParam = {
            "pos":param4,
            "isModal":param3,
            "created":param5,
            "params":param6,
            "managed":param7,
            "cache":param8,
            "xmlScriptParams":param9
         };
         if(param1 == "")
         {
            if((_loc11_ = ApplicationDomain.currentDomain).hasDefinition(param2))
            {
               _loc12_ = _loc11_.getDefinition(param2) as Class;
               this.onWCLoaded(null,new _loc12_());
               return true;
            }
            return false;
         }
         if(param1.indexOf("https://") == -1 && param1.indexOf("http://") == -1)
         {
            param1 += ".swf";
            param1 = this.mapAbsPath(param1);
         }
         param1 = DEFINE.addVersion(param1);
         this.openAsWinParam.source = param1;
         var _loc10_:IWindow;
         if((_loc10_ = this.asWinsCache[param1]) != null)
         {
            this.openAsWinParam = null;
            _loc10_.show();
            _loc10_.bringToFront();
            if((_loc13_ = _loc10_.getContent()) is IParamsAware)
            {
               (_loc13_ as IParamsAware).setParams(param6);
            }
            if(_loc13_ is IXMLScriptParamsAware)
            {
               (_loc13_ as IXMLScriptParamsAware).setScriptParams(param9);
            }
            if(_loc13_ is IAngelApp)
            {
               (_loc13_ as IAngelApp).activate();
            }
            return true;
         }
         this.winResInfo.contents[0] = param1;
         this.winResInfo.label = param2;
         if(this.angelSysApi.getResSysAPI().getResAdapter(Constants.SYS_RES).requestRes(this.winResInfo))
         {
            return true;
         }
         this.winResInfo.contents[0] = "";
         return false;
      }
      
      public function openHTMLWindow(param1:String, param2:String) : Object
      {
         this.hostKey = this.getFlashVar("hostKey") + "";
         this.clientKey = this.getFlashVar("clientKey") + "";
         if(this.hostKey == "null")
         {
            this.hostKey = "host_" + new Date().time;
         }
         if(this.clientKey == "null")
         {
            this.clientKey = "client_" + new Date().time;
         }
         var _loc3_:HTMLWindow = new HTMLWindow(this.hostKey,this.clientKey,param1,param2);
         _loc3_.open();
         return _loc3_;
      }
      
      public function openHTMLJSWindow(param1:String, param2:String) : Object
      {
         this.hostKey = this.getFlashVar("hostKey") + "";
         this.clientKey = this.getFlashVar("clientKey") + "";
         if(this.hostKey == "null")
         {
            this.hostKey = "host_" + new Date().time;
         }
         if(this.clientKey == "null")
         {
            this.clientKey = "client_" + new Date().time;
         }
         var _loc3_:HTMLJSWindow = new HTMLJSWindow(this.hostKey,this.clientKey,param1,param2);
         _loc3_.open();
         return _loc3_;
      }
      
      public function mapAbsPath(param1:String) : String
      {
         if(param1.indexOf("pluginApp://") == 0)
         {
            return param1.replace("pluginApp://",DEFINE.PLUGIN_ROOT);
         }
         if(param1.indexOf("activityApp://") == 0)
         {
            return param1.replace("activityApp://",DEFINE.COMM_ROOT + "activity/");
         }
         if(param1.indexOf("sceneApp://") == 0)
         {
            return param1.replace("sceneApp://",DEFINE.COMM_ROOT + "res/scene/");
         }
         return DEFINE.COMM_ROOT + "apps/" + param1;
      }
      
      public function getHTMLVars() : Object
      {
         var _loc5_:String = null;
         var _loc6_:Array = null;
         if(!ExternalInterface.available)
         {
            return {};
         }
         var _loc1_:String = ExternalInterface.call("document.location.toString");
         if(_loc1_.indexOf("?") == -1)
         {
            return {};
         }
         var _loc2_:Array = _loc1_.split("?")[1].split("&");
         var _loc3_:Object = {};
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc6_ = (_loc5_ = _loc2_[_loc4_]).split("=");
            _loc3_[_loc6_[0]] = _loc6_[1];
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function getFlashVar(param1:String) : Object
      {
         if(this.myRoot == null || this.myRoot.loaderInfo == null || this.myRoot.loaderInfo.parameters == null)
         {
            return null;
         }
         return this.myRoot.loaderInfo.parameters[param1];
      }
      
      public function reflashHTML() : void
      {
         if(ExternalInterface.available)
         {
            ExternalInterface.call("reflashHTML");
         }
      }
      
      public function setFrameRate(param1:int = -1) : void
      {
         if(param1 <= 0)
         {
            this.myRoot.stage.frameRate = this.defaultRate;
         }
         else
         {
            this.myRoot.stage.frameRate = param1;
         }
      }
      
      public function ccGC(param1:int = 0) : void
      {
         if(param1 <= 0)
         {
            this.gcNow();
         }
         else
         {
            if(this.gcDelayID != -1)
            {
               clearTimeout(this.gcDelayID);
            }
            this.gcDelayID = setTimeout(this.gcNow,param1);
         }
      }
      
      protected function gcNow() : void
      {
         if(this.myRoot != null)
         {
            this.myRoot.stage.focus = this.myRoot.stage;
         }
         if(this.gcDelayID != -1)
         {
            clearTimeout(this.gcDelayID);
         }
         this.gcDelayID = -1;
         try
         {
            new LocalConnection().connect("angel.QQ.com");
            new LocalConnection().connect("angel.QQ.com");
         }
         catch(error:Error)
         {
         }
      }
   }
}
