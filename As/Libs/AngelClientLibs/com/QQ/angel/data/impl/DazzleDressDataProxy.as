package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.DazzleDressDataDes;
   import com.QQ.angel.data.entity.DazzleDressSuitDataDes;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class DazzleDressDataProxy implements IDataProxy
   {
       
      
      private var _initialized:Boolean = false;
      
      private var _items:Dictionary;
      
      private var _itemNum:int;
      
      private var _suits:Dictionary;
      
      private var _suitProxy:DazzleDressSuitDataProxy;
      
      public function DazzleDressDataProxy(param1:DazzleDressSuitDataProxy, param2:Object = null)
      {
         super();
         var _loc3_:int = getTimer();
         this._suitProxy = param1;
         this.processXML(param2);
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
         if(rest[0] is Number)
         {
            return this._items[rest[0]];
         }
         if(Boolean(rest[0].hasOwnProperty("suit")) && rest[0].suit != null)
         {
            return this._suits[rest[0].suit];
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
         return Constants.DAZZLE_DRESS_DATA;
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc3_:DazzleDressDataDes = null;
         var _loc7_:XML = null;
         var _loc8_:uint = 0;
         var _loc10_:DazzleDressSuitDataDes = null;
         if(param1 == null)
         {
            return;
         }
         this._items = new Dictionary();
         this._itemNum = 0;
         this._suits = new Dictionary();
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc4_:XMLList;
         var _loc5_:int = (_loc4_ = _loc2_.item).length();
         var _loc6_:String = DEFINE.DAZZLE_DRESS_RES_ROOT;
         var _loc9_:int = 0;
         while(_loc9_ < _loc5_)
         {
            _loc3_ = new DazzleDressDataDes();
            _loc7_ = _loc4_[_loc9_];
            _loc3_.id = _loc8_ = uint(_loc7_.id[0]);
            _loc3_.name = String(_loc7_.name[0]);
            _loc3_.type = int(_loc7_.type[0]);
            _loc3_.score = int(_loc7_.score[0]);
            _loc3_.recoverprice = int(_loc7_.recover[0]);
            _loc3_.recoverable = _loc3_.recoverprice > 0;
            _loc3_.description = String(_loc7_.des[0]);
            _loc3_.prices = [int(_loc7_.cost7[0]),int(_loc7_.cost30[0]),int(_loc7_.costforever[0])];
            _loc3_.isset = int(_loc7_.isset[0]);
            _loc3_.isvip = String(_loc7_.isvip[0]) == "1";
            _loc3_.outtime = Number(_loc7_.outtime[0]);
            _loc3_.intime = Number(_loc7_.intime[0]);
            _loc3_.url = _loc6_ + _loc3_.type + "/" + _loc8_ + "_bag.png";
            if(_loc3_.isset > 0)
            {
               if((_loc10_ = this._suitProxy.select(_loc3_.isset) as DazzleDressSuitDataDes) != null)
               {
                  _loc10_.daAvatar[_loc3_.type] = _loc3_.id;
               }
            }
            this._items[_loc3_.id] = _loc3_;
            ++this._itemNum;
            if(_loc3_.isset > 0)
            {
               if(this._suits[_loc3_.isset] == null)
               {
                  this._suits[_loc3_.isset] = [];
               }
               this._suits[_loc3_.isset].push(_loc3_);
            }
            _loc9_++;
         }
         this._initialized = true;
      }
   }
}
