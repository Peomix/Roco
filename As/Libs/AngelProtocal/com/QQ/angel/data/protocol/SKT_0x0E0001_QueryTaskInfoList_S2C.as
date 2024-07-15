package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0E0001_QueryTaskInfoList_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 917505;
       
      
      public var retCode:P_ReturnCode;
      
      public var taskInfoListLength:uint;
      
      public var taskInfoListArray:Array;
      
      public function SKT_0x0E0001_QueryTaskInfoList_S2C()
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
         taskInfoListLength = param1.readUnsignedShort();
         if(!taskInfoListArray)
         {
            taskInfoListArray = new Array(taskInfoListLength);
         }
         taskInfoListArray.length = taskInfoListLength;
         var _loc2_:int = 0;
         while(_loc2_ < taskInfoListLength)
         {
            taskInfoListArray[_loc2_] = new TaskInfo();
            taskInfoListArray[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
   }
}
