package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class RecommendDataList implements IAngelDataInput
   {
      
      public var roomInfos:Array;
      
      public var totalNum:uint;
      
      public var hisRoom:Array;
      
      public var returnCode:P_ReturnCode;
      
      public function RecommendDataList()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc3_:RoomData = null;
         roomInfos = new Array();
         hisRoom = new Array();
         returnCode = ProtocolHelper.ReadCode(param1);
         totalNum = param1.readUnsignedShort();
         var _loc2_:uint = 0;
         while(_loc2_ < totalNum)
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

