package com.QQ.angel.net.vo
{
   public class HomeFriendInfo
   {
      
      public static const ERROR_URL:String = "Error://";
      
      public var uin:uint;
      
      public var vipLevel:uint;
      
      public var score:uint;
      
      public var uinCode:String;
      
      public var version:uint;
      
      public var nickname:String;
      
      public var qqNickname:String;
      
      public var qqIconUrl:String;
      
      public var avetarUrl:String;
      
      public function HomeFriendInfo()
      {
         super();
      }
      
      public function get angleAvatarUrl() : String
      {
         return this.avetarUrl;
      }
      
      public function set angleAvatarUrl(param1:String) : void
      {
         this.avetarUrl = param1;
      }
   }
}

