package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0320DE_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var first$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var cur_stage$field:uint;
      
      private var complete_times$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var reward:Array = [];
      
      private var max_stage$field:uint;
      
      public function PTB_0x0320DE_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasMaxStage() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < reward.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,reward[_loc2_]);
            _loc2_++;
         }
         if(hasMaxStage)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,max_stage$field);
         }
         if(hasCurStage)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,cur_stage$field);
         }
         if(hasCompleteTimes)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,complete_times$field);
         }
         if(hasFirst)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,first$field);
         }
      }
      
      public function removeCurStage() : void
      {
         hasField$0 &= 4294967293;
         cur_stage$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get completeTimes() : uint
      {
         if(!hasCompleteTimes)
         {
            return 0;
         }
         return complete_times$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc8_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc8_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc8_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DE_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if((_loc8_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,reward);
                  }
                  else
                  {
                     reward.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DE_QueryStatus_Message_S2C.maxStage cannot be set twice.");
                  }
                  _loc4_++;
                  maxStage = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DE_QueryStatus_Message_S2C.curStage cannot be set twice.");
                  }
                  _loc5_++;
                  curStage = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DE_QueryStatus_Message_S2C.completeTimes cannot be set twice.");
                  }
                  _loc6_++;
                  completeTimes = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320DE_QueryStatus_Message_S2C.first cannot be set twice.");
                  }
                  _loc7_++;
                  first = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get hasCompleteTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set completeTimes(param1:uint) : void
      {
         hasField$0 |= 4;
         complete_times$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeMaxStage() : void
      {
         hasField$0 &= 4294967294;
         max_stage$field = new uint();
      }
      
      public function get hasCurStage() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set first(param1:uint) : void
      {
         hasField$0 |= 8;
         first$field = param1;
      }
      
      public function removeFirst() : void
      {
         hasField$0 &= 4294967287;
         first$field = new uint();
      }
      
      public function get curStage() : uint
      {
         if(!hasCurStage)
         {
            return 0;
         }
         return cur_stage$field;
      }
      
      public function removeCompleteTimes() : void
      {
         hasField$0 &= 4294967291;
         complete_times$field = new uint();
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get first() : uint
      {
         if(!hasFirst)
         {
            return 0;
         }
         return first$field;
      }
      
      public function set maxStage(param1:uint) : void
      {
         hasField$0 |= 1;
         max_stage$field = param1;
      }
      
      public function get hasFirst() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get maxStage() : uint
      {
         if(!hasMaxStage)
         {
            return 0;
         }
         return max_stage$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set curStage(param1:uint) : void
      {
         hasField$0 |= 2;
         cur_stage$field = param1;
      }
   }
}

