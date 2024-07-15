package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged;
   import com.QQ.angel.data.struct.TaskConditionInfo;
   import flash.utils.IDataInput;
   
   public class SKT_0x0C0100_OnTaskConditionComplete_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 786688;
       
      
      public var taskConditionArray:Array;
      
      public var taskTaskId:uint;
      
      public var itemInfoChangedArray:Array;
      
      public var taskConditionMsgLength:uint;
      
      public var itemInfoChangedLength:uint;
      
      public var taskConditionLength:uint;
      
      public var taskTaskMsgLength:uint;
      
      public function SKT_0x0C0100_OnTaskConditionComplete_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         itemInfoChangedLength = param1.readUnsignedShort();
         if(!itemInfoChangedArray)
         {
            itemInfoChangedArray = new Array(itemInfoChangedLength);
         }
         itemInfoChangedArray.length = itemInfoChangedLength;
         var _loc2_:int = 0;
         while(_loc2_ < itemInfoChangedLength)
         {
            itemInfoChangedArray[_loc2_] = new ItemInfoChanged();
            itemInfoChangedArray[_loc2_].readData(param1);
            _loc2_++;
         }
         taskConditionLength = param1.readUnsignedShort();
         if(!taskConditionArray)
         {
            taskConditionArray = new Array(taskConditionLength);
         }
         taskConditionArray.length = taskConditionLength;
         var _loc3_:int = 0;
         while(_loc3_ < taskConditionLength)
         {
            taskConditionArray[_loc3_] = new TaskConditionInfo();
            taskConditionArray[_loc3_].readData(param1);
            _loc3_++;
         }
         taskTaskId = param1.readUnsignedInt();
         taskConditionMsgLength = param1.readUnsignedShort();
         var _loc4_:int = 0;
         while(_loc4_ < taskConditionMsgLength)
         {
            param1.readUnsignedByte();
            _loc4_++;
         }
         taskTaskMsgLength = param1.readUnsignedShort();
         var _loc5_:int = 0;
         while(_loc5_ < taskTaskMsgLength)
         {
            param1.readUnsignedByte();
            _loc5_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
