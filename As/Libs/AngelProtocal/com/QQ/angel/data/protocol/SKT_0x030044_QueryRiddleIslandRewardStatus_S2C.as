package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import flash.utils.IDataInput;
   
   public class SKT_0x030044_QueryRiddleIslandRewardStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196676;
       
      
      public var rewardArray:Array;
      
      public var rewardLength:uint;
      
      public var rightAnswerNum:uint;
      
      public function SKT_0x030044_QueryRiddleIslandRewardStatus_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         rightAnswerNum = param1.readUnsignedInt();
         rewardLength = param1.readUnsignedShort();
         if(!rewardArray)
         {
            rewardArray = new Array(rewardLength);
         }
         rewardArray.length = rewardLength;
         var _loc2_:int = 0;
         while(_loc2_ < rewardLength)
         {
            rewardArray[_loc2_] = new ItemInfoChanged();
            rewardArray[_loc2_].readData(param1);
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
