package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class SKT_0x0C0001_QueryTaskConditionStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 786433;
       
      
      public var taskTaskId:uint;
      
      public var retCode:P_ReturnCode;
      
      public var taskConditionStatusArray:ByteArray;
      
      public var taskConditionStatusLength:uint;
      
      public function SKT_0x0C0001_QueryTaskConditionStatus_S2C()
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
         taskTaskId = param1.readUnsignedInt();
         taskConditionStatusLength = param1.readUnsignedShort();
         taskConditionStatusArray = new ByteArray();
         taskConditionStatusArray.position = 0;
         param1.readBytes(taskConditionStatusArray,0,taskConditionStatusLength);
         taskConditionStatusArray.length = taskConditionStatusLength;
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
