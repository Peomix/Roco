package com.tencent.fge.codec
{
   import flash.utils.ByteArray;
   
   public class Base64
   {
      
      private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
      
      public static const version:String = "2.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
      
      public function Base64()
      {
         super();
         throw new Error("Base64 class is static container only");
      }
      
      public static function encode(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return encodeByteArray(_loc2_);
      }
      
      public static function encodeByteArray(param1:ByteArray) : String
      {
         var _loc3_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:String = "";
         var _loc4_:Array = new Array(4);
         param1.position = 0;
         while(param1.bytesAvailable > 0)
         {
            _loc3_ = new Array();
            _loc5_ = 0;
            while(_loc5_ < 3 && param1.bytesAvailable > 0)
            {
               _loc3_[_loc5_] = param1.readUnsignedByte();
               _loc5_++;
            }
            _loc4_[0] = (_loc3_[0] & 0xFC) >> 2;
            _loc4_[1] = (_loc3_[0] & 3) << 4 | _loc3_[1] >> 4;
            _loc4_[2] = (_loc3_[1] & 0x0F) << 2 | _loc3_[2] >> 6;
            _loc4_[3] = _loc3_[2] & 0x3F;
            _loc6_ = _loc3_.length;
            while(_loc6_ < 3)
            {
               _loc4_[_loc6_ + 1] = 64;
               _loc6_++;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               _loc2_ += BASE64_CHARS.charAt(_loc4_[_loc7_]);
               _loc7_++;
            }
         }
         return _loc2_;
      }
      
      public static function decode(param1:String) : String
      {
         var _loc2_:ByteArray = decodeToByteArray(param1);
         return _loc2_.readUTFBytes(_loc2_.length);
      }
      
      public static function decodeToByteArray(param1:String) : ByteArray
      {
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:ByteArray = new ByteArray();
         var _loc3_:Array = new Array(4);
         var _loc4_:Array = new Array(3);
         var _loc5_:uint = 0;
         while(_loc5_ < param1.length)
         {
            _loc6_ = 0;
            while(_loc6_ < 4 && _loc5_ + _loc6_ < param1.length)
            {
               _loc3_[_loc6_] = BASE64_CHARS.indexOf(param1.charAt(_loc5_ + _loc6_));
               _loc6_++;
            }
            _loc4_[0] = (_loc3_[0] << 2) + ((_loc3_[1] & 0x30) >> 4);
            _loc4_[1] = ((_loc3_[1] & 0x0F) << 4) + ((_loc3_[2] & 0x3C) >> 2);
            _loc4_[2] = ((_loc3_[2] & 3) << 6) + _loc3_[3];
            _loc7_ = 0;
            while(_loc7_ < _loc4_.length)
            {
               if(_loc3_[_loc7_ + 1] == 64)
               {
                  break;
               }
               _loc2_.writeByte(_loc4_[_loc7_]);
               _loc7_++;
            }
            _loc5_ += 4;
         }
         _loc2_.position = 0;
         return _loc2_;
      }
      
      public static function encode_CharArray(param1:Array) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = param1.length % 3;
         if(_loc3_ == 0)
         {
            _loc2_ = "t";
         }
         else if(_loc3_ == 1)
         {
            _loc2_ = "s";
            param1.push(0);
            param1.push(0);
         }
         else
         {
            _loc2_ = "f";
            param1.push(0);
         }
         var _loc4_:uint = param1.length / 3;
         var _loc5_:String = "";
         var _loc6_:String = "";
         var _loc7_:String = "";
         var _loc8_:String = "";
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         while(_loc12_ < _loc4_)
         {
            _loc9_ = uint(param1[_loc12_ * 3]);
            _loc10_ = uint(param1[_loc12_ * 3 + 1]);
            _loc11_ = uint(param1[_loc12_ * 3 + 2]);
            _loc5_ = BASE64_CHARS.charAt(_loc9_ >> 2);
            _loc6_ = BASE64_CHARS.charAt((_loc9_ & 3) << 4 ^ _loc10_ >> 4);
            _loc7_ = BASE64_CHARS.charAt((_loc10_ & 0x0F) << 2 ^ _loc11_ >> 6);
            _loc8_ = BASE64_CHARS.charAt(_loc11_ & 0x3F);
            _loc2_ = _loc2_ + _loc5_ + _loc6_ + _loc7_ + _loc8_;
            _loc12_++;
         }
         return _loc2_;
      }
      
      public static function decode_CharArray(param1:String) : Array
      {
         var _loc2_:int = 0;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         _loc2_ = param1.length / 4 * 3;
         _loc6_ = new Array(_loc2_);
         _loc3_ = param1.charAt(0);
         _loc4_ = param1.slice(1);
         if(_loc3_ == "t")
         {
            _loc5_ = new Array(_loc2_);
         }
         else if(_loc3_ == "s")
         {
            _loc5_ = new Array(_loc2_ - 2);
         }
         else
         {
            if(_loc3_ != "f")
            {
               return null;
            }
            _loc5_ = new Array(_loc2_ - 1);
         }
         _loc2_ /= 3;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(_loc11_ < _loc2_)
         {
            _loc7_ = uint(BASE64_CHARS.indexOf(_loc4_.charAt(4 * _loc11_)));
            _loc8_ = uint(BASE64_CHARS.indexOf(_loc4_.charAt(4 * _loc11_ + 1)));
            _loc9_ = uint(BASE64_CHARS.indexOf(_loc4_.charAt(4 * _loc11_ + 2)));
            _loc10_ = uint(BASE64_CHARS.indexOf(_loc4_.charAt(4 * _loc11_ + 3)));
            _loc6_[3 * _loc11_] = _loc7_ << 2 ^ _loc8_ >> 4;
            _loc6_[3 * _loc11_ + 1] = (_loc8_ & 0x0F) << 4 ^ _loc9_ >> 2;
            _loc6_[3 * _loc11_ + 2] = (_loc9_ & 3) << 6 ^ _loc10_;
            _loc11_++;
         }
         var _loc12_:uint = _loc5_.length;
         var _loc13_:uint = 0;
         while(_loc13_ < _loc12_)
         {
            _loc5_[_loc13_] = _loc6_[_loc13_];
            _loc13_++;
         }
         return _loc5_;
      }
   }
}

