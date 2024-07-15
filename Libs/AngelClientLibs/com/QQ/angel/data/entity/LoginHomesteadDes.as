package com.QQ.angel.data.entity
{
   public class LoginHomesteadDes extends NPCCDConvert
   {
       
      
      public var uin:uint;
      
      public var nickName:String;
      
      public function LoginHomesteadDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.uin = int(param1.@params);
         this.nickName = String(param1.@nickName);
      }
   }
}
