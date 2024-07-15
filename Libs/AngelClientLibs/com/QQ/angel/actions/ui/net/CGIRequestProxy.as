package com.QQ.angel.actions.ui.net
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.common.__global;
   import flash.events.Event;
   
   public class CGIRequestProxy
   {
       
      
      protected var _cgiLoader:CGILoader;
      
      public function CGIRequestProxy()
      {
         super();
      }
      
      public function cgiSendData(param1:String, param2:Function, param3:Object = null, param4:Boolean = true) : void
      {
         if(this._cgiLoader == null)
         {
            this._cgiLoader = new CGILoader(DEFINE.CGI_ROOT,__global.SysAPI.getNetSysAPI().createURLLoader(true));
         }
         this._cgiLoader.addEventListener(Event.COMPLETE,param2);
         this._cgiLoader.addEventListener(CGIEvent.GOT_ERROR,param2);
         this.setWaiting(true);
         this._cgiLoader.sendData(param1,param3);
      }
      
      public function cgiError(param1:CGIEvent) : Boolean
      {
         this.setWaiting(false);
         if(param1.type == CGIEvent.GOT_ERROR)
         {
            this.alert(param1.msg);
            return true;
         }
         return false;
      }
      
      public function cleanCgiLoader(param1:Function) : void
      {
         if(this._cgiLoader)
         {
            this._cgiLoader.removeEventListener(Event.COMPLETE,param1);
            this._cgiLoader.removeEventListener(CGIEvent.GOT_ERROR,param1);
         }
      }
      
      public function setWaiting(param1:Boolean) : void
      {
         var _loc2_:ICommUIManager = __global.SysAPI.getUISysAPI().commUIManager;
         if(param1)
         {
            _loc2_.createMiniLoading();
         }
         else
         {
            _loc2_.closeMiniLoading();
         }
      }
      
      public function alert(param1:String) : void
      {
         var _loc2_:ICommUIManager = __global.SysAPI.getUISysAPI().commUIManager;
         _loc2_.alert("",param1);
      }
      
      public function dispose() : void
      {
         if(this._cgiLoader)
         {
            this._cgiLoader.dispose();
         }
         this._cgiLoader = null;
      }
   }
}
