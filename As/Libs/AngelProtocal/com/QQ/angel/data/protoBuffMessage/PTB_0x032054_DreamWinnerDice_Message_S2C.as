package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032054_DreamWinnerDice_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var dice_num$field:uint;
      
      private var hasField$0:uint = 0;
      
      public var item:Array;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var cur_pos$field:uint;
      
      public function PTB_0x032054_DreamWinnerDice_Message_S2C()
      {
         item = [];
         super();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc7_:ItemInfoChanged32_Message = null;
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
                     throw new IOError("Bad data format: PTB_0x032054_DreamWinnerDice_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  _loc7_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  item.push(_loc7_);
                  break;
               case 3:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032054_DreamWinnerDice_Message_S2C.diceNum cannot be set twice.");
                  }
                  _loc4_++;
                  diceNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032054_DreamWinnerDice_Message_S2C.curPos cannot be set twice.");
                  }
                  _loc5_++;
                  curPos = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function removeCurPos() : void
      {
         hasField$0 &= 4294967293;
         cur_pos$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
         if(hasDiceNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,dice_num$field);
         }
         if(hasCurPos)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,cur_pos$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeDiceNum() : void
      {
         hasField$0 &= 4294967294;
         dice_num$field = new uint();
      }
      
      public function get hasDiceNum() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function set curPos(param1:uint) : void
      {
         hasField$0 |= 2;
         cur_pos$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get curPos() : uint
      {
         if(!hasCurPos)
         {
            return 0;
         }
         return cur_pos$field;
      }
      
      public function get hasCurPos() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get diceNum() : uint
      {
         if(!hasDiceNum)
         {
            return 0;
         }
         return dice_num$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set diceNum(param1:uint) : void
      {
         hasField$0 |= 1;
         dice_num$field = param1;
      }
   }
}
