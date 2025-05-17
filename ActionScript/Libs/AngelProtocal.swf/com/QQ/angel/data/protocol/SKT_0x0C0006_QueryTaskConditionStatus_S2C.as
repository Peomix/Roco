package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskCondInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0C0006_QueryTaskConditionStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 786438;
      
      public var taskID:uint;
      
      public var condArrLength:uint;
      
      public var retCode:P_ReturnCode;
      
      public var condArr:Array;
      
      public function SKT_0x0C0006_QueryTaskConditionStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         taskID = param1.readUnsignedInt();
         condArrLength = param1.readUnsignedShort();
         if(!condArr)
         {
            condArr = new Array(condArrLength);
         }
         condArr.length = condArrLength;
         var _loc2_:int = 0;
         while(_loc2_ < condArrLength)
         {
            condArr[_loc2_] = new TaskCondInfo();
            condArr[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
   }
}

