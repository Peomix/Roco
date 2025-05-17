package com.tencent.fge.foundation.sdt.Common
{
   import flash.utils.ByteArray;
   
   public class SDCore
   {
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
      
      public function SDCore()
      {
         super();
      }
      
      public static function toByteArray(param1:Object) : ByteArray
      {
         if(param1 is Array)
         {
            return arr2bytes(param1 as Array);
         }
         if(param1 is ByteArray)
         {
            return param1 as ByteArray;
         }
         return null;
      }
      
      public static function toArray(param1:Object) : Array
      {
         if(param1 is Array)
         {
            return param1 as Array;
         }
         if(param1 is ByteArray)
         {
            return bytes2arr(param1 as ByteArray);
         }
         return null;
      }
      
      public static function freeBytes(param1:Object) : Boolean
      {
         return MemoryPool.freeMemory(param1);
      }
      
      private static function get crypto() : ICrypto
      {
         return XorArrayCrypto.singleton;
      }
      
      public static function cloneBytes(param1:Object) : Object
      {
         return crypto.cloneBytes(param1);
      }
      
      public static function randBytes(param1:int) : Object
      {
         return crypto.randBytes(param1);
      }
      
      public static function compareBytes(param1:Object, param2:Object) : Boolean
      {
         return crypto.compareBytes(param1,param2);
      }
      
      public static function string2bytes(param1:String) : Object
      {
         return crypto.str2bytes(param1);
      }
      
      public static function bytes2string(param1:Object) : String
      {
         return crypto.bytes2str(param1);
      }
      
      public static function get keylen() : int
      {
         return crypto.keylen;
      }
      
      public static function decrypt(param1:Object, param2:Object) : Object
      {
         return crypto.decrypt(param1,param2);
      }
      
      public static function encrypt(param1:Object, param2:Object) : Object
      {
         return crypto.encrypt(param1,param2);
      }
   }
}

import com.tencent.fge.codec.tea.XXTEA;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;
import flash.utils.getTimer;

class TimeProfiler
{
   
   private static var ms_mapMax:Dictionary = new Dictionary();
   
   private static var ms_mapMin:Dictionary = new Dictionary();
   
   private static var ms_mapTemp:Dictionary = new Dictionary();
   
   public function TimeProfiler()
   {
      super();
   }
   
   public static function begin(param1:Object) : void
   {
      ms_mapTemp[param1] = getTimer();
   }
   
   public static function end(param1:Object) : void
   {
      var _loc2_:int = getTimer() - ms_mapTemp[param1];
      ms_mapMax[param1] = isNaN(ms_mapMax[param1]) ? _loc2_ : Math.max(_loc2_,ms_mapMax[param1]);
      ms_mapMin[param1] = isNaN(ms_mapMin[param1]) ? _loc2_ : Math.min(_loc2_,ms_mapMin[param1]);
   }
   
   public static function output(param1:String, param2:Object) : void
   {
      trace(param1,"max:" + ms_mapMax[param2],"min:" + ms_mapMin[param2]);
   }
}

class MemoryPool
{
   
   private static var ms_singleton:MemoryPool;
   
   private static var ms_pool:Dictionary = new Dictionary();
   
   public function MemoryPool()
   {
      super();
   }
   
   public static function get singleton() : MemoryPool
   {
      if(ms_singleton == null)
      {
         ms_singleton = new MemoryPool();
      }
      return ms_singleton;
   }
   
   public static function getByteArray(param1:int = 0) : ByteArray
   {
      var _loc2_:ByteArray = getMemory(ByteArray) as ByteArray;
      _loc2_.length = param1;
      return _loc2_;
   }
   
   public static function getArray(param1:int = 0) : Array
   {
      var _loc2_:Array = getMemory(Array) as Array;
      _loc2_.length = param1;
      return _loc2_;
   }
   
   public static function getMemory(param1:Class) : Object
   {
      var _loc2_:Array = null;
      if(param1)
      {
         _loc2_ = ms_pool[param1];
         if(Boolean(_loc2_) && _loc2_.length > 0)
         {
            return _loc2_.pop();
         }
         return new param1();
      }
      return null;
   }
   
   private static function getClass(param1:Object) : *
   {
      var _loc2_:* = undefined;
      var _loc3_:String = null;
      if(param1)
      {
         _loc2_ = null;
         try
         {
            _loc3_ = getQualifiedClassName(param1);
            _loc2_ = _loc3_ ? getDefinitionByName(_loc3_) : null;
         }
         catch(e:Error)
         {
         }
         if(_loc2_)
         {
            return _loc2_;
         }
         if(param1.hasOwnProperty("constructor"))
         {
            return param1.constructor;
         }
      }
      return null;
   }
   
   public static function freeMemory(param1:Object) : Boolean
   {
      var _loc2_:Class = null;
      var _loc3_:Array = null;
      if(param1)
      {
         _loc2_ = getClass(param1);
         if(_loc2_)
         {
            _loc3_ = ms_pool[_loc2_];
            if(!_loc3_)
            {
               ms_pool[_loc2_] = [param1];
               return true;
            }
            if(_loc3_.indexOf(param1) < 0)
            {
               _loc3_.push(param1);
               return true;
            }
         }
      }
      return false;
   }
}

interface ICrypto
{
   
   function cloneBytes(param1:Object) : Object;
   
   function randBytes(param1:int) : Object;
   
   function compareBytes(param1:Object, param2:Object) : Boolean;
   
   function str2bytes(param1:String) : Object;
   
   function bytes2str(param1:Object) : String;
   
   function get keylen() : int;
   
   function decrypt(param1:Object, param2:Object) : Object;
   
   function encrypt(param1:Object, param2:Object) : Object;
}

class BaseArrayCrypto implements ICrypto
{
   
   public function BaseArrayCrypto()
   {
      super();
   }
   
   public function cloneBytes(param1:Object) : Object
   {
      var _loc3_:int = 0;
      var _loc4_:Array = null;
      var _loc5_:int = 0;
      var _loc2_:Array = param1 as Array;
      if(_loc2_)
      {
         _loc3_ = int(_loc2_.length);
         _loc4_ = MemoryPool.getArray(_loc3_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_[_loc5_] = _loc2_[_loc5_];
            _loc5_++;
         }
      }
      return _loc4_;
   }
   
   public function randBytes(param1:int) : Object
   {
      var _loc2_:Array = MemoryPool.getArray();
      var _loc3_:int = 0;
      while(_loc3_ < param1)
      {
         _loc2_[_loc3_] = int(Math.random() * 255);
         _loc3_++;
      }
      return _loc2_;
   }
   
   public function compareBytes(param1:Object, param2:Object) : Boolean
   {
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc3_:Array = param1 as Array;
      var _loc4_:Array = param2 as Array;
      if(Boolean(_loc3_) && Boolean(_loc4_))
      {
         if(_loc3_.length == _loc4_.length)
         {
            _loc5_ = 0;
            _loc6_ = int(_loc3_.length);
            while(_loc5_ < _loc6_)
            {
               if(_loc3_[_loc5_] != _loc4_[_loc5_])
               {
                  return false;
               }
               _loc5_++;
            }
            return true;
         }
      }
      return false;
   }
   
   public function str2bytes(param1:String) : Object
   {
      var _loc2_:uint = uint(param1.length);
      var _loc3_:Array = MemoryPool.getArray(_loc2_ << 1);
      var _loc4_:uint = 0;
      var _loc5_:uint = 0;
      while(_loc5_ < _loc2_)
      {
         _loc4_ = uint(param1.charCodeAt(_loc5_));
         _loc3_[_loc5_ << 1] = _loc4_ & 0xFF;
         _loc3_[(_loc5_ << 1) + 1] = _loc4_ >> 8 & 0xFF;
         _loc5_++;
      }
      return _loc3_;
   }
   
   public function bytes2str(param1:Object) : String
   {
      var _loc4_:uint = 0;
      var _loc5_:uint = 0;
      var _loc6_:String = null;
      var _loc7_:uint = 0;
      var _loc2_:String = null;
      var _loc3_:Array = param1 as Array;
      if(_loc3_)
      {
         _loc4_ = _loc3_.length;
         if(_loc4_ & 1 != 0)
         {
            return null;
         }
         _loc5_ = uint(_loc4_ >> 1);
         _loc6_ = "";
         _loc7_ = 0;
         _loc2_ = "";
         while(_loc7_ < _loc5_)
         {
            _loc6_ = String.fromCharCode(_loc3_[(_loc7_ << 1) + 1] << 8 ^ _loc3_[_loc7_ << 1]);
            _loc2_ += _loc6_;
            _loc7_++;
         }
      }
      return _loc2_;
   }
   
   public function decrypt(param1:Object, param2:Object) : Object
   {
      var _loc5_:Array = null;
      var _loc3_:Array = param1 as Array;
      var _loc4_:Array = param2 as Array;
      if(Boolean(_loc3_) && (this.keylen > 0 && _loc4_ || this.keylen == 0))
      {
         return this.doDecrypt(_loc3_,_loc4_);
      }
      return null;
   }
   
   public function encrypt(param1:Object, param2:Object) : Object
   {
      var _loc5_:Array = null;
      var _loc3_:Array = param1 as Array;
      var _loc4_:Array = param2 as Array;
      if(Boolean(_loc3_) && Boolean(_loc4_))
      {
         return this.doEncrypt(_loc3_,_loc4_);
      }
      return null;
   }
   
   public function get keylen() : int
   {
      return 0;
   }
   
   protected function doDecrypt(param1:Array, param2:Array) : Array
   {
      return null;
   }
   
   protected function doEncrypt(param1:Array, param2:Array) : Array
   {
      return null;
   }
}

class BaseByteArrayCrypto implements ICrypto
{
   
   public function BaseByteArrayCrypto()
   {
      super();
   }
   
   public function cloneBytes(param1:Object) : Object
   {
      var _loc2_:ByteArray = null;
      var _loc3_:ByteArray = param1 as ByteArray;
      if(_loc3_)
      {
         _loc2_ = MemoryPool.getByteArray();
         _loc2_.writeBytes(_loc3_,0,_loc3_.length);
         _loc2_.position = 0;
      }
      return _loc2_;
   }
   
   public function randBytes(param1:int) : Object
   {
      var _loc2_:ByteArray = MemoryPool.getByteArray();
      var _loc3_:int = 0;
      while(_loc3_ < param1)
      {
         _loc2_.writeByte(Math.random() * 255);
         _loc3_++;
      }
      _loc2_.position = 0;
      return _loc2_;
   }
   
   public function compareBytes(param1:Object, param2:Object) : Boolean
   {
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:int = 0;
      var _loc8_:int = 0;
      var _loc3_:ByteArray = param1 as ByteArray;
      var _loc4_:ByteArray = param2 as ByteArray;
      if(Boolean(_loc3_) && Boolean(_loc4_))
      {
         if(_loc3_.length == _loc4_.length)
         {
            _loc5_ = int(_loc3_.position);
            _loc6_ = int(_loc4_.position);
            _loc3_.position = 0;
            _loc4_.position = 0;
            _loc7_ = 0;
            _loc8_ = int(_loc3_.length);
            while(_loc7_ < _loc8_)
            {
               if(_loc3_.readByte() != _loc4_.readByte())
               {
                  _loc3_.position = _loc5_;
                  _loc4_.position = _loc6_;
                  return false;
               }
               _loc7_++;
            }
            _loc3_.position = _loc5_;
            _loc4_.position = _loc6_;
            return true;
         }
      }
      return false;
   }
   
   public function str2bytes(param1:String) : Object
   {
      var _loc3_:uint = 0;
      var _loc4_:uint = 0;
      var _loc5_:uint = 0;
      var _loc2_:ByteArray = null;
      if(param1)
      {
         _loc3_ = uint(param1.length);
         _loc4_ = 0;
         _loc5_ = 0;
         _loc2_ = MemoryPool.getByteArray();
         _loc2_.length = _loc3_ << 1;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = uint(param1.charCodeAt(_loc5_));
            _loc2_.writeByte(_loc4_ & 0xFF);
            _loc2_.writeByte(_loc4_ >> 8 & 0xFF);
            _loc5_++;
         }
         _loc2_.position = 0;
      }
      return _loc2_;
   }
   
   public function bytes2str(param1:Object) : String
   {
      var _loc2_:String = null;
      var _loc4_:uint = 0;
      var _loc5_:uint = 0;
      var _loc6_:String = null;
      var _loc7_:uint = 0;
      var _loc8_:int = 0;
      var _loc9_:uint = 0;
      var _loc10_:uint = 0;
      var _loc3_:ByteArray = param1 as ByteArray;
      if(_loc3_)
      {
         _loc4_ = _loc3_.length;
         if(_loc4_ & 1 != 0)
         {
            return null;
         }
         _loc5_ = uint(_loc4_ >> 1);
         _loc6_ = "";
         _loc7_ = 0;
         _loc2_ = "";
         _loc8_ = int(_loc3_.position);
         _loc3_.position = 0;
         while(_loc7_ < _loc5_)
         {
            _loc9_ = _loc3_.readUnsignedByte();
            _loc10_ = _loc3_.readUnsignedByte();
            _loc6_ = String.fromCharCode(_loc10_ << 8 ^ _loc9_);
            _loc2_ += _loc6_;
            _loc7_++;
         }
         _loc3_.position = _loc8_;
      }
      return _loc2_;
   }
   
   public function decrypt(param1:Object, param2:Object) : Object
   {
      var _loc5_:ByteArray = null;
      var _loc3_:ByteArray = param1 as ByteArray;
      var _loc4_:ByteArray = param2 as ByteArray;
      if(Boolean(_loc3_) && (this.keylen > 0 && _loc4_ || this.keylen == 0))
      {
         return this.doDecrypt(_loc3_,_loc4_);
      }
      return null;
   }
   
   public function encrypt(param1:Object, param2:Object) : Object
   {
      var _loc5_:ByteArray = null;
      var _loc3_:ByteArray = param1 as ByteArray;
      var _loc4_:ByteArray = param2 as ByteArray;
      if(Boolean(_loc3_) && Boolean(_loc4_))
      {
         return this.doEncrypt(_loc3_,_loc4_);
      }
      return null;
   }
   
   public function get keylen() : int
   {
      return 0;
   }
   
   protected function doDecrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return null;
   }
   
   protected function doEncrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return null;
   }
}

class XXTeaArrayCrypto extends BaseArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   public function XXTeaArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new XXTeaArrayCrypto();
      }
      return ms_singleton;
   }
   
   override public function get keylen() : int
   {
      return 23;
   }
   
   override protected function doDecrypt(param1:Array, param2:Array) : Array
   {
      return XXTEA.decrypt_CharArray(param1,param2);
   }
   
   override protected function doEncrypt(param1:Array, param2:Array) : Array
   {
      return XXTEA.encrypt_CharArray(param1,param2);
   }
}

class TeaByteArrayCrypto extends BaseByteArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   private static const FUNC_TEALEN:String = "1";
   
   private static const FUNC_TEAENC:String = "2";
   
   private static const FUNC_TEADEC:String = "3";
   
   public function TeaByteArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new TeaByteArrayCrypto();
      }
      return ms_singleton;
   }
   
   override protected function doDecrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      throw new Error("暂不开放!");
   }
   
   override protected function doEncrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      throw new Error("暂不开放!");
   }
   
   override public function get keylen() : int
   {
      return 16;
   }
}

class XorByteArrayCrypto extends BaseByteArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   public function XorByteArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new XorByteArrayCrypto();
      }
      return ms_singleton;
   }
   
   private static function crypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:int = 0;
      var _loc8_:uint = 0;
      var _loc9_:uint = 0;
      var _loc3_:ByteArray = null;
      if(Boolean(param1) && Boolean(param2))
      {
         _loc4_ = int(param1.position);
         _loc5_ = int(param2.position);
         param1.position = 0;
         param2.position = 0;
         _loc3_ = MemoryPool.getByteArray();
         _loc6_ = 0;
         _loc7_ = int(param1.length);
         while(_loc6_ < _loc7_)
         {
            if(param2.bytesAvailable == 0)
            {
               param2.position = 0;
            }
            _loc8_ = param1.readUnsignedByte();
            _loc9_ = param2.readUnsignedByte();
            _loc8_ ^= _loc9_;
            _loc3_.writeByte(_loc8_);
            _loc6_++;
         }
         _loc3_.position = 0;
         param1.position = _loc4_;
         param2.position = _loc5_;
      }
      return _loc3_;
   }
   
   override protected function doDecrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return crypt(param1,param2);
   }
   
   override protected function doEncrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return crypt(param1,param2);
   }
   
   override public function get keylen() : int
   {
      return 3;
   }
}

class NegByteArrayCrypto extends BaseByteArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   public function NegByteArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new NegByteArrayCrypto();
      }
      return ms_singleton;
   }
   
   private static function crypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:uint = 0;
      var _loc3_:ByteArray = null;
      if(param1)
      {
         _loc3_ = MemoryPool.getByteArray();
         _loc4_ = int(param1.position);
         _loc5_ = 0;
         _loc6_ = int(param1.length);
         while(_loc5_ < _loc6_)
         {
            _loc7_ = param1.readUnsignedByte();
            _loc7_ = uint(~_loc7_ & 0xFF);
            _loc3_.writeByte(_loc7_);
            _loc5_++;
         }
         param1.position = _loc4_;
         _loc3_.position = 0;
      }
      return _loc3_;
   }
   
   override protected function doDecrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return crypt(param1,param2);
   }
   
   override protected function doEncrypt(param1:ByteArray, param2:ByteArray) : ByteArray
   {
      return crypt(param1,param2);
   }
   
   override public function get keylen() : int
   {
      return 0;
   }
}

class XorArrayCrypto extends BaseArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   public function XorArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new XorArrayCrypto();
      }
      return ms_singleton;
   }
   
   private static function crypt(param1:Array, param2:Array) : Array
   {
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:int = 0;
      var _loc7_:uint = 0;
      var _loc8_:uint = 0;
      var _loc3_:Array = null;
      if(Boolean(param1) && Boolean(param2))
      {
         _loc3_ = MemoryPool.getArray();
         _loc4_ = 0;
         _loc5_ = int(param1.length);
         _loc6_ = int(param2.length);
         while(_loc4_ < _loc5_)
         {
            _loc7_ = uint(param1[_loc4_]);
            _loc8_ = uint(param2[_loc4_ % _loc6_]);
            _loc7_ ^= _loc8_;
            _loc3_.push(_loc7_);
            _loc4_++;
         }
      }
      return _loc3_;
   }
   
   override protected function doDecrypt(param1:Array, param2:Array) : Array
   {
      return crypt(param1,param2);
   }
   
   override protected function doEncrypt(param1:Array, param2:Array) : Array
   {
      return crypt(param1,param2);
   }
   
   override public function get keylen() : int
   {
      return 3;
   }
}

class NegArrayCrypto extends BaseArrayCrypto implements ICrypto
{
   
   private static var ms_singleton:ICrypto;
   
   public function NegArrayCrypto()
   {
      super();
   }
   
   public static function get singleton() : ICrypto
   {
      if(ms_singleton == null)
      {
         ms_singleton = new NegArrayCrypto();
      }
      return ms_singleton;
   }
   
   private static function crypt(param1:Array, param2:Array) : Array
   {
      var _loc4_:int = 0;
      var _loc5_:int = 0;
      var _loc6_:uint = 0;
      var _loc3_:Array = null;
      if(param1)
      {
         _loc3_ = MemoryPool.getArray();
         _loc4_ = 0;
         _loc5_ = int(param1.length);
         while(_loc4_ < _loc5_)
         {
            _loc6_ = uint(param1[_loc4_]);
            _loc6_ = uint(~_loc6_ & 0xFF);
            _loc3_.push(_loc6_);
            _loc4_++;
         }
      }
      return _loc3_;
   }
   
   override protected function doDecrypt(param1:Array, param2:Array) : Array
   {
      return crypt(param1,param2);
   }
   
   override protected function doEncrypt(param1:Array, param2:Array) : Array
   {
      return crypt(param1,param2);
   }
   
   override public function get keylen() : int
   {
      return 0;
   }
}

function arr2bytes(param1:Array):ByteArray
{
   var _loc3_:String = null;
   var _loc4_:int = 0;
   var _loc2_:ByteArray = MemoryPool.getByteArray();
   for each(var _loc7_ in param1)
   {
      _loc3_ = _loc7_;
      _loc7_;
      _loc4_ = int(_loc3_);
      _loc2_.writeByte(_loc4_);
   }
   _loc2_.position = 0;
   return _loc2_;
}
function bytes2arr(param1:ByteArray):Array
{
   var _loc3_:int = 0;
   var _loc4_:int = 0;
   var _loc5_:int = 0;
   var _loc6_:uint = 0;
   var _loc2_:Array = null;
   if(param1)
   {
      _loc3_ = int(param1.position);
      param1.position = 0;
      _loc2_ = MemoryPool.getArray();
      _loc4_ = 0;
      _loc5_ = int(param1.bytesAvailable);
      while(_loc4_ < _loc5_)
      {
         _loc6_ = param1.readUnsignedByte();
         _loc2_.push(_loc6_.toString());
         _loc4_++;
      }
      param1.position = _loc3_;
   }
   return _loc2_;
}
