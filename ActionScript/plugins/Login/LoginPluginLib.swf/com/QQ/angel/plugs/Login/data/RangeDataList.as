package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class RangeDataList implements IAngelDataInput
   {
      
      public var roomTotal:uint;
      
      public var roomInfos:Array;
      
      public var roomBegin:uint;
      
      public var roomCount:uint;
      
      public var returnCode:P_ReturnCode;
      
      public function RangeDataList()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:RoomData = null;
         returnCode = ProtocolHelper.ReadCode(param1);
         if(!returnCode.isError())
         {
            roomBegin = param1.readUnsignedShort();
            roomCount = param1.readUnsignedShort();
            roomInfos = new Array();
            _loc2_ = 0;
            while(_loc2_ < roomCount)
            {
               _loc3_ = new RoomData();
               _loc3_.roomType = param1.readUnsignedByte();
               _loc3_.roomIndex = param1.readUnsignedShort();
               _loc3_.roomStat = param1.readUnsignedByte();
               _loc3_.roomLimit = param1.readUnsignedShort();
               _loc3_.roomPerson = param1.readUnsignedShort();
               _loc3_.roomAttr = param1.readUnsignedByte();
               _loc3_.roomIP = DEFINE.ReadIP(param1);
               _loc3_.roomZoneID = param1.readUnsignedInt();
               _loc3_.roomPort = param1.readUnsignedShort();
               _loc3_.roomCarrier = param1.readUnsignedByte();
               roomInfos.push(_loc3_);
               _loc3_ = null;
               _loc2_++;
            }
         }
      }
   }
}

