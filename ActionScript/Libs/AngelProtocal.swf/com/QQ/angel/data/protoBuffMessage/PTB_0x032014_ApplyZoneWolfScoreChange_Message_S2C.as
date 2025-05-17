package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032014_ApplyZoneWolfScoreChange_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var item:Array = [];
      
      private var score$field:uint;
      
      private var pack$field:uint;
      
      public function PTB_0x032014_ApplyZoneWolfScoreChange_Message_S2C()
      {
         super();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get score() : uint
      {
         if(!hasScore)
         {
            return 0;
         }
         return score$field;
      }
      
      public function get hasPack() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get pack() : uint
      {
         if(!hasPack)
         {
            return 0;
         }
         return pack$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasPack)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,pack$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,score$field);
         }
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set score(param1:uint) : void
      {
         hasField$0 |= 2;
         score$field = param1;
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
                     throw new IOError("Bad data format: PTB_0x032014_ApplyZoneWolfScoreChange_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032014_ApplyZoneWolfScoreChange_Message_S2C.pack cannot be set twice.");
                  }
                  _loc4_++;
                  pack = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  _loc7_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc7_);
                  item.push(_loc7_);
                  break;
               case 4:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032014_ApplyZoneWolfScoreChange_Message_S2C.score cannot be set twice.");
                  }
                  _loc5_++;
                  score = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function set pack(param1:uint) : void
      {
         hasField$0 |= 1;
         pack$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967293;
         score$field = new uint();
      }
      
      public function removePack() : void
      {
         hasField$0 &= 4294967294;
         pack$field = new uint();
      }
   }
}

