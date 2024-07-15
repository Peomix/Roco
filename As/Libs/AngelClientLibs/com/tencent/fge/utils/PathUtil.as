package com.tencent.fge.utils
{
   public class PathUtil
   {
       
      
      public function PathUtil()
      {
         super();
      }
      
      public static function isFullPath(param1:String) : Boolean
      {
         var _loc2_:String = param1.substr(0,7).toLocaleLowerCase();
         var _loc3_:Boolean = _loc2_ == "http://" || _loc2_ == "file://";
         if(!_loc3_)
         {
            _loc2_ = param1.substr(1,2);
            _loc3_ = _loc2_ == ":\\" || _loc2_ == ":/";
         }
         return _loc3_;
      }
      
      public static function makeFullPath(param1:String, param2:String, param3:Boolean) : String
      {
         if(param2 == null)
         {
            param2 = "";
         }
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2.length == 0)
         {
            if(param3)
            {
               return "";
            }
            return param1;
         }
         if(param1.length == 0)
         {
            return param2;
         }
         if(isFullPath(param2))
         {
            return param2;
         }
         var _loc4_:int = 0;
         var _loc5_:String = param2.charAt(_loc4_);
         while(_loc5_ == "/" || _loc5_ == "\\")
         {
            _loc4_++;
            _loc5_ = param2.charAt(_loc4_);
         }
         param2 = param2.substr(_loc4_);
         _loc4_ = param1.length - 1;
         _loc5_ = param1.charAt(_loc4_);
         while(_loc5_ == "/" || _loc5_ == "\\")
         {
            _loc4_--;
            _loc5_ = param1.charAt(_loc4_);
         }
         param1 = param1.substring(0,_loc4_ + 1);
         return param1 + "/" + param2;
      }
      
      public static function makePath(param1:String, param2:String, param3:Boolean) : String
      {
         var _loc4_:Boolean = false;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         if(param2 == null)
         {
            param2 = "";
         }
         if(param1 == null)
         {
            param1 = "";
         }
         if(param2.length == 0)
         {
            if(param3)
            {
               return "";
            }
            return param1;
         }
         if(param2.charAt(0) == "/" || param2.charAt(0) == "\\")
         {
            return param2;
         }
         _loc4_ = false;
         if(param2.substr(0,3) == "..\\" || param2.substr(0,3) == "../")
         {
            _loc5_ = "";
            _loc6_ = param1.lastIndexOf("\\");
            _loc7_ = param1.lastIndexOf("/");
            if((_loc6_ = Math.max(_loc6_,_loc7_)) > 0)
            {
               if(_loc6_ == param1.length - 1)
               {
                  _loc8_ = _loc6_ - 1;
                  _loc6_ = param1.lastIndexOf("\\",_loc8_);
                  _loc7_ = param1.lastIndexOf("/",_loc8_);
                  if((_loc6_ = Math.max(_loc6_,_loc7_)) >= 0)
                  {
                     _loc5_ = param1.substring(0,_loc6_ + 1);
                  }
                  else
                  {
                     _loc5_ = "";
                  }
               }
               else
               {
                  _loc5_ = param1.substring(0,_loc6_ + 1);
               }
               _loc4_ = true;
            }
            else if(_loc6_ == 0)
            {
               _loc4_ = false;
            }
            else
            {
               _loc5_ = "";
               if(param1.length == 0)
               {
                  _loc4_ = false;
               }
               else
               {
                  _loc4_ = true;
               }
            }
            if(_loc4_)
            {
               _loc9_ = param2.substr(3);
               return _loc5_ + _loc9_;
            }
         }
         return param1 + param2;
      }
   }
}
