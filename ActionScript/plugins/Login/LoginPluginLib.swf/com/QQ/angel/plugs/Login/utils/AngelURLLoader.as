package com.QQ.angel.plugs.Login.utils
{
   import com.QQ.angel.api.net.IHttpLoader;
   import com.QQ.angel.data.entity.ServerInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   
   public class AngelURLLoader extends URLLoader implements IHttpLoader
   {
      
      private static var sm_angelHostSwitcherClass:Class;
      
      private static var sm_everGetClass:Boolean;
      
      protected var noCache:Boolean = false;
      
      protected var requestsList:Array;
      
      protected var isQueue:Boolean = true;
      
      protected var serverInfo:ServerInfo;
      
      protected var url:String;
      
      protected var isLoading:Boolean = false;
      
      public function AngelURLLoader(param1:ServerInfo)
      {
         super();
         this.serverInfo = param1;
         this.requestsList = [];
         addEventListener(Event.COMPLETE,onLoadComplete,false,1);
         addEventListener(IOErrorEvent.IO_ERROR,onLoadError,false,1);
         addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError,false,1);
      }
      
      public function setIsQueue(param1:Boolean) : void
      {
         isQueue = param1;
      }
      
      protected function onSecurityError(param1:SecurityErrorEvent) : void
      {
         trace("[AngelURLLoader] HTTP请求有安全错误:" + param1.text);
         isLoading = false;
         nextRequest();
      }
      
      protected function nextRequest() : void
      {
         if(requestsList.length == 0)
         {
            return;
         }
         var _loc1_:URLRequest = requestsList.shift() as URLRequest;
         url = _loc1_.url;
         super.load(_loc1_);
         isLoading = true;
      }
      
      public function setNoCache(param1:Boolean) : void
      {
         this.noCache = param1;
      }
      
      protected function onLoadError(param1:IOErrorEvent) : void
      {
         isLoading = false;
         nextRequest();
      }
      
      override public function load(param1:URLRequest) : void
      {
         var info:ServerInfo;
         var sessionURL:String;
         var newHostUrl:String = null;
         var cgiName:String = null;
         var _key:String = null;
         var unkownStr:String = null;
         var i:int = 0;
         var request:URLRequest = param1;
         var url:String = request.url;
         if(!sm_everGetClass)
         {
            try
            {
               sm_angelHostSwitcherClass = ApplicationDomain.currentDomain.getDefinition("AngelHostSwitcher") as Class;
            }
            catch(e:Error)
            {
            }
            sm_everGetClass = true;
            if(Boolean(sm_angelHostSwitcherClass) && Boolean(sm_angelHostSwitcherClass["switchArray"]))
            {
               newHostUrl = sm_angelHostSwitcherClass["hostSwitch"](url);
               if(newHostUrl != url)
               {
                  trace("WARNING!!!! URL地址写死了" + url + "\n!! 请使用类似 DEFINE.COMM_ROOT 拼接URL地址！！");
                  url = newHostUrl;
                  trace("AngelURLLoader.load 替换URL为 " + newHostUrl);
               }
            }
         }
         sessionURL = "";
         if(serverInfo != null)
         {
            sessionURL = "angel_uin=" + serverInfo.uin + "&angel_key=" + serverInfo.sessionKey;
         }
         else
         {
            trace("[AngelURLLoader] serverInfo为空!!");
         }
         if(url.indexOf("?") != -1)
         {
            url += "&" + sessionURL;
         }
         else
         {
            url += "?" + sessionURL;
         }
         if(noCache)
         {
            url += "&time=" + new Date().time;
         }
         info = serverInfo;
         if(Boolean(info) && (Boolean(info.pskey) || Boolean(info.skey)))
         {
            try
            {
               cgiName = url.substring(url.lastIndexOf("/") + 1,url.lastIndexOf("?"));
            }
            catch(e:Error)
            {
            }
            if(cgiName == "qgame_gift" || cgiName == "invite" || cgiName == "homelittlepaper" || cgiName == "sendspiritegg" || cgiName == "sign2")
            {
               _key = info.pskey ? info.pskey : info.skey;
               unkownStr = "";
               i = 0;
               while(i < _key.length)
               {
                  unkownStr += "%" + _key.charCodeAt(i).toString(16);
                  i++;
               }
               url += "&unkown=" + unkownStr;
            }
         }
         trace("[AngelURLLoader] 请求CGI:" + url);
         request.url = url;
         requestsList.push(request);
         if(isLoading && isQueue)
         {
            return;
         }
         nextRequest();
      }
      
      public function getLatestURL() : String
      {
         return this.url;
      }
      
      public function destroy() : void
      {
         removeEventListener(Event.COMPLETE,onLoadComplete);
         removeEventListener(IOErrorEvent.IO_ERROR,onLoadError);
      }
      
      protected function onLoadComplete(param1:Event) : void
      {
         isLoading = false;
         nextRequest();
      }
      
      public function setTimeOut(param1:int = -1, param2:Boolean = true) : void
      {
      }
   }
}

