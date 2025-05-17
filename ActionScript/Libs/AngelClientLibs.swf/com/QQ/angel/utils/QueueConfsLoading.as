package com.QQ.angel.utils
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.utils.CFunction;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class QueueConfsLoading extends EventDispatcher
   {
      
      protected var urlLoader:URLLoader;
      
      protected var queues:Array;
      
      protected var curr:ConfItem;
      
      protected var callBack:CFunction;
      
      protected var confs:Object;
      
      public function QueueConfsLoading()
      {
         super();
         this.queues = [];
         this.confs = {};
         this.urlLoader = new URLLoader();
         this.urlLoader.addEventListener(Event.COMPLETE,this.onConfStatesHandler);
         this.urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.onConfStatesHandler);
         this.urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
      }
      
      protected function onConfStatesHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc3_:ByteArray = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:ByteArray = null;
         var _loc8_:XML = null;
         var _loc9_:uint = 0;
         if(param1.type == Event.COMPLETE)
         {
            if(!this.curr.compress)
            {
               _loc2_ = String(this.urlLoader.data);
               this.confs[this.curr.id] = _loc2_;
               this.nextLoading();
               return;
            }
            _loc3_ = this.urlLoader.data as ByteArray;
            _loc4_ = uint(_loc3_.readByte());
            _loc5_ = _loc3_.readUnsignedInt();
            _loc6_ = uint(_loc3_.readShort());
            if(_loc5_ != _loc3_.bytesAvailable)
            {
               return;
            }
            _loc7_ = new ByteArray();
            _loc3_.readBytes(_loc7_);
            _loc7_.uncompress();
            _loc9_ = 0;
            while(_loc9_ < _loc6_)
            {
               _loc8_ = _loc7_.readObject();
               _loc2_ = _loc8_.toXMLString();
               this.confs[String(_loc8_.@name)] = _loc2_;
               _loc9_++;
            }
            this.nextLoading();
            return;
         }
         throw new Error(this.curr.id + "," + this.curr.src + "加载配制文件错误!");
      }
      
      protected function nextLoading() : void
      {
         if(this.queues.length == 0)
         {
            if(this.callBack != null)
            {
               this.callBack.call(this.confs);
            }
            this.callBack = null;
            return;
         }
         this.curr = this.queues.pop() as ConfItem;
         this.urlLoader.load(new URLRequest(DEFINE.formatFileVersion(this.curr.src)));
      }
      
      public function addConf(param1:String, param2:String, param3:Boolean) : void
      {
         this.queues.push(new ConfItem(param1,param2,param3));
      }
      
      public function start(param1:CFunction) : void
      {
         if(this.queues.length == 0)
         {
            return;
         }
         this.callBack = param1;
         this.nextLoading();
      }
      
      public function reset() : void
      {
         this.queues = [];
         this.confs = {};
         this.curr = null;
      }
   }
}

class ConfItem
{
   
   public var id:String;
   
   public var src:String;
   
   public var compress:Boolean;
   
   public function ConfItem(param1:String, param2:String, param3:Boolean)
   {
      super();
      this.id = param1;
      this.src = param2;
      this.compress = param3;
   }
}
