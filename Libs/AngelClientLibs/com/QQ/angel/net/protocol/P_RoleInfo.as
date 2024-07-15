package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class P_RoleInfo implements IExternalizable
   {
       
      
      public var uin:uint;
      
      public var nickName:String;
      
      public var level:uint;
      
      public var avatarVer:uint;
      
      public var position:Point;
      
      public var direction:int;
      
      public var hasPet:int;
      
      public function P_RoleInfo()
      {
         super();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.uin = param1.readUnsignedInt();
         this.nickName = DEFINE.ReadChars(param1,DEFINE.L_NICKNAME);
         this.level = param1.readUnsignedShort();
         this.avatarVer = param1.readUnsignedShort();
         this.position = DEFINE.ReadPoint(param1);
         this.direction = param1.readShort();
         this.hasPet = param1.readByte();
      }
   }
}
