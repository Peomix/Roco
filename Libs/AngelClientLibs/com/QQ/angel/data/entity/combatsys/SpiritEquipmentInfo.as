package com.QQ.angel.data.entity.combatsys
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.common.__global;
   import flash.utils.ByteArray;
   
   public class SpiritEquipmentInfo
   {
       
      
      public var id:uint;
      
      public var type:uint;
      
      public var quality:uint;
      
      public var price:uint;
      
      public var baseAttr:uint;
      
      public var baseValue:uint;
      
      public var specialAttr:uint;
      
      public var specialValue:uint;
      
      private var _serverID:uint;
      
      public var catchTime:uint;
      
      public var des:SpiritEquipmentDes;
      
      public var spiritID:uint;
      
      public var spiritCatchTime:uint;
      
      public var selectValue:uint;
      
      public function SpiritEquipmentInfo()
      {
         super();
      }
      
      public static function getIdByServerId(param1:uint) : uint
      {
         return param1 & (1 << 20) - 1;
      }
      
      public static function getTypeByServerId(param1:uint) : uint
      {
         return param1 >> 20 & 7;
      }
      
      public static function getQualityByServerId(param1:uint) : uint
      {
         return param1 >> 23 & 7;
      }
      
      public function set serverID(param1:uint) : void
      {
         var _loc2_:IDataProxy = null;
         var _loc3_:ByteArray = null;
         this._serverID = param1;
         if(this._serverID != 0)
         {
            this.id = getIdByServerId(this._serverID);
            this.type = getTypeByServerId(this._serverID);
            this.quality = getQualityByServerId(this._serverID);
            _loc2_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SEQUIP_DES_DATA);
            this.des = _loc2_.select(this.type,this.id) as SpiritEquipmentDes;
            if(this.des != null)
            {
               this.price = this.des.price[this.quality - 1];
               _loc3_ = new ByteArray();
               _loc3_.writeByte(0);
               _loc3_.writeByte(this.type);
               _loc3_.writeByte(this.des.level);
               _loc3_.writeByte(this.quality);
               _loc3_.position = 0;
               this.selectValue = _loc3_.readUnsignedInt();
            }
         }
      }
      
      public function get serverID() : uint
      {
         return this._serverID;
      }
   }
}
