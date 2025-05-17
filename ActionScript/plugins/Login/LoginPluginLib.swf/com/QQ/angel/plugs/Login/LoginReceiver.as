package com.QQ.angel.plugs.Login
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.plugs.Login.ui2.AngelLoginUI2;
   import com.QQ.angel.plugs.Login.view.LoadingBar;
   
   public class LoginReceiver extends AbstractDataReceiver
   {
      
      private var fun:Function;
      
      private var _view:AngelLoginUI2;
      
      private var loadingBar:LoadingBar;
      
      private var commUIMgr:ICommUIManager;
      
      public function LoginReceiver(param1:IAngelSysAPI = null)
      {
         super();
         init(param1);
      }
      
      override public function finalize() : void
      {
         if(_view)
         {
            _view.setWaiting(false);
         }
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         if(_view)
         {
            _view.setWaiting(false);
         }
         fun(param1,param2);
      }
      
      public function sendData(param1:int, param2:int, param3:Object) : void
      {
         if(_view)
         {
            _view.setWaiting(true);
         }
         this.sendevent.tcpID = param1;
         sendDataToServer(param2,param3);
      }
      
      override public function catchTrySendDataError(param1:int, param2:int, param3:Object) : void
      {
         if(_view)
         {
            _view.setWaiting(false);
            _view.setErroMsg(true);
         }
      }
      
      private function init(param1:IAngelSysAPI) : void
      {
         commUIMgr = param1.getUISysAPI().commUIManager;
      }
      
      public function setLoading(param1:AngelLoginUI2) : void
      {
         _view = param1;
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_LoginRoom,ADFCmdsType.T_DIR_RANGE_REPLY,ADFCmdsType.T_DIR_RECOMMEND_REPLY,ADFCmdsType.T_DIR_FAST_GETIN,ADFCmdsType.T_DIR_INITIAL_COMPONENT,ADFCmdsType.T_ROOM_INITIAL_COMPONENT];
      }
      
      public function set handle(param1:Function) : void
      {
         fun = param1;
      }
   }
}

