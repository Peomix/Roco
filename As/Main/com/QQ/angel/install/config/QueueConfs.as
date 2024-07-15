package com.QQ.angel.install.config
{
   import com.QQ.angel.install.loader.RetryLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class QueueConfs extends EventDispatcher
   {
       
      
      protected var queues:Array;
      
      protected var successHandler:Function;
      
      protected var urlLoader:RetryLoader;
      
      protected var confs:Object;
      
      protected var errorHandler:Function;
      
      protected var curr:ConfItem;
      
      public function QueueConfs()
      {
         super();
         queues = [];
         confs = {};
         urlLoader = new RetryLoader(true);
         urlLoader.addEventListener(Event.COMPLETE,onConfStatesHandler);
         urlLoader.addEventListener(IOErrorEvent.IO_ERROR,onConfStatesHandler);
      }
      
      protected function onConfStatesHandler(param1:Event) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:ByteArray = null;
         var _loc8_:XML = null;
         var _loc9_:uint = 0;
         if(param1.type == Event.COMPLETE)
         {
            _loc2_ = urlLoader.bytes;
            if(!curr.compress)
            {
               _loc3_ = _loc2_.readUTFBytes(_loc2_.bytesAvailable);
               confs[curr.id] = _loc3_;
            }
            else
            {
               _loc4_ = uint(_loc2_.readByte());
               _loc5_ = _loc2_.readUnsignedInt();
               _loc6_ = uint(_loc2_.readShort());
               if(_loc5_ != _loc2_.bytesAvailable)
               {
                  urlLoader.tryReload();
                  return;
               }
               _loc7_ = new ByteArray();
               _loc2_.readBytes(_loc7_);
               _loc7_.uncompress();
               _loc9_ = 0;
               while(_loc9_ < _loc6_)
               {
                  _loc8_ = _loc7_.readObject();
                  confs[_loc8_.@name + ""] = _loc8_;
                  _loc9_++;
               }
            }
            trace("[QueueConfs]",curr.id,"加载完毕");
            nextLoading();
            return;
         }
         if(this.errorHandler != null)
         {
            this.errorHandler(curr.id + "," + curr.src + "加载配制文件错误!");
         }
      }
      
      public function addConf(param1:String, param2:String, param3:Boolean) : void
      {
         queues.push(new ConfItem(param1,param2,param3));
      }
      
      protected function nextLoading() : void
      {
         if(queues.length == 0)
         {
            if(successHandler != null)
            {
               successHandler(confs);
            }
            successHandler = null;
            return;
         }
         curr = queues.pop() as ConfItem;
         urlLoader.load(new URLRequest(curr.src));
      }
      
      public function reset() : void
      {
         queues = [];
         confs = {};
         curr = null;
      }
      
      public function start(param1:Function, param2:Function) : void
      {
         if(queues.length == 0)
         {
            return;
         }
         this.successHandler = param1;
         this.errorHandler = param2;
         nextLoading();
      }
   }
}

class ConfItem
{
    
   
   public var compress:Boolean = false;
   
   public var src:String;
   
   public var id:String;
   
   public function ConfItem(param1:String, param2:String, param3:Boolean)
   {
      super();
      this.id = param1;
      this.src = param2;
      this.compress = param3;
   }
}
