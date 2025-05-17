package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.QQ.angel.world.net.protocol.P_SubBC_Paths;
   
   public class RoadSubBCP implements IMulDataProcessor
   {
      
      public function RoadSubBCP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc4_:P_ReturnCode = null;
         var _loc5_:P_SubBC_Paths = null;
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:int = int(param1.head.cmdID);
         if(_loc3_ == ADFCmdsType.T_RoadPosSub)
         {
            _loc4_ = ProtocolHelper.ReadCode(_loc2_);
            if(_loc4_.isError())
            {
               trace("移动广播错误:" + _loc4_.message);
            }
            return _loc4_;
         }
         _loc5_ = new P_SubBC_Paths();
         _loc5_.read(_loc2_);
         return _loc5_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         if(param2 != ADFCmdsType.T_RoadPosSub)
         {
            return null;
         }
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = param1;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return 0;
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_RoadPosSub,ADFCmdsType.T_RoadPosBC];
      }
   }
}

