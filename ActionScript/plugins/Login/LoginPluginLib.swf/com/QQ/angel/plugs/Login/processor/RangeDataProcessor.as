package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.plugs.Login.data.RangeDataList;
   import com.QQ.angel.plugs.Login.data.ReqRangeData;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class RangeDataProcessor extends EventDispatcher implements IMulDataProcessor
   {
      
      private var rangeData:RangeDataList = new RangeDataList();
      
      public function RangeDataProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function decode(param1:ADF) : Object
      {
         rangeData.read(param1.body);
         return rangeData;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         var _loc4_:ReqRangeData = new ReqRangeData();
         _loc4_.roomBegin = param1["start"];
         _loc4_.roomCount = param1["stop"] - param1["start"] + 1;
         _loc4_.sessionKey = param1.sessionKey as String;
         _loc3_.body = _loc4_;
         return _loc3_;
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_DIR_RANGE_REPLY,ADFCmdsType.T_DIR_RANGE_REQ];
      }
      
      public function getADFType() : int
      {
         return 0;
      }
   }
}

