package com.tencent.fge.foundation.sdt.Common
{
   import com.tencent.fge.codec.Base64;
   
   public class SDData
   {
      
      private static var maxlen:int = int.MAX_VALUE;
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
      
      private var m_listener:SDListenerInterface = null;
      
      private var m_store:Object = null;
      
      private var m_key:Object = null;
      
      private var m_len:int = 0;
      
      public function SDData(param1:SDListenerInterface = null)
      {
         super();
         this.m_listener = param1;
      }
      
      public static function createByBytes(param1:Object, param2:SDListenerInterface) : SDData
      {
         var _loc3_:SDData = null;
         var _loc4_:Object = null;
         if(param1)
         {
            _loc3_ = new SDData(param2);
            _loc3_.m_len = param1.length;
            _loc4_ = param1;
            _loc3_.m_key = SDCore.randBytes(SDCore.keylen);
            _loc3_.m_store = SDCore.encrypt(_loc4_,_loc3_.m_key);
         }
         return _loc3_;
      }
      
      public static function createBySerialize(param1:String, param2:SDListenerInterface) : SDData
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc3_:SDData = null;
         if(param1)
         {
            _loc3_ = new SDData(param2);
            _loc4_ = uint("0x" + param1.slice(8,12));
            _loc5_ = uint("0x" + param1.slice(0,8));
            _loc3_.m_len = _loc4_ ^ _loc5_ - 4026531840;
            _loc6_ = Math.ceil(SDCore.keylen / 3) * 4 + 1;
            _loc7_ = Math.ceil(_loc3_.m_len / 3) * 4 + 1;
            _loc3_.m_key = Base64.decode_CharArray(param1.slice(12,_loc6_ + 12));
            _loc3_.m_store = Base64.decode_CharArray(param1.slice(_loc6_ + 12));
         }
         return _loc3_;
      }
      
      public function refresh() : Boolean
      {
         var _loc1_:Object = SDCore.decrypt(this.m_store,this.m_key);
         if(_loc1_ == null || _loc1_.length == 0)
         {
            return false;
         }
         var _loc2_:Object = SDCore.randBytes(SDCore.keylen);
         var _loc3_:Object = SDCore.encrypt(_loc1_,_loc2_);
         if(_loc3_ == null || _loc3_.length == 0)
         {
            return false;
         }
         SDCore.freeBytes(_loc1_);
         SDCore.freeBytes(this.m_key);
         SDCore.freeBytes(this.m_store);
         this.m_key = _loc2_;
         this.m_store = _loc3_;
         return true;
      }
      
      public function dispose() : void
      {
         SDCore.freeBytes(this.m_key);
         SDCore.freeBytes(this.m_store);
         this.m_listener = null;
         this.m_store = null;
         this.m_key = null;
         this.m_len = 0;
      }
      
      public function serialize() : String
      {
         var _loc1_:Object = this.readStringBytes();
         var _loc2_:SDData = SDData.createByBytes(_loc1_,this.m_listener);
         var _loc3_:String = _loc2_.innerSerialize();
         SDCore.freeBytes(_loc1_);
         _loc2_.dispose();
         return _loc3_;
      }
      
      private function innerSerialize() : String
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:String = null;
         _loc1_ = Math.random() * 4095 + 61440;
         _loc3_ = ((uint(this.m_len) ^ _loc1_) + 4026531840).toString(16);
         _loc2_ = _loc1_.toString(16);
         _loc3_ += _loc2_;
         _loc3_ += Base64.encode_CharArray(SDCore.toArray(this.m_key));
         return _loc3_ + Base64.encode_CharArray(SDCore.toArray(this.m_store));
      }
      
      public function readStringBytes() : Object
      {
         return SDCore.decrypt(this.m_store,this.m_key);
      }
   }
}

