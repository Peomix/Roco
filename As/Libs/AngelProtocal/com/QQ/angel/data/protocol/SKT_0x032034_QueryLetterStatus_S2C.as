package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SKT_0x032034_QueryLetterStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204852;
       
      
      public var letterNum:Array;
      
      public var eggStatus:ByteArray;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x032034_QueryLetterStatus_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         letterNum = new Array();
         letterNum.length = 6;
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            letterNum[_loc2_] = param1.readUnsignedShort();
            _loc2_++;
         }
         eggStatus = new ByteArray();
         eggStatus.position = 0;
         param1.readBytes(eggStatus,0,11);
         eggStatus.length = 11;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
