package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class ReqRangeData implements IAngelDataOutput
   {
      
      public var roomCount:uint;
      
      public var sessionKey:String;
      
      public var roomBegin:uint;
      
      public function ReqRangeData()
      {
         super();
      }
      
      public function get length() : uint
      {
         return 68;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(roomBegin);
         param1.writeShort(roomCount);
         param1.writeUTFBytes(sessionKey);
      }
   }
}

