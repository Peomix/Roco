package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.ServerPushedSpirit;
   
   public class ServerPushedSpiritProcessor implements IDataProcessor
   {
       
      
      public function ServerPushedSpiritProcessor()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:ServerPushedSpirit = new ServerPushedSpirit();
         _loc3_.spiritID = _loc2_.readUnsignedInt();
         _loc3_.putTo = _loc2_.readUnsignedByte();
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SERVER_PUSH_SPIRIT;
      }
   }
}
