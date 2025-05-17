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
   
   public final class PTB_0x32099_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var left_time$field:uint;
      
      private var status$field:uint;
      
      private var active_left_time$field:uint;
      
      private var wait_time$field:uint;
      
      private var is_active_day$field:uint;
      
      private var is_first$field:uint;
      
      private var time_status$field:uint;
      
      public function PTB_0x32099_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967291;
         is_first$field = new uint();
      }
      
      public function removeWaitTime() : void
      {
         hasField$0 &= 4294967279;
         wait_time$field = new uint();
      }
      
      public function removeIsActiveDay() : void
      {
         hasField$0 &= 4294967287;
         is_active_day$field = new uint();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc10_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc10_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.status cannot be set twice.");
                  }
                  _loc3_++;
                  status = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.leftTime cannot be set twice.");
                  }
                  _loc4_++;
                  leftTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.isFirst cannot be set twice.");
                  }
                  _loc5_++;
                  isFirst = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.isActiveDay cannot be set twice.");
                  }
                  _loc6_++;
                  isActiveDay = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.waitTime cannot be set twice.");
                  }
                  _loc7_++;
                  waitTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.timeStatus cannot be set twice.");
                  }
                  _loc8_++;
                  timeStatus = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x32099_QueryStatus_Message_S2C.activeLeftTime cannot be set twice.");
                  }
                  _loc9_++;
                  activeLeftTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
                  break;
            }
         }
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,status$field);
         }
         if(hasLeftTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,left_time$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,is_first$field);
         }
         if(hasIsActiveDay)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,is_active_day$field);
         }
         if(hasWaitTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,wait_time$field);
         }
         if(hasTimeStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,time_status$field);
         }
         if(hasActiveLeftTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,active_left_time$field);
         }
      }
      
      public function get hasWaitTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function removeLeftTime() : void
      {
         hasField$0 &= 4294967293;
         left_time$field = new uint();
      }
      
      public function get isFirst() : uint
      {
         if(!hasIsFirst)
         {
            return 0;
         }
         return is_first$field;
      }
      
      public function get activeLeftTime() : uint
      {
         if(!hasActiveLeftTime)
         {
            return 0;
         }
         return active_left_time$field;
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasLeftTime() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasIsActiveDay() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set activeLeftTime(param1:uint) : void
      {
         hasField$0 |= 64;
         active_left_time$field = param1;
      }
      
      public function get timeStatus() : uint
      {
         if(!hasTimeStatus)
         {
            return 0;
         }
         return time_status$field;
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeActiveLeftTime() : void
      {
         hasField$0 &= 4294967231;
         active_left_time$field = new uint();
      }
      
      public function removeTimeStatus() : void
      {
         hasField$0 &= 4294967263;
         time_status$field = new uint();
      }
      
      public function set waitTime(param1:uint) : void
      {
         hasField$0 |= 16;
         wait_time$field = param1;
      }
      
      public function set timeStatus(param1:uint) : void
      {
         hasField$0 |= 32;
         time_status$field = param1;
      }
      
      public function set isFirst(param1:uint) : void
      {
         hasField$0 |= 4;
         is_first$field = param1;
      }
      
      public function get isActiveDay() : uint
      {
         if(!hasIsActiveDay)
         {
            return 0;
         }
         return is_active_day$field;
      }
      
      public function get hasActiveLeftTime() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function set isActiveDay(param1:uint) : void
      {
         hasField$0 |= 8;
         is_active_day$field = param1;
      }
      
      public function get hasTimeStatus() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function set status(param1:uint) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function set leftTime(param1:uint) : void
      {
         hasField$0 |= 2;
         left_time$field = param1;
      }
      
      public function get waitTime() : uint
      {
         if(!hasWaitTime)
         {
            return 0;
         }
         return wait_time$field;
      }
      
      public function get status() : uint
      {
         if(!hasStatus)
         {
            return 0;
         }
         return status$field;
      }
      
      public function get leftTime() : uint
      {
         if(!hasLeftTime)
         {
            return 0;
         }
         return left_time$field;
      }
   }
}

