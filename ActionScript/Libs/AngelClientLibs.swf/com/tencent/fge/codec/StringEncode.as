package com.tencent.fge.codec
{
   import flash.utils.ByteArray;
   
   public class StringEncode
   {
      
      public function StringEncode()
      {
         super();
      }
      
      public static function urlencodeGB2312(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"gb2312");
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function urlencodeBIG5(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"big5");
         while(_loc4_ < _loc3_.length)
         {
            _loc2_ += escape(String.fromCharCode(_loc3_[_loc4_]));
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function urlencodeGBK(param1:String) : String
      {
         var _loc4_:int = 0;
         var _loc2_:String = "";
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeMultiByte(param1,"gbk");
         _loc3_.position = 0;
         return _loc3_.readMultiByte(_loc3_.length,"gbk");
      }
   }
}

