package com.QQ.angel.net.impl
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.IHttpLoader;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.ServerInfo;
   import com.QQ.angel.net.ProtoNet.NetManager;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class AngelURLLoader extends URLLoader implements IHttpLoader
   {
       
      
      protected var serverInfo:ServerInfo;
      
      protected var requestsList:Array;
      
      protected var isLoading:Boolean = false;
      
      protected var noCache:Boolean = false;
      
      protected var isQueue:Boolean = true;
      
      protected var url:String;
      
      public function AngelURLLoader(param1:ServerInfo)
      {
         super();
         this.serverInfo = param1;
         this.requestsList = [];
         addEventListener(Event.COMPLETE,this.onLoadComplete,false,1);
         addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError,false,1);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onSecurityError,false,1);
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         trace("[AngelURLLoader] HTTP请求有安全错误:" + param1.text);
         this.isLoading = false;
         this.nextRequest();
      }
      
      protected function onLoadComplete(param1:Event) : void
      {
         this.isLoading = false;
         this.nextRequest();
      }
      
      protected function onLoadError(param1:IOErrorEvent) : void
      {
         this.isLoading = false;
         this.nextRequest();
      }
      
      protected function nextRequest() : void
      {
         if(NetManager.BeKickedOff)
         {
            return;
         }
         if(this.requestsList.length == 0)
         {
            return;
         }
         var _loc1_:URLRequest = this.requestsList.shift() as URLRequest;
         this.url = _loc1_.url;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_SEND_A_CGI_RAW_DATA,[_loc1_,this],this);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_SEND_A_RAW_DATA,[_loc1_,this],this);
         super.load(_loc1_);
         this.isLoading = true;
      }
      
      override public function load(param1:URLRequest) : void
      {
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc2_:String = param1.url;
         var _loc3_:String = "";
         if(this.serverInfo != null)
         {
            _loc3_ = "angel_uin=" + this.serverInfo.uin + "&angel_key=" + this.serverInfo.sessionKey;
         }
         else
         {
            trace("[AngelURLLoader] serverInfo为空!!");
         }
         if(_loc2_.indexOf("?") != -1)
         {
            _loc2_ += "&" + _loc3_;
         }
         else
         {
            _loc2_ += "?" + _loc3_;
         }
         if(this.noCache)
         {
            _loc2_ += "&time=" + new Date().time;
         }
         var _loc4_:ServerInfo;
         if((Boolean(_loc4_ = this.serverInfo)) && (Boolean(_loc4_.pskey) || Boolean(_loc4_.skey)))
         {
            try
            {
               _loc5_ = _loc2_.substring(_loc2_.lastIndexOf("/") + 1,_loc2_.lastIndexOf("?"));
            }
            catch(e:Error)
            {
            }
            if(_loc5_ == "qgame_gift" || _loc5_ == "invite" || _loc5_ == "homelittlepaper" || _loc5_ == "sendspiritegg" || _loc5_ == "sign2")
            {
               _loc6_ = !!_loc4_.pskey ? _loc4_.pskey : _loc4_.skey;
               _loc7_ = "";
               _loc8_ = 0;
               while(_loc8_ < _loc6_.length)
               {
                  _loc7_ += "%" + _loc6_.charCodeAt(_loc8_).toString(16);
                  _loc8_++;
               }
               _loc2_ += "&unkown=" + _loc7_;
            }
         }
         param1.url = _loc2_;
         this.requestsList.push(param1);
         if(this.isLoading && this.isQueue)
         {
            return;
         }
         this.nextRequest();
      }
      
      public function setNoCache(param1:Boolean) : void
      {
         this.noCache = param1;
      }
      
      public function setTimeOut(param1:int = -1, param2:Boolean = true) : void
      {
      }
      
      public function setIsQueue(param1:Boolean) : void
      {
         this.isQueue = param1;
      }
      
      public function getLatestURL() : String
      {
         return this.url;
      }
      
      public function destroy() : void
      {
         removeEventListener(Event.COMPLETE,this.onLoadComplete);
         removeEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
      }
   }
}
