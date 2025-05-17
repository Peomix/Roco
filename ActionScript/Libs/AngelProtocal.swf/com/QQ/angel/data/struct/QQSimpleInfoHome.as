package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class QQSimpleInfoHome extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var homeExp:uint;
      
      public var qqUin:uint;
      
      public function QQSimpleInfoHome()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         homeExp = param1.readUnsignedInt();
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(qqUin);
         param1.writeInt(homeExp);
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&qqUin=" + qqUin + "&homeExp=" + homeExp;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "QQSimpleInfoHome";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            qqUin = uint(param1.qqUin.text());
            homeExp = uint(param1.homeExp.text());
            return true;
         }
         return false;
      }
   }
}

