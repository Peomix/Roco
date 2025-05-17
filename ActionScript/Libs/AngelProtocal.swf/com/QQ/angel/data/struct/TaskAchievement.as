package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class TaskAchievement extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var finishTime:uint;
      
      public var themeID:uint;
      
      public var storyID:uint;
      
      public function TaskAchievement()
      {
         super();
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeShort(themeID);
         param1.writeInt(finishTime);
         param1.writeShort(storyID);
         return true;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         themeID = param1.readUnsignedShort();
         finishTime = param1.readUnsignedInt();
         storyID = param1.readUnsignedShort();
         return true;
      }
      
      public function encodeCGI() : String
      {
         return "" + "&themeID=" + themeID + "&finishTime=" + finishTime + "&storyID=" + storyID;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "TaskAchievement";
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            themeID = uint(param1.themeID.text());
            finishTime = uint(param1.finishTime.text());
            storyID = uint(param1.storyID.text());
            return true;
         }
         return false;
      }
   }
}

