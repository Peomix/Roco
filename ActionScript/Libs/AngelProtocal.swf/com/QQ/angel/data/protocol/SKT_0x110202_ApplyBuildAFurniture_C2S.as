package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x110202_ApplyBuildAFurniture_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 1114626;
      
      public var posX:int;
      
      public var posY:int;
      
      public var floor:uint;
      
      public var itemId:uint;
      
      public function SKT_0x110202_ApplyBuildAFurniture_C2S()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(itemId);
         param1.writeShort(floor);
         param1.writeInt(posX);
         param1.writeInt(posY);
         return true;
      }
   }
}

