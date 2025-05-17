package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.net.HttpRequest;
   import com.QQ.angel.net.IHttpProxy;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class AngelHttpProxy extends EventDispatcher implements IHttpProxy
   {
      
      private static var __id:int = 0;
      
      protected var urlloader:URLLoader;
      
      protected var requests:Array;
      
      protected var currRequest:HttpRequest;
      
      public function AngelHttpProxy()
      {
         super();
         this.requests = [];
         this.urlloader = new URLLoader();
         this.urlloader.addEventListener(IOErrorEvent.IO_ERROR,this.onHttpIOError);
         this.urlloader.addEventListener(Event.COMPLETE,this.onHttpComplete);
      }
      
      protected function onHttpIOError(param1:IOErrorEvent) : void
      {
         trace("[AngelHttpProxy] 错误HTTP反馈:" + this.urlloader.data);
         this.currRequest = null;
         this.nextRequest();
      }
      
      protected function onHttpComplete(param1:Event) : void
      {
         trace("[AngelHttpProxy] 成功HTTP反馈:" + this.urlloader.data);
         this.currRequest.callBack.call(0,this.urlloader.data);
         this.currRequest = null;
         this.nextRequest();
      }
      
      protected function nextRequest() : void
      {
         var _loc2_:URLVariables = null;
         var _loc3_:String = null;
         if(this.currRequest != null)
         {
            return;
         }
         if(this.requests.length == 0)
         {
            return;
         }
         this.currRequest = this.requests.shift() as HttpRequest;
         trace("[AngelHttpProxy] 准备发送一个HTTP请求 url:" + this.currRequest.url + "\nmethod:" + this.currRequest.method);
         var _loc1_:URLRequest = new URLRequest(this.currRequest.url);
         _loc1_.method = this.currRequest.method;
         if(this.currRequest.data != null)
         {
            _loc2_ = new URLVariables();
            for(_loc3_ in this.currRequest.data)
            {
               _loc2_[_loc3_] = this.currRequest.data[_loc3_];
               trace("[AngelHttpProxy] 提交数据 key:" + _loc3_ + ",data:" + _loc2_[_loc3_]);
            }
            _loc1_.data = _loc2_;
         }
         this.urlloader.load(_loc1_);
         trace("[AngelHttpProxy] 发送成功");
      }
      
      public function sendHttpRequest(param1:HttpRequest) : String
      {
         ++__id;
         param1.id = __id;
         this.requests.push(param1);
         this.nextRequest();
         return __id + "";
      }
      
      public function cancelHttpRequest(param1:String) : Boolean
      {
         return false;
      }
      
      public function dispose() : void
      {
      }
   }
}

