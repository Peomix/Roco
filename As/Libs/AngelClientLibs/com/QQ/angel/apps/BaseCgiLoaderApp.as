package com.QQ.angel.apps
{
   import com.QQ.angel.actions.ui.net.CGIEvent;
   import com.QQ.angel.actions.ui.net.CGILoader;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.ui.ICommUIManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BaseCgiLoaderApp extends BaseAPP
   {
       
      
      protected var _cgiLoader:CGILoader;
      
      public function BaseCgiLoaderApp()
      {
         super();
      }
      
      protected function cgiSendData(param1:String, param2:Function, param3:Object = null) : void
      {
         if(this._cgiLoader == null)
         {
            this._cgiLoader = new CGILoader(DEFINE.CGI_ROOT,m_sysAPI.getNetSysAPI().createURLLoader(true));
         }
         this._cgiLoader.addEventListener(Event.COMPLETE,param2);
         this._cgiLoader.addEventListener(CGIEvent.GOT_ERROR,param2);
         this.setWaiting(true);
         this._cgiLoader.sendData(param1,param3);
      }
      
      protected function cgiError(param1:CGIEvent) : Boolean
      {
         this.setWaiting(false);
         if(param1.type == CGIEvent.GOT_ERROR)
         {
            this.alert(param1.msg);
            return true;
         }
         return false;
      }
      
      protected function cleanCgiLoader(param1:Function) : void
      {
         this._cgiLoader.removeEventListener(Event.COMPLETE,param1);
         this._cgiLoader.removeEventListener(CGIEvent.GOT_ERROR,param1);
      }
      
      protected function setWaiting(param1:Boolean) : void
      {
         var _loc2_:ICommUIManager = m_sysAPI.getUISysAPI().commUIManager;
         if(param1)
         {
            _loc2_.createMiniLoading();
         }
         else
         {
            _loc2_.closeMiniLoading();
         }
      }
      
      protected function alert(param1:String) : void
      {
         var _loc2_:ICommUIManager = m_sysAPI.getUISysAPI().commUIManager;
         _loc2_.alert("",param1);
      }
      
      public function closeApp(param1:MouseEvent = null) : void
      {
         dispose();
         close();
      }
   }
}
