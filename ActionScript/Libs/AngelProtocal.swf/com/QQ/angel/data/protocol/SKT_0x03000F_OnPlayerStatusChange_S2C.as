package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x03000F_OnPlayerStatusChange_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196623;
      
      public var swimItem:uint;
      
      public var flyMode:uint;
      
      public var flashType:uint;
      
      public var swimMode:uint;
      
      public var vipLulu:uint;
      
      public var act:uint;
      
      public var isVip:uint;
      
      public var rideType:uint;
      
      public var petId:uint;
      
      public var vipExpire:uint;
      
      public var pkState:uint;
      
      public var uin:uint;
      
      public var flyItem:uint;
      
      public var vipLevel:uint;
      
      public var isMagicBlock:uint;
      
      public var cursedType:uint;
      
      public var summonType:uint;
      
      public function SKT_0x03000F_OnPlayerStatusChange_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         uin = param1.readUnsignedInt();
         act = param1.readUnsignedByte();
         flyMode = param1.readUnsignedByte();
         flyItem = param1.readUnsignedInt();
         swimMode = param1.readUnsignedByte();
         swimItem = param1.readUnsignedInt();
         cursedType = param1.readUnsignedShort();
         flashType = param1.readUnsignedShort();
         summonType = param1.readUnsignedShort();
         rideType = param1.readUnsignedShort();
         petId = param1.readUnsignedInt();
         isVip = param1.readUnsignedByte();
         vipLevel = param1.readUnsignedByte();
         vipLulu = param1.readUnsignedByte();
         vipExpire = param1.readUnsignedInt();
         isMagicBlock = param1.readUnsignedByte();
         pkState = param1.readUnsignedByte();
         return true;
      }
   }
}

