package com.tencent.fge.utils
{
   public class XmlUtil
   {
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
       
      
      public function XmlUtil()
      {
         super();
         throw new Error("XmlUtil只能静态使用！");
      }
      
      public static function xml2String(param1:String) : String
      {
         return param1.replace("<","＜").replace(">","＞");
      }
   }
}
