package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.IAngelItemDataProxy;
   import com.QQ.angel.data.entity.ItemDataDes;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AngelItemDataProxy implements IAngelItemDataProxy
   {
       
      
      private var _initialized:Boolean;
      
      private var _items:Dictionary;
      
      private var _itemNum:int;
      
      public function AngelItemDataProxy(param1:Object = null)
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
         return this.selectItem(rest[0]);
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
         this._items = null;
         this._itemNum = 0;
      }
      
      public function getName() : String
      {
         return Constants.ITEM_DATA;
      }
      
      public function get itemLength() : int
      {
         return this._itemNum;
      }
      
      public function selectItem(param1:int) : ItemDataDes
      {
         if(!this._initialized)
         {
            return null;
         }
         return this._items[param1];
      }
      
      public function selectItems(param1:int = 0, param2:int = 0) : Array
      {
         var _loc4_:ItemDataDes = null;
         if(!this._initialized)
         {
            return [];
         }
         var _loc3_:Array = [];
         if(param1 == 0 && param2 == 0)
         {
            for each(_loc4_ in this._items)
            {
               _loc3_.push(_loc4_);
            }
         }
         else if(param1 > 0)
         {
            if(param2 > 0)
            {
               for each(_loc4_ in this._items)
               {
                  if(DEFINE.getItemType(_loc4_.id) == param1 && DEFINE.getItemType(_loc4_.id,1) == param2)
                  {
                     _loc3_.push(_loc4_);
                  }
               }
            }
            else
            {
               for each(_loc4_ in this._items)
               {
                  if(DEFINE.getItemType(_loc4_.id) == param1)
                  {
                     _loc3_.push(_loc4_);
                  }
               }
            }
         }
         return _loc3_;
      }
      
      public function selectItemsByID(param1:Array) : Array
      {
         var _loc3_:ItemDataDes = null;
         if(!this._initialized)
         {
            return [];
         }
         var _loc2_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = this._items[param1[_loc5_]];
            if(_loc3_ != null)
            {
               _loc2_.push(_loc3_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc3_:ItemDataDes = null;
         var _loc7_:XML = null;
         var _loc8_:uint = 0;
         if(param1 == null)
         {
            return;
         }
         this._items = new Dictionary();
         this._itemNum = 0;
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc4_:XMLList;
         var _loc5_:int = (_loc4_ = _loc2_.Items[0].Item).length();
         var _loc6_:String = DEFINE.ITEM_RES_ROOT;
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_)
         {
            _loc3_ = new ItemDataDes();
            _loc7_ = _loc4_[_loc9_];
            _loc3_.id = _loc8_ = uint(_loc7_.ID[0]);
            _loc3_.name = String(_loc7_.Name[0]);
            _loc3_.description = String(_loc7_.Desc[0]);
            _loc3_.unique = String(_loc7_.Unique[0]) == "1";
            _loc3_.type = DEFINE.getItemType(_loc8_);
            _loc3_.subtype = DEFINE.getItemType(_loc8_,1);
            _loc3_.url = _loc6_ + _loc8_ + ".png";
            _loc3_.price = int(_loc7_.Price[0]);
            _loc3_.expireTime = int(_loc7_.ExpireTime[0]);
            this._items[_loc3_.id] = _loc3_;
            ++this._itemNum;
            _loc9_++;
         }
         this._initialized = true;
      }
   }
}
