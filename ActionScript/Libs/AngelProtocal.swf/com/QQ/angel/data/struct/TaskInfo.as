package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class TaskInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
      
      public var taskTypeSub:uint;
      
      public var themeID:uint;
      
      public var taskTaskId:uint;
      
      public var taskStoryId:uint;
      
      public var taskStatus:uint;
      
      public var taskType:uint;
      
      public function TaskInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         taskStoryId = param1.readUnsignedShort();
         taskTaskId = param1.readUnsignedShort();
         taskStatus = param1.readUnsignedByte();
         taskType = param1.readUnsignedByte();
         taskTypeSub = param1.readUnsignedByte();
         themeID = param1.readUnsignedShort();
         return true;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            taskStoryId = uint(param1.taskStoryId.text());
            taskTaskId = uint(param1.taskTaskId.text());
            taskStatus = uint(param1.taskStatus.text());
            taskType = uint(param1.taskType.text());
            taskTypeSub = uint(param1.taskTypeSub.text());
            themeID = uint(param1.themeID.text());
            return true;
         }
         return false;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "TaskInfo";
      }
      
      public function encodeCGI() : String
      {
         return "" + "&taskStoryId=" + taskStoryId + "&taskTaskId=" + taskTaskId + "&taskStatus=" + taskStatus + "&taskType=" + taskType + "&taskTypeSub=" + taskTypeSub + "&themeID=" + themeID;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeShort(taskStoryId);
         param1.writeShort(taskTaskId);
         param1.writeByte(taskStatus);
         param1.writeByte(taskType);
         param1.writeByte(taskTypeSub);
         param1.writeShort(themeID);
         return true;
      }
   }
}

