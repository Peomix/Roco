package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300A9_QueryBraveBigWheelStatus_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196777;
       
      
      public var ticketNum:int;
      
      public var isInGameTime:int;
      
      public var retCode:P_ReturnCode;
      
      public var isFirstOpen:int;
      
      public var lotteryRemain:int;
      
      public var lotteryTimes:int;
      
      public function SKT_0x0300A9_QueryBraveBigWheelStatus_S2C()
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
         isInGameTime = param1.readInt();
         isFirstOpen = param1.readInt();
         ticketNum = param1.readInt();
         lotteryTimes = param1.readInt();
         lotteryRemain = param1.readInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
