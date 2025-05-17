package com.QQ.angel.data.protocol
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x100002_QueryQQDetailInfo_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 1048578;
      
      public var friendUinArrayLength:uint;
      
      public var ip:uint;
      
      public var friendUinArray:Array;
      
      public function SKT_0x100002_QueryQQDetailInfo_C2S()
      {
         super();
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         var _loc2_:int = 0;
         __global.WritePtloginSign(param1);
         param1.writeShort(friendUinArrayLength);
         if(friendUinArray)
         {
            _loc2_ = 0;
            while(_loc2_ < friendUinArrayLength)
            {
               param1.writeInt(friendUinArray[_loc2_]);
               _loc2_++;
            }
         }
         param1.writeInt(ip);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

