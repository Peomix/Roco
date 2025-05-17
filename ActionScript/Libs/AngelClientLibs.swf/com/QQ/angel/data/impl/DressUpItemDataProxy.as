package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.DressUpItemDes;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class DressUpItemDataProxy implements IDataProxy
   {
      
      private var dic:Dictionary;
      
      public function DressUpItemDataProxy()
      {
         super();
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.load(new URLRequest(DEFINE.formatFileVersion("http://res.17roco.qq.com/res/ext/dressup/conf/dressup.xml")));
         _loc1_.addEventListener(Event.COMPLETE,this.onComplete);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
      }
      
      private function onComplete(param1:Event) : void
      {
         var _loc3_:DressUpItemDes = null;
         param1.target.removeEventListener(Event.COMPLETE,this.onComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onIOError);
         this.dic = new Dictionary();
         var _loc2_:XML = XML(param1.target.data);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.shop[0].item.length())
         {
            _loc3_ = new DressUpItemDes(_loc2_.shop[0].item[_loc4_]);
            this.dic[_loc3_.id] = _loc3_;
            _loc4_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(rest != null && rest.length == 0)
         {
            return this.dic;
         }
         if(rest != null && rest[0] is int)
         {
            return this.dic[rest[0]];
         }
         return null;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
      }
      
      public function getName() : String
      {
         return Constants.DRESSUP_LIST_DATA;
      }
   }
}

