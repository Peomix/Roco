package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class MagicInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var magicCount:uint;
      
      public var magicId:uint;
      
      public function MagicInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         magicId = param1.readUnsignedShort();
         magicCount = param1.readUnsignedShort();
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeShort(magicId);
         param1.writeShort(magicCount);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&magicId=" + magicId + "&magicCount=" + magicCount;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            magicId = uint(param1.magicId.text());
            magicCount = uint(param1.magicCount.text());
            return true;
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "MagicInfo";
      }
   }
}
