package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_ReqSceneChange implements IAngelDataOutput
   {
      
      public var oldSceneID:int;
      
      public var newSceneID:int;
      
      public var uin:uint = 0;
      
      public var ver:int;
      
      public function P_ReqSceneChange()
      {
         super();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(this.oldSceneID);
         param1.writeShort(this.newSceneID);
         param1.writeUnsignedInt(this.uin);
         param1.writeShort(this.ver);
      }
      
      public function get length() : uint
      {
         return 10;
      }
   }
}

