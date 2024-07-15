package com.QQ.angel.data.struct
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class QQRewadInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var infomation:String;
      
      public var qqUin:uint;
      
      public var timeStamp:uint;
      
      public function QQRewadInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         timeStamp = param1.readUnsignedInt();
         infomation = DEFINE.ReadString(param1);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&qqUin=" + qqUin + "&timeStamp=" + timeStamp + "&infomation=" + infomation;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(qqUin);
         param1.writeInt(timeStamp);
         DEFINE.WriteString(param1,infomation);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "QQRewadInfo";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            qqUin = uint(param1.qqUin.text());
            timeStamp = uint(param1.timeStamp.text());
            infomation = String(param1.infomation.text());
            return true;
         }
         return false;
      }
   }
}
