package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.TaskAchievement;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0E000B_CheckAchievementFinish_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 917515;
      
      public var arrlength:uint;
      
      public var returnCode:P_ReturnCode;
      
      public var achieveList:Array;
      
      public function SKT_0x0E000B_CheckAchievementFinish_S2C()
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
         arrlength = param1.readUnsignedShort();
         if(!achieveList)
         {
            achieveList = new Array(arrlength);
         }
         achieveList.length = arrlength;
         var _loc2_:int = 0;
         while(_loc2_ < arrlength)
         {
            achieveList[_loc2_] = new TaskAchievement();
            achieveList[_loc2_].readData(param1);
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

