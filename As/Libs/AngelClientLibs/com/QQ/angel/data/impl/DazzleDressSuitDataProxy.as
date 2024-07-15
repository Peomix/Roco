package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.DazzleDressSuitDataDes;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class DazzleDressSuitDataProxy implements IDataProxy
   {
       
      
      private var _initialized:Boolean = false;
      
      private var _items:Dictionary;
      
      private var _itemNum:int;
      
      public function DazzleDressSuitDataProxy(param1:Object = null)
      {
         super();
         var _loc2_:int = getTimer();
         this.processXML(param1);
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(!this._initialized)
         {
            return null;
         }
         if(rest[0] == "*")
         {
            return this._items;
         }
         return this._items[rest[0]];
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
         return Constants.DAZZLE_DRESS_DATA_SET;
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc3_:DazzleDressSuitDataDes = null;
         var _loc6_:XML = null;
         if(param1 == null)
         {
            return;
         }
         this._items = new Dictionary();
         this._itemNum = 0;
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc4_:XMLList;
         var _loc5_:int = (_loc4_ = _loc2_.Set).length();
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc3_ = new DazzleDressSuitDataDes();
            _loc6_ = _loc4_[_loc7_];
            _loc3_.id = uint(_loc6_.id[0]);
            _loc3_.name = String(_loc6_.name[0]);
            this._items[_loc3_.id] = _loc3_;
            ++this._itemNum;
            _loc7_++;
         }
         this._initialized = true;
      }
   }
}
