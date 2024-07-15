package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class TaskCondInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var maxValue:uint;
      
      public var state:uint;
      
      public var nowValue:uint;
      
      public function TaskCondInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         state = param1.readUnsignedByte();
         nowValue = param1.readUnsignedInt();
         maxValue = param1.readUnsignedInt();
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&state=" + state + "&nowValue=" + nowValue + "&maxValue=" + maxValue;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeByte(state);
         param1.writeInt(nowValue);
         param1.writeInt(maxValue);
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "TaskCondInfo";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            state = uint(param1.state.text());
            nowValue = uint(param1.nowValue.text());
            maxValue = uint(param1.maxValue.text());
            return true;
         }
         return false;
      }
   }
}
