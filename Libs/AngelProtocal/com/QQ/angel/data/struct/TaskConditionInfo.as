package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class TaskConditionInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var taskTaskId:uint;
      
      public var taskConditionStatus:uint;
      
      public var progress:TaskCondInfo;
      
      public var taskConditionIndex:uint;
      
      public function TaskConditionInfo()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         taskTaskId = param1.readUnsignedInt();
         taskConditionIndex = param1.readUnsignedByte();
         taskConditionStatus = param1.readUnsignedByte();
         progress = new TaskCondInfo();
         progress.readData(param1);
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeInt(taskTaskId);
         param1.writeByte(taskConditionIndex);
         param1.writeByte(taskConditionStatus);
         if(progress)
         {
            progress.writeData(param1);
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "TaskConditionInfo";
      }
      
      public function encodeCGI() : String
      {
         return "" + "&taskTaskId=" + taskTaskId + "&taskConditionIndex=" + taskConditionIndex + "&taskConditionStatus=" + taskConditionStatus + "&progress=" + progress.encodeCGI();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            taskTaskId = uint(param1.taskTaskId.text());
            taskConditionIndex = uint(param1.taskConditionIndex.text());
            taskConditionStatus = uint(param1.taskConditionStatus.text());
            progress = new TaskCondInfo();
            progress.decodeCGI(XML(param1.progress));
            return true;
         }
         return false;
      }
   }
}
