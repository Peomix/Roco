package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   
   public class RoleOutInSceneP implements IMulDataProcessor
   {
      
      public function RoleOutInSceneP()
      {
         super();
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_SOneInScene,ADFCmdsType.T_SOneOutScene];
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         switch(param1.head.cmdID)
         {
            case ADFCmdsType.T_SOneInScene:
               trace("有新的人进入场景");
               return ProtocolHelper.ReadRoleData(_loc2_);
            case ADFCmdsType.T_SOneOutScene:
               trace("有人离开场景");
               return _loc2_.readUnsignedInt();
            default:
               return null;
         }
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return 0;
      }
   }
}

