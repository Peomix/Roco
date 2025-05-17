package com.tencent.fge.utils
{
   public class TimeUtils
   {
      
      public static const SECONDS_PRE_DAY:int = 86400;
      
      public static const SECONDS_PRE_HOUR:int = 3600;
      
      public static const SECONDS_PRE_MINUTE:int = 60;
      
      public function TimeUtils()
      {
         super();
      }
      
      public static function getTimeFormatString(param1:Date) : String
      {
         var _loc2_:* = "";
         _loc2_ += param1.fullYear;
         _loc2_ += "-";
         _loc2_ += fillTwoDigitFormat(param1.month + 1);
         _loc2_ += "-";
         _loc2_ += fillTwoDigitFormat(param1.date);
         _loc2_ += " ";
         _loc2_ += fillTwoDigitFormat(param1.hours);
         _loc2_ += ":";
         _loc2_ += fillTwoDigitFormat(param1.minutes);
         _loc2_ += ":";
         return _loc2_ + fillTwoDigitFormat(param1.seconds);
      }
      
      public static function getHourStringBySeconds(param1:int) : String
      {
         var _loc2_:* = "";
         _loc2_ += fillTwoDigitFormat(getHoursBySeconds(param1));
         _loc2_ += ":";
         _loc2_ += fillTwoDigitFormat(getMinutesBySeconds(param1));
         _loc2_ += ":";
         return _loc2_ + fillTwoDigitFormat(getSecondsBySeconds(param1));
      }
      
      public static function getMinuteStringBySeconds(param1:int) : String
      {
         var _loc2_:* = "";
         _loc2_ += fillTwoDigitFormat(getMinutesBySeconds(param1));
         _loc2_ += "分";
         _loc2_ += fillTwoDigitFormat(getSecondsBySeconds(param1));
         return _loc2_ + "秒";
      }
      
      public static function readFullDateTime(param1:String) : Date
      {
         var dataStr:String = null;
         var dataArr:Array = null;
         var dateOnly:Date = null;
         var timeOnly:Date = null;
         var time:String = param1;
         var date:Date = null;
         try
         {
            dataStr = time;
            dataArr = dataStr.split(" ");
            if(dataArr.length == 2)
            {
               dateOnly = readOnlyDate(dataArr[0]);
               timeOnly = readOnlyTime(dataArr[1]);
               if(Boolean(dateOnly) && Boolean(timeOnly))
               {
                  date = new Date(dateOnly.fullYear,dateOnly.month,dateOnly.date,timeOnly.hours - 8 < 0 ? timeOnly.hours + 16 : timeOnly.hours - 8,timeOnly.minutes,timeOnly.seconds);
               }
            }
         }
         catch(e:Error)
         {
            trace("invalid DateTime!");
         }
         return date;
      }
      
      public static function readOnlyDate(param1:String) : Date
      {
         var dateArr:Array = null;
         var year:int = 0;
         var month:int = 0;
         var day:int = 0;
         var time:String = param1;
         var date:Date = null;
         try
         {
            dateArr = time.split("-");
            if(dateArr.length == 3)
            {
               year = int(dateArr[0]);
               month = int(dateArr[1]) - 1;
               day = int(dateArr[2]);
               date = new Date(year,month,day);
            }
         }
         catch(e:Error)
         {
            trace("invalid DateTime!");
         }
         return date;
      }
      
      public static function readOnlyTime(param1:String) : Date
      {
         var timeArr:Array = null;
         var hour:int = 0;
         var minute:int = 0;
         var second:int = 0;
         var time:String = param1;
         var date:Date = null;
         try
         {
            timeArr = time.split(":");
            if(timeArr.length == 3)
            {
               hour = int(timeArr[0]);
               minute = int(timeArr[1]);
               second = int(timeArr[2]);
               date = new Date(1970,0,1,hour + 8,minute,second);
            }
         }
         catch(e:Error)
         {
            trace("invalid DateTime!");
         }
         return date;
      }
      
      public static function getDaysBySeconds(param1:int) : int
      {
         return param1 / SECONDS_PRE_DAY;
      }
      
      private static function getHoursBySeconds(param1:int) : int
      {
         return param1 % SECONDS_PRE_DAY / SECONDS_PRE_HOUR;
      }
      
      private static function getMinutesBySeconds(param1:int) : int
      {
         return param1 % SECONDS_PRE_HOUR / SECONDS_PRE_MINUTE;
      }
      
      private static function getSecondsBySeconds(param1:int) : int
      {
         return param1 % SECONDS_PRE_MINUTE;
      }
      
      private static function fillTwoDigitFormat(param1:int) : String
      {
         var _loc2_:String = "";
         if(param1 < 10 && param1 >= 0)
         {
            _loc2_ = "0" + param1.toString();
         }
         else if(param1 >= 10 && param1 < 100)
         {
            _loc2_ = param1.toString();
         }
         else
         {
            _loc2_ = "FF";
         }
         return _loc2_;
      }
   }
}

