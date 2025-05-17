package com.QQ.angel.data.struct
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class Footprint extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var rocoNickName:String;
      
      public var visitUin:uint;
      
      public var happenTime:uint;
      
      public function Footprint()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         happenTime = param1.readUnsignedInt();
         visitUin = param1.readUnsignedInt();
         rocoNickName = DEFINE.ReadString(param1);
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(happenTime);
         param1.writeInt(visitUin);
         DEFINE.WriteString(param1,rocoNickName);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&happenTime=" + happenTime + "&visitUin=" + visitUin + "&rocoNickName=" + rocoNickName;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "Footprint";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            happenTime = uint(param1.happenTime.text());
            visitUin = uint(param1.visitUin.text());
            rocoNickName = String(param1.rocoNickName.text());
            return true;
         }
         return false;
      }
   }
}

