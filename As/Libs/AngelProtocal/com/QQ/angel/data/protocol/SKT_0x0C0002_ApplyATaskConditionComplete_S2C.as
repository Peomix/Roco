package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0C0002_ApplyATaskConditionComplete_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 786434;
       
      
      public var taskConditionNpcId:uint;
      
      public var itemInfoChangedArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public var itemInfoChangedLength:uint;
      
      public function SKT_0x0C0002_ApplyATaskConditionComplete_S2C()
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
         taskConditionNpcId = param1.readUnsignedInt();
         itemInfoChangedLength = param1.readUnsignedShort();
         if(!itemInfoChangedArray)
         {
            itemInfoChangedArray = new Array(itemInfoChangedLength);
         }
         itemInfoChangedArray.length = itemInfoChangedLength;
         var _loc2_:int = 0;
         while(_loc2_ < itemInfoChangedLength)
         {
            itemInfoChangedArray[_loc2_] = new ItemInfoChanged();
            itemInfoChangedArray[_loc2_].readData(param1);
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
