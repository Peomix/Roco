package com.tencent.fge.utils
{
   public class DateUtil
   {
      
      public static const SP_DATE:Array = [".","."];
      
      public static const SP_TIME:Array = [":",":"];
      
      public static const SP_FULL:Array = [".",".","_",":",":"];
       
      
      public function DateUtil()
      {
         super();
      }
      
      public static function formatDateToString(param1:Date, param2:Array = null) : String
      {
         if(param2 == null)
         {
            param2 = ["-","-"];
         }
         var _loc3_:String = param1.fullYear + param2[0] + num2string(param1.month + 1) + param2[1] + num2string(param1.date);
         if(param2.length > 2)
         {
            _loc3_ += param2[2];
         }
         return _loc3_;
      }
      
      public static function formatDateToStringEx(param1:Date, param2:String = "%y年%mon月%d日%h时%min分%s秒%ms毫秒") : String
      {
         var _loc3_:String = param2;
         _loc3_ = _loc3_.replace("%y",param1.fullYear);
         _loc3_ = _loc3_.replace("%mon",param1.month + 1);
         _loc3_ = _loc3_.replace("%d",param1.date);
         _loc3_ = _loc3_.replace("%h",param1.hours);
         _loc3_ = _loc3_.replace("%min",param1.minutes);
         _loc3_ = _loc3_.replace("%s",param1.seconds);
         return _loc3_.replace("%ms",param1.milliseconds);
      }
      
      public static function formatTimeToString(param1:Date, param2:Array = null, param3:Boolean = true) : String
      {
         var _loc4_:String = null;
         if(param2 == null)
         {
            param2 = [":",":"];
         }
         if(param3)
         {
            _loc4_ = num2string(param1.hours) + param2[0] + num2string(param1.minutes) + param2[1] + num2string(param1.seconds);
         }
         else
         {
            _loc4_ = num2string(param1.hours) + param2[0] + num2string(param1.minutes);
         }
         return _loc4_;
      }
      
      public static function formatToString(param1:Date, param2:Array = null) : String
      {
         if(param2 == null)
         {
            param2 = ["-","-"," ",":",":"];
         }
         return param1.fullYear + param2[0] + num2string(param1.month + 1) + param2[1] + num2string(param1.date) + param2[2] + num2string(param1.hours) + param2[3] + num2string(param1.minutes) + param2[4] + num2string(param1.seconds);
      }
      
      public static function formatSecondToStringEx(param1:Number, param2:int = 1) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(0 > param1)
         {
            param1 = 0;
         }
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc5_:String = "";
         if(0 < param2)
         {
            if(param1 > 86400)
            {
               _loc3_ = (_loc6_ = Math.floor(param1 / 86400)) * 86400;
               _loc5_ += _loc6_ + "天";
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            param2--;
         }
         if(0 < param2)
         {
            param1 -= _loc3_;
            if(param1 > 3600)
            {
               _loc3_ = (_loc7_ = Math.floor(param1 / 3600)) * 3600;
               _loc5_ += _loc7_ + "小时";
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            param2--;
         }
         if(0 < param2)
         {
            param1 -= _loc3_;
            if(param1 > 60)
            {
               _loc3_ = (_loc8_ = Math.floor(param1 / 60)) * 60;
               _loc5_ += _loc8_ + "分钟";
               _loc4_ = true;
            }
         }
         if(_loc4_)
         {
            param2--;
         }
         if(0 < param2)
         {
            param1 -= _loc3_;
            if(param1 >= 0)
            {
               _loc5_ += Math.round(param1) + "秒";
               _loc4_ = true;
            }
         }
         return _loc5_;
      }
      
      public static function formatSecondToString(param1:Number) : String
      {
         param1 = param1 < 0 ? 0 : param1;
         var _loc2_:* = "";
         if(param1 > 86400)
         {
            _loc2_ = Math.round(param1 / 86400) + "天";
         }
         else if(param1 > 3600)
         {
            _loc2_ = Math.round(param1 / 3600) + "小时";
         }
         else if(param1 > 60)
         {
            _loc2_ = Math.round(param1 / 60) + "分钟";
         }
         else
         {
            _loc2_ = Math.round(param1) + "秒";
         }
         return _loc2_;
      }
      
      public static function num2string(param1:int) : String
      {
         return param1 < 10 ? "0" + param1.toString() : param1.toString();
      }
      
      public static function formatStringToDate(param1:String) : Date
      {
         if(null == param1 || "" == param1)
         {
            return null;
         }
         var _loc2_:Array = param1.split(" ");
         if(null == _loc2_ || 2 != _loc2_.length)
         {
            return null;
         }
         var _loc3_:String = _loc2_[0];
         var _loc4_:Array = _loc3_.split("-");
         if(null == _loc4_ || 3 != _loc4_.length)
         {
            return null;
         }
         var _loc5_:String;
         var _loc6_:Array = (_loc5_ = _loc2_[1]).split(":");
         if(null == _loc6_ || 3 != _loc6_.length)
         {
            return null;
         }
         return new Date(_loc4_[0],_loc4_[1] - 1,_loc4_[2],_loc6_[0],_loc6_[1],_loc6_[2]);
      }
   }
}
