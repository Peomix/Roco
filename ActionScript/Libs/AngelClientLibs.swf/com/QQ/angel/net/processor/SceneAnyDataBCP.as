package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_AnyData;
   
   public class SceneAnyDataBCP implements IDataProcessor
   {
      
      public function SceneAnyDataBCP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:P_AnyData = new P_AnyData();
         _loc3_.uin = _loc2_.readUnsignedInt();
         _loc3_.sceneID = _loc2_.readUnsignedShort();
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         _loc3_.readExternal(_loc2_);
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SceneAnyDataBC;
      }
   }
}

