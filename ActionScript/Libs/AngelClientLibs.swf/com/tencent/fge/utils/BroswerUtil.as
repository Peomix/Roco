package com.tencent.fge.utils
{
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   
   public class BroswerUtil
   {
      
      public static const WIN_TOP:String = "_top";
      
      public static const WIN_BLANK:String = "_blank";
      
      public function BroswerUtil()
      {
         super();
      }
      
      public static function refresh() : void
      {
         navigateToURL(new URLRequest(getHttpUrl()),"_top");
      }
      
      public static function openURL(param1:String, param2:String = null) : void
      {
         navigateToURL(new URLRequest(param1),param2);
      }
      
      public static function getHttpUrl() : String
      {
         return ExternalInterface.call("eval","window.location.href");
      }
      
      public static function setTitle(param1:String) : void
      {
         ExternalInterface.call("eval","document.title=\'" + param1 + "\';");
      }
      
      public static function getTitle() : String
      {
         return ExternalInterface.call("eval","document.title");
      }
      
      public static function getUrlArgs(param1:String = "") : Dictionary
      {
         var _loc3_:Dictionary = null;
         var _loc4_:Array = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         if(!param1)
         {
            param1 = getHttpUrl();
         }
         if(!param1)
         {
            param1 = "";
         }
         var _loc2_:int = int(param1.indexOf("?"));
         if(_loc2_ >= 0)
         {
            param1 = param1.substr(_loc2_ + 1);
            _loc4_ = param1.split("&");
            _loc2_ = 0;
            while(_loc2_ < _loc4_.length)
            {
               _loc5_ = _loc4_[_loc2_];
               if(_loc5_.length != 0)
               {
                  if(_loc3_ == null)
                  {
                     _loc3_ = new Dictionary();
                  }
                  _loc6_ = int(_loc5_.indexOf("="));
                  if(_loc6_ < 0)
                  {
                     _loc3_[_loc5_] = _loc5_;
                  }
                  else
                  {
                     _loc7_ = _loc5_.substr(0,_loc6_);
                     _loc8_ = _loc5_.substr(_loc6_ + 1);
                     _loc3_[_loc7_] = _loc8_;
                  }
               }
               _loc2_++;
            }
         }
         return _loc3_;
      }
   }
}

