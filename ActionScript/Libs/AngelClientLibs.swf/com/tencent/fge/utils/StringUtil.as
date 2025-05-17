package com.tencent.fge.utils
{
   import com.tencent.fge.foundation.signals.Signal;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class StringUtil
   {
      
      public static var implStringUtil:StringUtil;
      
      public static var ms_mapDirtyString:Dictionary = new Dictionary();
      
      private static var ms_sSpace:String = "                  ";
      
      private static var s_bytesTestString:ByteArray = new ByteArray();
      
      public static const RANGE_NUMBERS:uint = 1;
      
      public static const RANGE_LOWER_LETTER:uint = 2;
      
      public static const RANGE_UPPER_LETTER:uint = 4;
      
      public static const RANGE_LETTERS:uint = RANGE_LOWER_LETTER | RANGE_UPPER_LETTER;
      
      private static const CHAR_CODE_0:Number = "0".charCodeAt();
      
      private static const CHAR_CODE_9:Number = "9".charCodeAt();
      
      private static const CHAR_CODE_LOWER_A:Number = "a".charCodeAt();
      
      private static const CHAR_CODE_LOWER_Z:Number = "z".charCodeAt();
      
      private static const CHAR_CODE_UPPER_A:Number = "A".charCodeAt();
      
      private static const CHAR_CODE_UPPER_Z:Number = "Z".charCodeAt();
      
      public static var onCheckDirty:Signal = new Signal();
      
      public function StringUtil()
      {
         super();
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function trim(param1:String, param2:String = " ") : String
      {
         if(isWhitespace(param2))
         {
            return trimFast(param1);
         }
         return trimBack(trimFront(param1,param2),param2);
      }
      
      public static function trimFront(param1:String, param2:String) : String
      {
         param2 = stringToCharacter(param2);
         if(param1.charAt(0) == param2)
         {
            param1 = trimFront(param1.substring(1),param2);
         }
         return param1;
      }
      
      public static function trimBack(param1:String, param2:String) : String
      {
         param2 = stringToCharacter(param2);
         if(param1.charAt(param1.length - 1) == param2)
         {
            param1 = trimBack(param1.substring(0,param1.length - 1),param2);
         }
         return param1;
      }
      
      public static function stringToCharacter(param1:String) : String
      {
         if(param1.length == 1)
         {
            return param1;
         }
         return param1.slice(0,1);
      }
      
      private static function trimFast(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:int = 0;
         while(isWhitespace(param1.charAt(_loc2_)))
         {
            _loc2_++;
         }
         var _loc3_:int = param1.length - 1;
         while(isWhitespace(param1.charAt(_loc3_)))
         {
            _loc3_--;
         }
         if(_loc3_ >= _loc2_)
         {
            return param1.slice(_loc2_,_loc3_ + 1);
         }
         return "";
      }
      
      public static function trimArrayElements(param1:String, param2:String) : String
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1 != "" && param1 != null)
         {
            _loc3_ = param1.split(param2);
            _loc4_ = int(_loc3_.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_[_loc5_] = StringUtil.trim(_loc3_[_loc5_]);
               _loc5_++;
            }
            if(_loc4_ > 0)
            {
               param1 = _loc3_.join(param2);
            }
         }
         return param1;
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
            default:
               return false;
         }
      }
      
      public static function substitute(param1:String, ... rest) : String
      {
         var _loc4_:Array = null;
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:uint = uint(rest.length);
         if(_loc3_ == 1 && rest[0] is Array)
         {
            _loc4_ = rest[0] as Array;
            _loc3_ = _loc4_.length;
         }
         else
         {
            _loc4_ = rest;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc4_[_loc5_]);
            _loc5_++;
         }
         return param1;
      }
      
      public static function printf(param1:String, ... rest) : String
      {
         var _loc9_:String = null;
         var _loc3_:int = int(rest.length);
         var _loc4_:String = "";
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc6_ = _loc5_;
            while(_loc5_ < param1.length - 1)
            {
               if(param1.charAt(_loc5_) == "%")
               {
                  _loc9_ = param1.charAt(_loc5_ + 1);
                  if(_loc9_ != "%")
                  {
                     if(_loc9_ == "s")
                     {
                        _loc7_ = _loc5_;
                        _loc4_ = _loc4_ + param1.substring(_loc6_,_loc7_) + rest[_loc8_].toString();
                        _loc5_ += 2;
                        break;
                     }
                     if(_loc9_ == "d")
                     {
                        _loc7_ = _loc5_;
                        _loc4_ = _loc4_ + param1.substring(_loc6_,_loc7_) + rest[_loc8_].toString();
                        _loc5_ += 2;
                        break;
                     }
                     if(_loc9_ == "u")
                     {
                        _loc7_ = _loc5_;
                        _loc4_ = _loc4_ + param1.substring(_loc6_,_loc7_) + rest[_loc8_].toString();
                        _loc5_ += 2;
                        break;
                     }
                     _loc5_++;
                  }
               }
               _loc5_++;
            }
            _loc8_++;
         }
         return _loc4_;
      }
      
      public static function getStringBytes(param1:String, param2:int, param3:String) : ByteArray
      {
         var _loc4_:ByteArray = new ByteArray();
         var _loc5_:ByteArray = new ByteArray();
         if(0 < param2)
         {
            _loc4_.writeMultiByte(param1,param3);
            while(_loc4_.length < param2 - 1)
            {
               _loc4_.writeByte(0);
            }
            _loc4_.position = 0;
            _loc4_.readBytes(_loc5_,0,param2 - 1);
            _loc5_.position = _loc5_.length;
            _loc5_.writeByte(0);
            _loc5_.position = 0;
         }
         return _loc5_;
      }
      
      public static function getStringBytesLength(param1:String, param2:String) : uint
      {
         s_bytesTestString.length = s_bytesTestString.position = 0;
         s_bytesTestString.writeMultiByte(param1,param2);
         s_bytesTestString.position = 0;
         return s_bytesTestString.length;
      }
      
      public static function getTextByByteLength(param1:int, param2:String) : String
      {
         var _loc3_:int = 0;
         var _loc4_:* = null;
         _loc4_ = param2;
         param1 -= param1 % 2;
         _loc3_ = int(StringUtil.getStringBytesLength(param2,CharSet.GB2312));
         if(_loc3_ > param1)
         {
            _loc4_ = StringUtil.getTextByCharLength(_loc4_,param1 - 3 - (param1 - 3) % 2);
            _loc4_ = _loc4_ + "...";
         }
         return _loc4_;
      }
      
      public static function getTextByCharLength(param1:String, param2:int, param3:String = "gb2312") : String
      {
         if(param2 < 1)
         {
            return "";
         }
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeMultiByte(param1,param3);
         _loc4_.position = 0;
         return _loc4_.readMultiByte(Math.min(param2,_loc4_.bytesAvailable),param3);
      }
      
      public static function getTextByCharLengthEx(param1:String, param2:int, param3:String = "gb2312") : String
      {
         var _loc8_:uint = 0;
         if(param2 < 1)
         {
            return "";
         }
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeMultiByte(param1,param3);
         _loc4_.position = 0;
         var _loc5_:int = Math.min(param2,_loc4_.bytesAvailable);
         _loc4_.position = _loc5_ - 1;
         var _loc6_:int = 0;
         var _loc7_:int = _loc5_ - 1;
         while(_loc7_ >= 0)
         {
            _loc4_.position = _loc7_;
            _loc8_ = _loc4_.readUnsignedByte();
            if((_loc8_ & 0x80) == 0)
            {
               break;
            }
            _loc7_--;
         }
         if((_loc7_ + 1 - _loc5_) % 2 != 0)
         {
            _loc5_--;
         }
         _loc4_.position = 0;
         return _loc4_.readMultiByte(_loc5_,param3);
      }
      
      public static function isStringInRange(param1:String, param2:uint) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = Number(param1.charCodeAt(_loc4_));
            _loc3_ = false;
            if(true == Boolean(param2 & RANGE_NUMBERS))
            {
               if(_loc5_ >= CHAR_CODE_0 && _loc5_ <= CHAR_CODE_9)
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_ == false && true == Boolean(param2 & RANGE_LOWER_LETTER))
            {
               if(_loc5_ >= CHAR_CODE_LOWER_A && _loc5_ <= CHAR_CODE_LOWER_Z)
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_ == false && true == Boolean(param2 & RANGE_UPPER_LETTER))
            {
               if(_loc5_ >= CHAR_CODE_UPPER_A && _loc5_ <= CHAR_CODE_UPPER_Z)
               {
                  _loc3_ = true;
               }
            }
            if(_loc3_ == false)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public static function expendString(param1:String, param2:int) : String
      {
         if(null == param1)
         {
            param1 = "";
         }
         var _loc3_:int = param2 - param1.length;
         var _loc4_:String = param1;
         if(_loc3_ > 0)
         {
            while(_loc3_ > ms_sSpace.length)
            {
               ms_sSpace += ms_sSpace;
            }
            _loc4_ += ms_sSpace.substr(0,_loc3_);
         }
         return _loc4_;
      }
      
      public static function checkDirty(param1:String) : int
      {
         if(ms_mapDirtyString[param1])
         {
            return ms_mapDirtyString[param1];
         }
         if(implStringUtil)
         {
            implStringUtil.svrCheckDirty(param1);
         }
         return -1;
      }
      
      public function svrCheckDirty(param1:String) : void
      {
      }
   }
}

