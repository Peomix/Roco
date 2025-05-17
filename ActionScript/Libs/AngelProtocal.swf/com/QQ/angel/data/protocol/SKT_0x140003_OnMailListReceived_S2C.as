package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.MailInfo;
   import flash.utils.IDataInput;
   
   public class SKT_0x140003_OnMailListReceived_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1310723;
      
      public var mailInfoArray:Array;
      
      public var qqUin:uint;
      
      public var mailInfoLength:uint;
      
      public function SKT_0x140003_OnMailListReceived_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         mailInfoLength = param1.readUnsignedShort();
         if(!mailInfoArray)
         {
            mailInfoArray = new Array(mailInfoLength);
         }
         mailInfoArray.length = mailInfoLength;
         var _loc2_:int = 0;
         while(_loc2_ < mailInfoLength)
         {
            mailInfoArray[_loc2_] = new MailInfo();
            mailInfoArray[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

