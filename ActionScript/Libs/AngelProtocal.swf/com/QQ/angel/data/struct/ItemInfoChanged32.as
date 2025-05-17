package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protoBuffMessage.ItemInfoChanged32_Message;
   import com.QQ.angel.data.protocolBase.*;
   import com.tencent.protobuf.Message;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ItemInfoChanged32 extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket, I_C2S_ProtoBuf, I_S2C_ProtoBuf
   {
      
      public var itemCount:int;
      
      public var itemId:uint;
      
      public function ItemInfoChanged32()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         itemId = param1.readUnsignedInt();
         itemCount = param1.readInt();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "ItemInfoChanged32";
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(itemId);
         param1.writeInt(itemCount);
         return true;
      }
      
      public function writeProtoBuf() : Message
      {
         var _loc1_:ItemInfoChanged32_Message = new ItemInfoChanged32_Message();
         _loc1_.itemId = itemId;
         _loc1_.itemCount = itemCount;
         return _loc1_;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&itemId=" + itemId + "&itemCount=" + itemCount;
      }
      
      public function getS2CMessage() : Message
      {
         return new ItemInfoChanged32_Message();
      }
      
      public function readProtoBuf(param1:Message) : Boolean
      {
         var _loc2_:ItemInfoChanged32_Message = ItemInfoChanged32_Message(param1);
         itemId = _loc2_.itemId;
         itemCount = _loc2_.itemCount;
         return true;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            itemId = uint(param1.itemId.text());
            itemCount = int(param1.itemCount.text());
            return true;
         }
         return false;
      }
   }
}

