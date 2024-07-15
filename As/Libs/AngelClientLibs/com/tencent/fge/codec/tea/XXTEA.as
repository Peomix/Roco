package com.tencent.fge.codec.tea
{
   public class XXTEA
   {
       
      
      protected var version:String = "1.0.0";
      
      protected var author:String = "slicoltang,slicol@qq.com";
      
      protected var copyright:String = "腾讯计算机系统有限公司";
      
      public function XXTEA()
      {
         super();
      }
      
      private static function splitString2Array(param1:String) : Array
      {
         var _loc2_:uint = 0;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         _loc2_ = uint(param1.length);
         _loc3_ = new Array(_loc2_ << 1);
         _loc4_ = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = param1.charCodeAt(_loc5_);
            _loc3_[_loc5_ << 1] = _loc4_ & 255;
            _loc3_[(_loc5_ << 1) + 1] = _loc4_ >> 8 & 255;
            _loc5_++;
         }
         return _loc3_;
      }
      
      private static function mergeArray2String(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:String = null;
         var _loc6_:uint = 0;
         _loc2_ = "";
         _loc3_ = param1.length;
         if(_loc3_ & 1 != 0)
         {
            return null;
         }
         _loc4_ = uint(_loc3_ >> 1);
         _loc5_ = "";
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = String.fromCharCode(param1[(_loc6_ << 1) + 1] << 8 ^ param1[_loc6_ << 1]);
            _loc2_ += _loc5_;
            _loc6_++;
         }
         return _loc2_;
      }
      
      public static function encrypt_String(param1:String, param2:String) : String
      {
         var _loc3_:Array = splitString2Array(param1);
         var _loc4_:Array = splitString2Array(param2);
         var _loc5_:Array = encrypt_CharArray(_loc3_,_loc4_);
         return mergeArray2String(_loc5_);
      }
      
      public static function decrypt_String(param1:String, param2:String) : String
      {
         var _loc3_:Array = splitString2Array(param1);
         var _loc4_:Array = splitString2Array(param2);
         var _loc5_:Array = decrypt_CharArray(_loc3_,_loc4_);
         return mergeArray2String(_loc5_);
      }
      
      public static function encrypt_CharArray(param1:Array, param2:Array) : Array
      {
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:int = 0;
         if(param1 == null || param1.length == 0)
         {
            return null;
         }
         var _loc3_:Array = new Array(param1.length);
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_[_loc4_] = param1[_loc4_];
            _loc4_++;
         }
         _loc3_[_loc3_.length] = param1.length;
         var _loc5_:Array = new Array(param2.length);
         _loc4_ = 0;
         while(_loc4_ < param2.length)
         {
            _loc5_[_loc4_] = param2[_loc4_];
            _loc4_++;
         }
         if(_loc5_.length < 4)
         {
            _loc5_.length = 4;
         }
         var _loc6_:int = int(_loc3_.length - 1);
         var _loc7_:int = int(_loc3_[_loc6_]);
         var _loc8_:int = int(_loc3_[0]);
         var _loc9_:int = 2654435769;
         var _loc13_:int = Math.floor(6 + 52 / (_loc6_ + 1));
         var _loc14_:* = 0;
         while(0 < _loc13_--)
         {
            _loc11_ = (_loc14_ = _loc14_ + _loc9_ & 4294967295) >>> 2 & 3;
            _loc12_ = 0;
            while(_loc12_ < _loc6_)
            {
               _loc8_ = int(_loc3_[_loc12_ + 1]);
               _loc10_ = (_loc7_ >>> 5 ^ _loc8_ << 2) + (_loc8_ >>> 3 ^ _loc7_ << 4) ^ (_loc14_ ^ _loc8_) + (_loc5_[_loc12_ & 3 ^ _loc11_] ^ _loc7_);
               _loc7_ = _loc3_[_loc12_] = _loc3_[_loc12_] + _loc10_ & 4294967295;
               _loc12_++;
            }
            _loc8_ = int(_loc3_[0]);
            _loc10_ = (_loc7_ >>> 5 ^ _loc8_ << 2) + (_loc8_ >>> 3 ^ _loc7_ << 4) ^ (_loc14_ ^ _loc8_) + (_loc5_[_loc12_ & 3 ^ _loc11_] ^ _loc7_);
            _loc7_ = _loc3_[_loc6_] = _loc3_[_loc6_] + _loc10_ & 4294967295;
         }
         var _loc15_:int = int(_loc3_.length);
         var _loc16_:Array = new Array(_loc15_ * 4);
         var _loc17_:uint = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc15_)
         {
            _loc17_ = uint(_loc3_[_loc4_]);
            _loc16_[_loc4_ * 4] = _loc17_ >> 24 & 255;
            _loc16_[_loc4_ * 4 + 1] = _loc17_ >> 16 & 255;
            _loc16_[_loc4_ * 4 + 2] = _loc17_ >> 8 & 255;
            _loc16_[_loc4_ * 4 + 3] = _loc17_ & 255;
            _loc4_++;
         }
         return _loc16_;
      }
      
      public static function decrypt_CharArray(param1:Array, param2:Array) : Array
      {
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         if(param1 == null || param1.length == 0 || param1.length % 4 != 0)
         {
            return null;
         }
         var _loc3_:int = param1.length / 4;
         var _loc4_:Array = new Array(_loc3_);
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_[_loc6_] = param1[_loc6_ * 4] << 24 | param1[_loc6_ * 4 + 1] << 16 | param1[_loc6_ * 4 + 2] << 8 | param1[_loc6_ * 4 + 3];
            _loc6_++;
         }
         var _loc7_:Array = new Array(param2.length);
         _loc6_ = 0;
         while(_loc6_ < param2.length)
         {
            _loc7_[_loc6_] = param2[_loc6_];
            _loc6_++;
         }
         if(_loc7_.length < 4)
         {
            _loc7_.length = 4;
         }
         var _loc8_:int = int(_loc4_.length - 1);
         var _loc9_:int = int(_loc4_[_loc8_ - 1]);
         var _loc10_:int = int(_loc4_[0]);
         var _loc11_:int = 2654435769;
         var _loc15_:int;
         var _loc16_:* = (_loc15_ = Math.floor(6 + 52 / (_loc8_ + 1))) * _loc11_ & 4294967295;
         while(_loc16_ != 0)
         {
            _loc13_ = _loc16_ >>> 2 & 3;
            _loc14_ = _loc8_;
            while(_loc14_ > 0)
            {
               _loc12_ = ((_loc9_ = int(_loc4_[_loc14_ - 1])) >>> 5 ^ _loc10_ << 2) + (_loc10_ >>> 3 ^ _loc9_ << 4) ^ (_loc16_ ^ _loc10_) + (_loc7_[_loc14_ & 3 ^ _loc13_] ^ _loc9_);
               _loc10_ = _loc4_[_loc14_] = _loc4_[_loc14_] - _loc12_ & 4294967295;
               _loc14_--;
            }
            _loc12_ = ((_loc9_ = int(_loc4_[_loc8_])) >>> 5 ^ _loc10_ << 2) + (_loc10_ >>> 3 ^ _loc9_ << 4) ^ (_loc16_ ^ _loc10_) + (_loc7_[_loc14_ & 3 ^ _loc13_] ^ _loc9_);
            _loc10_ = _loc4_[0] = _loc4_[0] - _loc12_ & 4294967295;
            _loc16_ = _loc16_ - _loc11_ & 4294967295;
         }
         return _loc4_.slice(0,_loc4_.length - 1);
      }
   }
}
