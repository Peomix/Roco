package com.QQ.angel.utils
{
   import flash.geom.Point;
   
   public class AString
   {
      
      private static var __Vars:Object;
      
      private static var __Exp:RegExp = /\{([Z-z$_][^\}\{]+)\}/g;
       
      
      public function AString()
      {
         super();
      }
      
      public static function Trim(param1:String) : String
      {
         return param1.replace(/(^\s*)|(\s*$)/g,"");
      }
      
      public static function LTrim(param1:String) : String
      {
         return param1.replace(/(^\s*)/g,"");
      }
      
      public static function RTrim(param1:String) : String
      {
         return param1.replace(/(\s*$)/g,"");
      }
      
      public static function getFileName(param1:String) : String
      {
         var _loc2_:int = param1.lastIndexOf("/");
         if(_loc2_ == -1)
         {
            _loc2_ = param1.lastIndexOf("\\");
         }
         return param1.substring(_loc2_ + 1,param1.length);
      }
      
      public static function equalsIgnoreCase(param1:String, param2:String) : Boolean
      {
         return param1.toLowerCase() == param2.toLowerCase();
      }
      
      public static function equals(param1:String, param2:String) : Boolean
      {
         return param1 == param2;
      }
      
      public static function isEmail(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isNumber(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return !isNaN(Number(param1));
      }
      
      public static function isDouble(param1:String) : Boolean
      {
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /^[-\+]?\d+(\.\d+)?$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isInteger(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /^[-\+]?\d+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isEnglish(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /^[A-Za-z]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isChinese(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /^[Α-￥]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isDoubleChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /^[^\x00-\xff]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function hasChineseChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1);
         var _loc2_:RegExp = /[^\x00-\xff]/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function hasAccountChar(param1:String, param2:uint = 15) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param2 < 10)
         {
            param2 = 15;
         }
         param1 = AString.Trim(param1);
         var _loc3_:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + param2 + "}$","");
         var _loc4_:Object;
         if((_loc4_ = _loc3_.exec(param1)) == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isURL(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = AString.Trim(param1).toLowerCase();
         var _loc2_:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\’:+!]*([^<>\"\"])*$/;
         var _loc3_:RegExp = /^https:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\’:+!]*([^<>\"\"])*$/;
         var _loc4_:Object = _loc2_.exec(param1);
         var _loc5_:Object = _loc3_.exec(param1);
         if(_loc4_ == null && _loc5_ == null)
         {
            return false;
         }
         return true;
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
      
      public static function beginsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(0,param2.length);
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(param1.length - 1,param2.length);
      }
      
      public static function remove(param1:String, param2:String) : String
      {
         return replace(param1,param2,"\"");
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function replaceAt(param1:String, param2:String, param3:int, param4:int) : String
      {
         param3 = Math.max(param3,0);
         param4 = Math.min(param4,param1.length);
         var _loc5_:String = param1.substr(0,param3);
         var _loc6_:String = param1.substr(param4,param1.length);
         return _loc5_ + param2 + _loc6_;
      }
      
      public static function removeAt(param1:String, param2:int, param3:int) : String
      {
         return replaceAt(param1,"",param2,param3);
      }
      
      public static function fixNewlines(param1:String) : String
      {
         return param1.replace(/\r\n/gm,"\n");
      }
      
      public static function TranArgs(param1:String, param2:Object) : String
      {
         if(param2 == null || param1.indexOf("{") == -1 || param1.indexOf("}") == -1)
         {
            return param1;
         }
         __Vars = param2;
         param1 = param1.replace(__Exp,__Method);
         __Vars = null;
         return param1;
      }
      
      private static function __Method(... rest) : String
      {
         return __Vars[rest[1]];
      }
      
      public static function TranPoint(param1:String) : Point
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = param1.indexOf("|");
         if(_loc2_ != -1)
         {
            _loc3_ = int(param1.substring(0,_loc2_));
            _loc4_ = int(param1.substring(_loc2_ + 1,param1.length));
            return new Point(_loc3_,_loc4_);
         }
         return null;
      }
   }
}
