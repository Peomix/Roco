package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.data.struct.TaskInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x0E0003_ApplyCompleteATask_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 917507;
      
      public var intellectAdd:int;
      
      public var expAdd:int;
      
      public var itemInfoChangedArray:Array;
      
      public var moneyAdd:int;
      
      public var charmAdd:int;
      
      public var taskInfoListArray:Array;
      
      public var storyID:uint;
      
      public var itemInfoChangedLength:uint;
      
      public var honorAdd:int;
      
      public var powerAdd:int;
      
      public var taskInfoListLength:uint;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x0E0003_ApplyCompleteATask_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         moneyAdd = param1.readInt();
         expAdd = param1.readInt();
         honorAdd = param1.readInt();
         powerAdd = param1.readInt();
         intellectAdd = param1.readInt();
         charmAdd = param1.readInt();
         storyID = param1.readUnsignedShort();
         itemInfoChangedLength = param1.readUnsignedShort();
         if(!itemInfoChangedArray)
         {
            itemInfoChangedArray = new Array(itemInfoChangedLength);
         }
         itemInfoChangedArray.length = itemInfoChangedLength;
         var _loc2_:int = 0;
         while(_loc2_ < itemInfoChangedLength)
         {
            itemInfoChangedArray[_loc2_] = new ItemInfoChanged32();
            itemInfoChangedArray[_loc2_].readData(param1);
            _loc2_++;
         }
         taskInfoListLength = param1.readUnsignedShort();
         if(!taskInfoListArray)
         {
            taskInfoListArray = new Array(taskInfoListLength);
         }
         taskInfoListArray.length = taskInfoListLength;
         var _loc3_:int = 0;
         while(_loc3_ < taskInfoListLength)
         {
            taskInfoListArray[_loc3_] = new TaskInfo();
            taskInfoListArray[_loc3_].readData(param1);
            _loc3_++;
         }
         return true;
      }
   }
}

