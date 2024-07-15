package com.QQ.angel.data.struct
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class MailInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var mailStatus:uint;
      
      public var mailTtileLength:uint;
      
      public var mailId:String;
      
      public var mailType:uint;
      
      public var mailReceiveTime:int;
      
      public var mailTtileString:String;
      
      public function MailInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         mailId = DEFINE.ReadChars(param1,36);
         mailTtileLength = param1.readUnsignedShort();
         mailTtileString = DEFINE.ReadChars(param1,mailTtileLength);
         mailStatus = param1.readUnsignedByte();
         mailType = param1.readUnsignedByte();
         mailReceiveTime = param1.readInt();
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         DEFINE.WriteChars(param1,mailId,36);
         param1.writeShort(mailTtileLength);
         DEFINE.WriteChars(param1,mailTtileString,mailTtileLength);
         param1.writeByte(mailStatus);
         param1.writeByte(mailType);
         param1.writeInt(mailReceiveTime);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&mailId=" + mailId + "&mailTtileLength=" + mailTtileLength + "&mailTtileString=" + mailTtileString + "&mailStatus=" + mailStatus + "&mailType=" + mailType + "&mailReceiveTime=" + mailReceiveTime;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "MailInfo";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            mailId = String(param1.mailId.text());
            mailTtileLength = uint(param1.mailTtileLength.text());
            mailTtileString = String(param1.mailTtileString.text());
            mailStatus = uint(param1.mailStatus.text());
            mailType = uint(param1.mailType.text());
            mailReceiveTime = int(param1.mailReceiveTime.text());
            return true;
         }
         return false;
      }
   }
}
