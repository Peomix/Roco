package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class QQSimpleInfoManor extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var plantScore:uint;
      
      public var score:uint;
      
      public var qqUin:uint;
      
      public function QQSimpleInfoManor()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         score = param1.readUnsignedInt();
         plantScore = param1.readUnsignedInt();
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(qqUin);
         param1.writeInt(score);
         param1.writeInt(plantScore);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "QQSimpleInfoManor";
      }
      
      public function encodeCGI() : String
      {
         return "" + "&qqUin=" + qqUin + "&score=" + score + "&plantScore=" + plantScore;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            qqUin = uint(param1.qqUin.text());
            score = uint(param1.score.text());
            plantScore = uint(param1.plantScore.text());
            return true;
         }
         return false;
      }
   }
}
