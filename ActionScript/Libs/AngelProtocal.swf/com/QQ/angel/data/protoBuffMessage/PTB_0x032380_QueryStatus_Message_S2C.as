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
   
   public final class PTB_0x032380_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var dice_num$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var step$field:uint;
      
      private var stat$field:uint;
      
      public function PTB_0x032380_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasStep() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasStat() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc7_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc7_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032380_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032380_QueryStatus_Message_S2C.stat cannot be set twice.");
                  }
                  _loc4_++;
                  stat = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032380_QueryStatus_Message_S2C.diceNum cannot be set twice.");
                  }
                  _loc5_++;
                  diceNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032380_QueryStatus_Message_S2C.step cannot be set twice.");
                  }
                  _loc6_++;
                  step = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function get step() : uint
      {
         if(!hasStep)
         {
            return 0;
         }
         return step$field;
      }
      
      public function get stat() : uint
      {
         if(!hasStat)
         {
            return 0;
         }
         return stat$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasStat)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,stat$field);
         }
         if(hasDiceNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,dice_num$field);
         }
         if(hasStep)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,step$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get diceNum() : uint
      {
         if(!hasDiceNum)
         {
            return 0;
         }
         return dice_num$field;
      }
      
      public function get hasDiceNum() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set step(param1:uint) : void
      {
         hasField$0 |= 4;
         step$field = param1;
      }
      
      public function set stat(param1:uint) : void
      {
         hasField$0 |= 1;
         stat$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function removeStep() : void
      {
         hasField$0 &= 4294967291;
         step$field = new uint();
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeStat() : void
      {
         hasField$0 &= 4294967294;
         stat$field = new uint();
      }
      
      public function removeDiceNum() : void
      {
         hasField$0 &= 4294967293;
         dice_num$field = new uint();
      }
      
      public function set diceNum(param1:uint) : void
      {
         hasField$0 |= 2;
         dice_num$field = param1;
      }
   }
}

