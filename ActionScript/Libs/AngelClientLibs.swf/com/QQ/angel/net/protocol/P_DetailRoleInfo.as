package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class P_DetailRoleInfo implements IExternalizable
   {
      
      public var sex:int;
      
      public var nickName:String;
      
      public var level:int;
      
      public var avatarVer:int;
      
      public function P_DetailRoleInfo()
      {
         super();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.sex = param1.readByte();
         this.nickName = DEFINE.ReadChars(param1,DEFINE.L_NICKNAME);
         this.level = param1.readUnsignedShort();
         this.avatarVer = param1.readUnsignedShort();
      }
   }
}

