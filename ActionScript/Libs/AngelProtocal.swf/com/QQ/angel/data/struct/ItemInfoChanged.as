package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ItemInfoChanged extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var itemCount:int;
      
      public var itemId:uint;
      
      public function ItemInfoChanged()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         itemId = param1.readUnsignedInt();
         itemCount = param1.readShort();
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "ItemInfoChanged";
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(itemId);
         param1.writeShort(itemCount);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&itemId=" + itemId + "&itemCount=" + itemCount;
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

