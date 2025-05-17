package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.CombatResultVo;
   
   public class P_CombatResultPush implements IDataProcessor
   {
      
      public function P_CombatResultPush()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:CombatResultVo = new CombatResultVo();
         _loc3_.uin = _loc2_.readUnsignedInt();
         _loc3_.state = _loc2_.readUnsignedByte();
         _loc3_.oUin = _loc2_.readUnsignedInt();
         _loc3_.oState = _loc2_.readUnsignedByte();
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.TYPE_COMBAT_END_PUSH;
      }
   }
}

