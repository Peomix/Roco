package com.QQ.angel.plugs.Login.data
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class ReqRoomDataBody implements IAngelDataOutput
   {
      
      public var hisRoomCount:uint = 0;
      
      public var otherRoomCount:uint = 0;
      
      public var hotRoomCount:uint = 0;
      
      public var sessionKey:String;
      
      public var lessRoomCount:uint = 0;
      
      public function ReqRoomDataBody()
      {
         super();
      }
      
      public function get length() : uint
      {
         return 72;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(hisRoomCount);
         param1.writeShort(hotRoomCount);
         param1.writeShort(lessRoomCount);
         param1.writeShort(otherRoomCount);
         param1.writeUTFBytes(sessionKey);
      }
   }
}

