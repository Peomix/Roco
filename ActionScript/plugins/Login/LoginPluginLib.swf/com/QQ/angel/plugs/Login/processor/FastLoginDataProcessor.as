package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.QQ.angel.plugs.Login.data.RangeDataList;
   import com.QQ.angel.plugs.Login.data.ReqFastLoginData;
   import com.QQ.angel.plugs.Login.data.RoomData;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class FastLoginDataProcessor extends EventDispatcher implements IMulDataProcessor
   {
      
      public var returnCode:P_ReturnCode;
      
      private var rangeData:RangeDataList = new RangeDataList();
      
      public function FastLoginDataProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         returnCode = ProtocolHelper.ReadCode(_loc2_);
         if(returnCode.code != 0)
         {
            return null;
         }
         var _loc3_:RoomData = new RoomData();
         _loc3_.roomType = _loc2_.readUnsignedByte();
         _loc3_.roomIndex = _loc2_.readUnsignedShort();
         _loc3_.roomStat = _loc2_.readUnsignedByte();
         _loc3_.roomLimit = _loc2_.readUnsignedShort();
         _loc3_.roomPerson = _loc2_.readUnsignedShort();
         _loc3_.roomAttr = _loc2_.readUnsignedByte();
         _loc3_.roomIP = DEFINE.ReadIP(_loc2_);
         _loc3_.roomZoneID = _loc2_.readUnsignedInt();
         _loc3_.roomPort = _loc2_.readUnsignedShort();
         _loc3_.roomCarrier = _loc2_.readUnsignedByte();
         return _loc3_;
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_DIR_FAST_GETIN];
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ReqFastLoginData = new ReqFastLoginData();
         var _loc4_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.sessionKey = param1.sessionKey;
         _loc4_.body = _loc3_;
         return _loc4_;
      }
      
      public function getADFType() : int
      {
         return 0;
      }
   }
}

