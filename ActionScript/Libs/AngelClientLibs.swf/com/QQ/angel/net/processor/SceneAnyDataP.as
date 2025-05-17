package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_AnyData;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   
   public class SceneAnyDataP implements IDataProcessor
   {
      
      public function SceneAnyDataP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         return ProtocolHelper.ReadCode(_loc2_);
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         var _loc4_:P_AnyData = param1 as P_AnyData;
         var _loc5_:ByteArray = new ByteArray();
         _loc5_.writeShort(_loc4_.sceneID);
         _loc5_.writeShort(0);
         _loc4_.writeExternal(_loc5_);
         var _loc6_:int = _loc5_.length - 4;
         _loc5_.position = 2;
         _loc5_.writeShort(_loc6_);
         _loc5_.position = 0;
         _loc3_.body = _loc5_;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SceneAnyData;
      }
   }
}

