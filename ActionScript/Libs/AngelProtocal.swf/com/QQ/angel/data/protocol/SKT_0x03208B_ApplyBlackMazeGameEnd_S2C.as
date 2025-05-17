package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x03208B_ApplyBlackMazeGameEnd_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 204939;
      
      public var rewardLength:uint;
      
      public var rewardAray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x03208B_ApplyBlackMazeGameEnd_S2C()
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
         rewardLength = param1.readUnsignedShort();
         if(!rewardAray)
         {
            rewardAray = new Array(rewardLength);
         }
         rewardAray.length = rewardLength;
         var _loc2_:int = 0;
         while(_loc2_ < rewardLength)
         {
            rewardAray[_loc2_] = new ItemInfoChanged();
            rewardAray[_loc2_].readData(param1);
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

