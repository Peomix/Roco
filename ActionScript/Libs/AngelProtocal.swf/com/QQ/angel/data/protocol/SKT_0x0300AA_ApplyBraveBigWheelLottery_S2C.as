package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0300AA_ApplyBraveBigWheelLottery_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196778;
      
      public var itemArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public var rewardNumber:int;
      
      public var itemLength:uint;
      
      public function SKT_0x0300AA_ApplyBraveBigWheelLottery_S2C()
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
         itemLength = param1.readUnsignedShort();
         if(!itemArray)
         {
            itemArray = new Array(itemLength);
         }
         itemArray.length = itemLength;
         var _loc2_:int = 0;
         while(_loc2_ < itemLength)
         {
            itemArray[_loc2_] = new ItemInfoChanged();
            itemArray[_loc2_].readData(param1);
            _loc2_++;
         }
         rewardNumber = param1.readInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

