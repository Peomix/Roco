package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.plugs.Login.data.RecommendDataList;
   import com.QQ.angel.plugs.Login.data.ReqRoomDataBody;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class RecommendDataProcessor extends EventDispatcher implements IMulDataProcessor
   {
      
      private var roomData:RecommendDataList = new RecommendDataList();
      
      public function RecommendDataProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = null;
         var _loc4_:ReqRoomDataBody = null;
         _loc3_ = ProtocolHelper.CreateADF(param2);
         _loc3_.head.version = 1;
         _loc4_ = new ReqRoomDataBody();
         _loc4_.hisRoomCount = param1.hisRoomCount;
         _loc4_.hotRoomCount = param1.hotRoomCount;
         _loc4_.lessRoomCount = param1.lessRoomCount;
         _loc4_.otherRoomCount = param1.otherRoomCount;
         _loc4_.sessionKey = param1.sessionKey;
         _loc3_.body = _loc4_;
         trace("[RecommendDataProcessor] 发送成功!!");
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return 0;
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_DIR_RECOMMEND_REQ,ADFCmdsType.T_DIR_RECOMMEND_REPLY];
      }
      
      public function decode(param1:ADF) : Object
      {
         roomData.read(param1.body);
         return roomData;
      }
   }
}

