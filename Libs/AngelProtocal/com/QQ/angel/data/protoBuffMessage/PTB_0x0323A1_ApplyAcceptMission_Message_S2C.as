package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.Message;
   import com.tencent.protobuf.ReadUtils;
   import com.tencent.protobuf.WireType;
   import com.tencent.protobuf.WriteUtils;
   import com.tencent.protobuf.WritingBuffer;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0323A1_ApplyAcceptMission_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var mission_id$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var mission_status$field:uint;
      
      private var ret_code$field:ReturnCodeGBK_Message;
      
      public function PTB_0x0323A1_ApplyAcceptMission_Message_S2C()
      {
         super();
      }
      
      public function get missionId() : uint
      {
         if(!hasMissionId)
         {
            return 0;
         }
         return mission_id$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasMissionId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set missionId(param1:uint) : void
      {
         hasField$0 |= 1;
         mission_id$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc6_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A1_ApplyAcceptMission_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCodeGBK_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A1_ApplyAcceptMission_Message_S2C.missionId cannot be set twice.");
                  }
                  _loc4_++;
                  missionId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0323A1_ApplyAcceptMission_Message_S2C.missionStatus cannot be set twice.");
                  }
                  _loc5_++;
                  missionStatus = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasMissionId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,mission_id$field);
         }
         if(hasMissionStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,mission_status$field);
         }
      }
      
      public function set retCode(param1:ReturnCodeGBK_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get missionStatus() : uint
      {
         if(!hasMissionStatus)
         {
            return 0;
         }
         return mission_status$field;
      }
      
      public function removeMissionId() : void
      {
         hasField$0 &= 4294967294;
         mission_id$field = new uint();
      }
      
      public function get hasMissionStatus() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get retCode() : ReturnCodeGBK_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeMissionStatus() : void
      {
         hasField$0 &= 4294967293;
         mission_status$field = new uint();
      }
      
      public function set missionStatus(param1:uint) : void
      {
         hasField$0 |= 2;
         mission_status$field = param1;
      }
   }
}
