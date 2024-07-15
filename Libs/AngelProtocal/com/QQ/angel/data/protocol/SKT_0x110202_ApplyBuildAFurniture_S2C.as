package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoUpdated;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x110202_ApplyBuildAFurniture_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1114626;
       
      
      public var success:uint;
      
      public var posX:int;
      
      public var posY:int;
      
      public var floor:uint;
      
      public var itemId:uint;
      
      public var eventId:uint;
      
      public var itemInfoUpdatedLength:uint;
      
      public var exp:uint;
      
      public var retCode:P_ReturnCode;
      
      public var itemGroupId:int;
      
      public var itemInfoArray:Array;
      
      public function SKT_0x110202_ApplyBuildAFurniture_S2C()
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
         exp = param1.readUnsignedInt();
         itemInfoUpdatedLength = param1.readUnsignedShort();
         if(!itemInfoArray)
         {
            itemInfoArray = new Array(itemInfoUpdatedLength);
         }
         itemInfoArray.length = itemInfoUpdatedLength;
         var _loc2_:int = 0;
         while(_loc2_ < itemInfoUpdatedLength)
         {
            itemInfoArray[_loc2_] = new ItemInfoUpdated();
            itemInfoArray[_loc2_].readData(param1);
            _loc2_++;
         }
         success = param1.readUnsignedByte();
         itemId = param1.readUnsignedInt();
         itemGroupId = param1.readInt();
         floor = param1.readUnsignedShort();
         posX = param1.readInt();
         posY = param1.readInt();
         eventId = param1.readUnsignedInt();
         return true;
      }
   }
}
