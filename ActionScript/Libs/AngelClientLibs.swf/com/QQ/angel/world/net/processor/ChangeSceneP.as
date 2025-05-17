package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class ChangeSceneP implements IDataProcessor
   {
      
      public function ChangeSceneP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:P_ReturnCode = ProtocolHelper.ReadCode(_loc2_);
         var _loc4_:Object = {};
         if(_loc3_.isError() == false)
         {
            _loc4_ = {
               "error":false,
               "message":_loc3_.message,
               "sceneID":_loc2_.readUnsignedShort(),
               "ver":_loc2_.readUnsignedShort(),
               "roleData":ProtocolHelper.ReadRoleData(_loc2_)
            };
         }
         else
         {
            _loc4_.error = true;
            _loc4_.code = _loc3_.code;
            _loc4_.message = _loc3_.message;
         }
         return _loc4_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = param1;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_ChangeScene;
      }
   }
}

