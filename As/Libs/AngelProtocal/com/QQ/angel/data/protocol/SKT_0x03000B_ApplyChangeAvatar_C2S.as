package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x03000B_ApplyChangeAvatar_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 196619;
       
      
      public var avatar:Array;
      
      public function SKT_0x03000B_ApplyChangeAvatar_C2S()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         var _loc2_:int = 0;
         if(avatar)
         {
            _loc2_ = 0;
            while(_loc2_ < 9)
            {
               param1.writeInt(avatar[_loc2_]);
               _loc2_++;
            }
         }
         return true;
      }
   }
}
