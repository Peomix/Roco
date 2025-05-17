package com.QQ.angel.data.struct
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class QQDetailInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var qqIconUrl:String;
      
      public var vipLevel:uint;
      
      public var qqNickname:String;
      
      public var uinCode:String;
      
      public var rocoNickname:String;
      
      public var version:uint;
      
      public var qqUin:uint;
      
      public function QQDetailInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         vipLevel = param1.readUnsignedShort();
         uinCode = DEFINE.ReadChars(param1,32);
         version = param1.readUnsignedShort();
         rocoNickname = DEFINE.ReadString(param1);
         qqNickname = DEFINE.ReadString(param1);
         qqIconUrl = DEFINE.ReadString(param1);
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(qqUin);
         param1.writeShort(vipLevel);
         DEFINE.WriteChars(param1,uinCode,32);
         param1.writeShort(version);
         DEFINE.WriteString(param1,rocoNickname);
         DEFINE.WriteString(param1,qqNickname);
         DEFINE.WriteString(param1,qqIconUrl);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "QQDetailInfo";
      }
      
      public function encodeCGI() : String
      {
         return "" + "&qqUin=" + qqUin + "&vipLevel=" + vipLevel + "&uinCode=" + uinCode + "&version=" + version + "&rocoNickname=" + rocoNickname + "&qqNickname=" + qqNickname + "&qqIconUrl=" + qqIconUrl;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            qqUin = uint(param1.qqUin.text());
            vipLevel = uint(param1.vipLevel.text());
            uinCode = String(param1.uinCode.text());
            version = uint(param1.version.text());
            rocoNickname = String(param1.rocoNickname.text());
            qqNickname = String(param1.qqNickname.text());
            qqIconUrl = String(param1.qqIconUrl.text());
            return true;
         }
         return false;
      }
   }
}

