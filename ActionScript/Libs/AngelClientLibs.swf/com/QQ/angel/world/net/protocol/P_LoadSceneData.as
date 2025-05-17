package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_LoadSceneData implements IAngelDataInput, IAngelDataOutput
   {
      
      public var sceneID:int;
      
      public var code:P_ReturnCode;
      
      public var values:ByteArray;
      
      public function P_LoadSceneData(param1:int = 0)
      {
         super();
         this.sceneID = param1;
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
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(this.sceneID);
      }
      
      public function get length() : uint
      {
         return 2;
      }
   }
}

