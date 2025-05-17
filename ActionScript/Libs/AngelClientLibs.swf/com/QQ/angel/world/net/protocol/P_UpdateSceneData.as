package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class P_UpdateSceneData implements IAngelDataInput
   {
      
      public var sceneID:int;
      
      public var values:ByteArray;
      
      public var code:P_ReturnCode;
      
      public function P_UpdateSceneData()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc2_:int = 0;
         this.code = ProtocolHelper.ReadCode(param1);
         if(!this.code.isError())
         {
            this.sceneID = param1.readUnsignedShort();
            this.values = new ByteArray();
            _loc2_ = int(param1.readUnsignedShort());
            param1.readBytes(this.values,0,_loc2_);
         }
      }
   }
}

