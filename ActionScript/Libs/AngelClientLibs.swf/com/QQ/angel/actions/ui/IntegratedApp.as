package com.QQ.angel.actions.ui
{
   import com.QQ.angel.actions.ui.net.CGIEvent;
   import com.QQ.angel.actions.ui.net.CGILoader;
   import com.QQ.angel.actions.ui.net.CGILoader02;
   import com.QQ.angel.actions.ui.net.ReqChangeBody;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelApp;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IParamsAware;
   import com.QQ.angel.api.IXMLScriptParamsAware;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.ui.core.IScaleWindowContent;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class IntegratedApp extends Sprite implements IAngelApp, IScaleWindowContent, IParamsAware, IXMLScriptParamsAware
   {
      
      private var _closeHandler:Function;
      
      private var _cgiCallhandler:Object;
      
      private var _changeBodyhandler:Function;
      
      private var _cgiLoader:CGILoader;
      
      protected var _scriptParam:*;
      
      protected var angelSysAPI:IAngelSysAPI;
      
      protected var _cur_cgi_root:String = DEFINE.CGI_ROOT;
      
      public function IntegratedApp()
      {
         super();
      }
      
      public static function getLoader(param1:String = "") : CGILoader02
      {
         if(param1 == "")
         {
            return new CGILoader02(DEFINE.CGI_ROOT,__global.SysAPI.getNetSysAPI().createURLLoader(true));
         }
         return new CGILoader02(param1,__global.SysAPI.getNetSysAPI().createURLLoader(true));
      }
      
      protected function init() : void
      {
      }
      
      public function dispose() : void
      {
         if(this._cgiLoader != null)
         {
            this._cgiLoader.removeEventListener(Event.COMPLETE,this.cgiCallback);
            this._cgiLoader.removeEventListener(CGIEvent.GOT_ERROR,this.cgiCallback);
            this._cgiLoader = null;
         }
      }
      
      protected function cgiSendData(param1:String, param2:Object = null) : void
      {
         if(this._cgiLoader == null)
         {
            this._cgiLoader = new CGILoader(this._cur_cgi_root,this.angelSysAPI.getNetSysAPI().createURLLoader(true));
            this._cgiLoader.addEventListener(Event.COMPLETE,this.cgiCallback);
            this._cgiLoader.addEventListener(CGIEvent.GOT_ERROR,this.cgiCallback);
         }
         this.setWaiting(true);
         this._cgiLoader.sendData(param1,param2);
      }
      
      protected function cgiCallback(param1:CGIEvent) : void
      {
         this.setWaiting(false);
         if(param1.type == CGIEvent.GOT_ERROR)
         {
            this.alert(param1.msg);
            return;
         }
      }
      
      protected function gameOver(param1:int) : void
      {
         if(this._cgiCallhandler != null)
         {
            this._cgiCallhandler(param1);
         }
         if(this._closeHandler != null)
         {
            this._closeHandler(new MouseEvent(MouseEvent.MOUSE_DOWN));
         }
      }
      
      protected function showItemAwards(param1:Array, param2:CFunction = null) : void
      {
         if(param1 != null)
         {
            new ShowItemAwards(param1,param2);
         }
      }
      
      protected function changeBody(param1:int, param2:int, param3:Function) : void
      {
         this._changeBodyhandler = param3;
         var _loc4_:ReqChangeBody = new ReqChangeBody(param1);
         _loc4_.type = param2;
         var _loc5_:P_FreeRequest = new P_FreeRequest(196649,_loc4_,ReqChangeBody,this.onDataReceive);
         _loc5_.send();
      }
      
      protected function onDataReceive(param1:ReqChangeBody) : void
      {
         if(param1.code.isError())
         {
            this._changeBodyhandler({
               "result":-1,
               "code":param1.code.code,
               "msg":"变皮肤操作失败!"
            });
            return;
         }
         var _loc2_:RoleData = this.angelSysAPI.getGDataAPI().getGlobalVal(Constants.MAIN_ROLE_INFO) as RoleData;
         var _loc3_:AvatarRequest = new AvatarRequest(_loc2_.uin,param1.version,0,new CFunction(this.onAvatarLoaded,this));
         _loc3_.avatarURL = _loc2_.avatarURL;
         var _loc4_:IResAdapter = this.angelSysAPI.getResSysAPI().getResAdapter(Constants.AVATAR_RES);
         _loc4_.requestRes(_loc3_);
      }
      
      protected function onAvatarLoaded(param1:*) : void
      {
         if(param1 != null)
         {
            this._changeBodyhandler({
               "result":0,
               "msg":"变皮肤成功!"
            });
         }
         else
         {
            this._changeBodyhandler({
               "result":-1,
               "msg":"变皮肤资源加载失败!"
            });
         }
      }
      
      protected function alert(param1:String) : void
      {
         var _loc2_:ICommUIManager = this.angelSysAPI.getUISysAPI().commUIManager;
         _loc2_.alert("",param1);
      }
      
      protected function setWaiting(param1:Boolean) : void
      {
         var _loc2_:ICommUIManager = this.angelSysAPI.getUISysAPI().commUIManager;
         if(param1)
         {
            _loc2_.createMiniLoading();
         }
         else
         {
            _loc2_.closeMiniLoading();
         }
      }
      
      protected function openApp(param1:String, param2:Boolean = true, param3:Function = null) : void
      {
         var _loc4_:Object = {};
         _loc4_.id = param1;
         _loc4_.name = "";
         _loc4_.isModal = param2;
         _loc4_.pos = new Point(0,0);
         _loc4_.params = param3;
         _loc4_.cache = false;
         __global.openAsWin(null,_loc4_);
      }
      
      public function setParams(param1:*) : void
      {
         this._cgiCallhandler = param1 as Function;
      }
      
      public function setScriptParams(param1:*) : void
      {
         this._scriptParam = param1;
      }
      
      public function setup() : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function inactivate() : void
      {
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.angelSysAPI = param1;
         this.init();
      }
      
      public function getDisplay() : DisplayObject
      {
         return this;
      }
      
      public function getBGRect() : Point
      {
         return null;
      }
      
      public function getCloseBtnPos() : Point
      {
         return null;
      }
      
      public function addCloseHandler(param1:Function) : void
      {
         this._closeHandler = param1;
      }
      
      public function getDragArea() : InteractiveObject
      {
         return null;
      }
   }
}

