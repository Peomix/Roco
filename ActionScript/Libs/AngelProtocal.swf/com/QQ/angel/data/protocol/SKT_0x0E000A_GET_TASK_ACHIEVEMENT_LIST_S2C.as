package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskAchievement;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0E000A_GET_TASK_ACHIEVEMENT_LIST_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 917514;
      
      public var achievementList:Array;
      
      public var achievementLength:uint;
      
      public var returnCode:P_ReturnCode;
      
      public function SKT_0x0E000A_GET_TASK_ACHIEVEMENT_LIST_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         returnCode = ProtocolHelper.ReadCode(param1);
         if(returnCode.code < 0)
         {
            return false;
         }
         achievementLength = param1.readUnsignedShort();
         if(!achievementList)
         {
            achievementList = new Array(achievementLength);
         }
         achievementList.length = achievementLength;
         var _loc2_:int = 0;
         while(_loc2_ < achievementLength)
         {
            achievementList[_loc2_] = new TaskAchievement();
            achievementList[_loc2_].readData(param1);
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

