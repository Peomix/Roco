package com.QQ.angel.net.center
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.IHttpLoader;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.protocolBase.I_C2S_CGI;
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class FreeCGIRequestProxy
   {
       
      
      private var m_protocolHash:Object;
      
      private var m_callbackFunc:Function;
      
      private var m_outputBuffer:String;
      
      private var m_inputBuffer:XML;
      
      private var m_urlL:URLLoader;
      
      public function FreeCGIRequestProxy(param1:I_C2S_CGI, param2:Object, param3:Function)
      {
         super();
         this.m_callbackFunc = param3;
         this.m_protocolHash = param2;
         this.m_outputBuffer = param1.encodeCGI();
      }
      
      public function get protocolHash() : String
      {
         return String(this.m_protocolHash);
      }
      
      private function onReqReplyLocal() : void
      {
         var _loc1_:Class = null;
         var _loc2_:ProtocolBase = null;
         if(this.m_inputBuffer)
         {
            if(this.m_callbackFunc != null && this.m_protocolHash != null)
            {
               _loc1_ = NetProtocalCenter.getS2CProtocalClassByHash(this.m_protocolHash);
               if(_loc1_)
               {
                  _loc2_ = new _loc1_() as ProtocolBase;
                  if(_loc2_ is I_S2C_CGI)
                  {
                     I_S2C_CGI(_loc2_).decodeCGI(this.m_inputBuffer);
                     this.m_callbackFunc(_loc2_);
                  }
               }
            }
            this.m_callbackFunc = null;
            this.m_inputBuffer = null;
         }
         this.m_protocolHash = null;
         this.requestClose();
      }
      
      public function send() : void
      {
         if(this.m_urlL == null)
         {
            this.m_urlL = __global.SysAPI.getNetSysAPI().createURLLoader(true);
            (this.m_urlL as IHttpLoader).setIsQueue(false);
         }
         if(this.m_outputBuffer)
         {
            this.request(this.m_outputBuffer);
            this.m_outputBuffer = null;
         }
      }
      
      private function request(param1:String) : void
      {
         this.requestClose();
         this.m_urlL.addEventListener(Event.COMPLETE,this.requestCompleteHandler);
         this.m_urlL.addEventListener(IOErrorEvent.IO_ERROR,this.requestCompleteHandler);
         this.m_urlL.load(new URLRequest(param1));
      }
      
      public function requestClose() : void
      {
         if(this.m_urlL)
         {
            if(this.m_urlL.hasEventListener(Event.COMPLETE))
            {
               this.m_urlL.removeEventListener(Event.COMPLETE,this.requestCompleteHandler);
               this.m_urlL.removeEventListener(IOErrorEvent.IO_ERROR,this.requestCompleteHandler);
            }
            try
            {
               this.m_urlL.close();
            }
            catch(e:Error)
            {
            }
         }
      }
      
      private function dispose() : void
      {
         this.m_inputBuffer = null;
         this.m_outputBuffer = null;
         this.m_protocolHash = null;
         this.m_callbackFunc = null;
         this.requestClose();
      }
      
      private function requestCompleteHandler(param1:Event) : void
      {
         if(this.m_urlL.hasEventListener(Event.COMPLETE))
         {
            this.m_urlL.removeEventListener(Event.COMPLETE,this.requestCompleteHandler);
            this.m_urlL.removeEventListener(IOErrorEvent.IO_ERROR,this.requestCompleteHandler);
         }
         if(param1.type != Event.COMPLETE)
         {
            this.dispose();
            return;
         }
         this.m_inputBuffer = new XML(String(this.m_urlL.data));
         if(this.m_inputBuffer)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_CGI_RAW_DATA,[this.m_inputBuffer,this.m_protocolHash],this);
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_RAW_DATA,[this.m_inputBuffer,this.m_protocolHash],this);
            this.onReqReplyLocal();
         }
         else
         {
            this.dispose();
         }
      }
   }
}
