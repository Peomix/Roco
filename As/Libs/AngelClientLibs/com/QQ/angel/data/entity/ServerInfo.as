package com.QQ.angel.data.entity
{
   public class ServerInfo
   {
       
      
      public var dirHost:String = "127.0.0.1";
      
      public var dirPort:int = 443;
      
      public var roomHost:String = "127.0.0.1";
      
      public var roomPort:int = 443;
      
      public var roomName:String = "";
      
      public var roomID:int;
      
      public var sessionKey:String;
      
      public var skey:String;
      
      public var pskey:String;
      
      public var uin:uint;
      
      public var isFirstLogin:Boolean = false;
      
      public var date:Date;
      
      public var logHost:String = "127.0.0.1";
      
      public var logPort:int = 843;
      
      public function ServerInfo()
      {
         this.date = new Date();
         super();
      }
   }
}
