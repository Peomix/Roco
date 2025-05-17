package com.QQ.angel.install.config.zip
{
   import flash.utils.ByteArray;
   
   public class ZipEntry
   {
      
      private var _compressedSize:int = -1;
      
      private var _extra:ByteArray;
      
      internal var offset:int;
      
      private var _crc:uint;
      
      internal var version:int;
      
      internal var dostime:uint;
      
      private var _size:int = -1;
      
      private var _method:int = -1;
      
      private var _comment:String;
      
      internal var flag:int;
      
      private var _name:String;
      
      public function ZipEntry(param1:String)
      {
         super();
         _name = param1;
      }
      
      public function set compressedSize(param1:int) : void
      {
         _compressedSize = param1;
      }
      
      public function get size() : int
      {
         return _size;
      }
      
      public function set size(param1:int) : void
      {
         _size = param1;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get time() : Number
      {
         var _loc1_:Date = new Date((dostime >> 25 & 0x7F) + 1980,(dostime >> 21 & 0x0F) - 1,dostime >> 16 & 0x1F,dostime >> 11 & 0x1F,dostime >> 5 & 0x3F,(dostime & 0x1F) << 1);
         return _loc1_.time;
      }
      
      public function get extra() : ByteArray
      {
         return _extra;
      }
      
      public function set time(param1:Number) : void
      {
         var _loc2_:Date = new Date(param1);
         dostime = (_loc2_.fullYear - 1980 & 0x7F) << 25 | _loc2_.month + 1 << 21 | _loc2_.day << 16 | _loc2_.hours << 11 | _loc2_.minutes << 5 | _loc2_.seconds >> 1;
      }
      
      public function get crc() : uint
      {
         return _crc;
      }
      
      public function get method() : int
      {
         return _method;
      }
      
      public function isDirectory() : Boolean
      {
         return _name.charAt(_name.length - 1) == "/";
      }
      
      public function set method(param1:int) : void
      {
         _method = param1;
      }
      
      public function set crc(param1:uint) : void
      {
         _crc = param1;
      }
      
      public function get comment() : String
      {
         return _comment;
      }
      
      public function set extra(param1:ByteArray) : void
      {
         _extra = param1;
      }
      
      public function get compressedSize() : int
      {
         return _compressedSize;
      }
      
      public function toString() : String
      {
         return _name;
      }
      
      public function set comment(param1:String) : void
      {
         _comment = param1;
      }
   }
}

