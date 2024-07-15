package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.combatsys.SpiritEquipmentInfo;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SpiritEquipInfoProxy implements IDataProxy
   {
       
      
      protected var db:Dictionary;
      
      protected var listdb:Array;
      
      public function SpiritEquipInfoProxy(param1:uint, param2:ByteArray)
      {
         super();
         var _loc3_:int = getTimer();
         this.db = new Dictionary();
         this.listdb = [];
         if(param1 == 0)
         {
            return;
         }
         this.processBytesArray(param1,param2);
      }
      
      protected function processBytesArray(param1:uint, param2:ByteArray) : void
      {
         var _loc3_:SpiritEquipmentInfo = null;
         var _loc4_:uint = 0;
         var _loc5_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SEQUIP_DES_DATA);
         var _loc6_:int = 0;
         while(_loc6_ < param1)
         {
            _loc3_ = new SpiritEquipmentInfo();
            _loc4_ = uint(_loc3_.serverID = param2.readInt());
            _loc3_.catchTime = param2.readUnsignedInt();
            _loc3_.baseAttr = param2.readUnsignedByte();
            _loc3_.baseValue = param2.readUnsignedByte();
            _loc3_.specialAttr = param2.readUnsignedByte();
            _loc3_.specialValue = param2.readUnsignedByte();
            _loc3_.spiritID = param2.readUnsignedInt();
            _loc3_.spiritCatchTime = param2.readUnsignedInt();
            this.listdb.push(_loc3_);
            this.db[_loc4_ + "_" + _loc3_.catchTime] = _loc3_;
            _loc6_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(rest[0] == "*")
         {
            return this.listdb;
         }
         if(rest.length == 2)
         {
            _loc2_ = int(rest[0]);
            _loc3_ = int(rest[1]);
            return this.db[_loc2_ + "_" + _loc3_];
         }
         return null;
      }
      
      public function selectBySpiritData(param1:int, param2:int) : Array
      {
         var _loc3_:SpiritEquipmentInfo = null;
         var _loc4_:Array = [];
         var _loc5_:int = 0;
         while(_loc5_ < this.listdb.length)
         {
            _loc3_ = this.listdb[_loc5_] as SpiritEquipmentInfo;
            if(_loc3_.spiritID == param1 && _loc3_.spiritCatchTime == param2)
            {
               _loc4_.push(_loc3_);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         var _loc4_:SpiritEquipmentInfo = null;
         var _loc2_:int = int(rest[0]);
         var _loc3_:int = int(rest[1]);
         this.db[_loc2_ + "_" + _loc3_] = null;
         var _loc5_:int = 0;
         while(_loc5_ < this.listdb.length)
         {
            if((_loc4_ = this.listdb[_loc5_] as SpiritEquipmentInfo).serverID == _loc2_ && _loc4_.catchTime == _loc3_)
            {
               this.listdb.splice(_loc5_,1);
               return true;
            }
            _loc5_++;
         }
         return false;
      }
      
      public function get list() : Array
      {
         return this.listdb;
      }
      
      public function get length() : uint
      {
         return this.listdb.length;
      }
      
      public function clear() : void
      {
      }
      
      public function getName() : String
      {
         return Constants.SEQUIP_INFO_DATA;
      }
   }
}
