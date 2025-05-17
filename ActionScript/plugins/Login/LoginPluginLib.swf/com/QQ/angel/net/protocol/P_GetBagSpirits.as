package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   
   public class P_GetBagSpirits implements IAngelDataInput
   {
      
      public var spiritDataCls:Class = P_BagSpiritData;
      
      public var code:P_ReturnCode;
      
      public var following:int;
      
      public var spirits:Array;
      
      public function P_GetBagSpirits()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc4_:P_BagSpiritData = null;
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         this.following = param1.readUnsignedByte();
         var _loc2_:int = int(param1.readUnsignedShort());
         this.spirits = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new this.spiritDataCls() as P_BagSpiritData;
            _loc4_.index = _loc3_ + 1;
            _loc4_.read(param1);
            this.spirits.push(_loc4_);
            _loc3_++;
         }
      }
   }
}

