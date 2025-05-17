package com.QQ.angel.data.protocol
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x120007_ApplyManorWeed_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 1179655;
      
      public var qqUin:uint;
      
      public var groundId:uint;
      
      public var type:uint;
      
      public function SKT_0x120007_ApplyManorWeed_C2S()
      {
         super();
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(qqUin);
         param1.writeByte(groundId);
         param1.writeByte(type);
         __global.WritePtloginSign(param1);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

