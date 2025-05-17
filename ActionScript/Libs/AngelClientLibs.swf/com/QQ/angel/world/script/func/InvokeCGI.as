package com.QQ.angel.world.script.func
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.script.IInvokeFunc;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class InvokeCGI implements IInvokeFunc
   {
      
      protected var handler:Function;
      
      protected var urlLoader:URLLoader;
      
      protected var global:Object;
      
      private var xmlRelation:String = "";
      
      public function InvokeCGI()
      {
         super();
      }
      
      protected function createLoader() : URLLoader
      {
         if(this.urlLoader == null)
         {
            this.urlLoader = __global.SysAPI.getNetSysAPI().createURLLoader(true);
            this.urlLoader.addEventListener(Event.COMPLETE,this.onCGILoaded);
            this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onCGILoadError);
         }
         return this.urlLoader;
      }
      
      protected function onCGILoadError(param1:IOErrorEvent) : void
      {
         __global.UI.closeMiniLoading();
         this.global["msg"] = param1.text;
         this.handler(-1);
      }
      
      protected function onCGILoaded(param1:Event) : void
      {
         __global.UI.closeMiniLoading();
         var _loc2_:XML = new XML(this.urlLoader.data);
         var _loc3_:* = _loc2_.result;
         if(_loc3_ == undefined)
         {
            _loc3_ = _loc2_.Result;
         }
         this.global["msg"] = String(_loc3_[0].msg[0]);
         if(this.xmlRelation == "" || int(_loc3_[0].@value) < 0)
         {
            this.handler(int(_loc3_[0].@value));
         }
         else
         {
            this.handler(this.parseXmlRelation(_loc2_,this.xmlRelation));
         }
      }
      
      private function parseXmlRelation(param1:XML, param2:String) : int
      {
         var _loc4_:Array = null;
         var _loc3_:Array = param2.split(".");
         var _loc5_:XML = param1;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc3_.length)
         {
            if(_loc6_ < _loc3_.length - 1)
            {
               _loc4_ = _loc3_[_loc6_].split("_");
               _loc5_ = _loc5_[String(_loc4_[0])][int(_loc4_[1])];
            }
            else if(_loc6_ == _loc3_.length - 1)
            {
               return int(_loc5_[String(_loc3_[_loc6_])]);
            }
            _loc6_++;
         }
         return -1;
      }
      
      public function setGlobal(param1:Object) : void
      {
         this.global = param1;
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         this.handler = param2;
         var _loc3_:Array = param1.split("|");
         if(_loc3_.length == 1)
         {
            this.createLoader().load(new URLRequest(DEFINE.CGI_ROOT + param1));
         }
         else if(_loc3_.length == 2)
         {
            this.xmlRelation = _loc3_[1];
            this.createLoader().load(new URLRequest(DEFINE.CGI_ROOT + _loc3_[0]));
         }
         __global.UI.createMiniLoading();
      }
      
      public function dispose() : void
      {
         if(this.urlLoader != null)
         {
            this.urlLoader.removeEventListener(Event.COMPLETE,this.onCGILoaded);
            this.urlLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.onCGILoadError);
            this.urlLoader = null;
         }
         this.handler = null;
         this.xmlRelation = "";
      }
   }
}

