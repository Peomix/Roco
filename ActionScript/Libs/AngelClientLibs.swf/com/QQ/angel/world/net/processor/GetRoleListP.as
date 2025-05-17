package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.QQ.angel.net.protocol.P_Short;
   
   public class GetRoleListP implements IDataProcessor
   {
      
      public function GetRoleListP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:P_ReturnCode = ProtocolHelper.ReadCode(_loc2_);
         if(_loc3_.isError() == false)
         {
            _loc4_ = {
               "error":false,
               "sceneID":_loc2_.readUnsignedShort()
            };
            _loc5_ = int(_loc2_.readUnsignedShort());
            _loc6_ = [];
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc6_.push(ProtocolHelper.ReadRoleData(_loc2_));
               _loc7_++;
            }
            _loc4_.roleDatas = _loc6_;
         }
         else
         {
            _loc4_ = {
               "error":true,
               "message":_loc3_.message
            };
         }
         trace("获取场景人物数据回发包.");
         return _loc4_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         trace("请求场景" + param1 + "人物数据.");
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         var _loc4_:P_Short = new P_Short();
         _loc4_.num = param1 as int;
         _loc3_.body = _loc4_;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_GetRoleList;
      }
   }
}

