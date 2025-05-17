package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032159_OnGameStatus_Message_S2C extends Message implements IExternalizable
   {
      
      public var itemArray:Array = [];
      
      private var boss_hp$field:uint;
      
      private var hasField$0:uint = 0;
      
      public function PTB_0x032159_OnGameStatus_Message_S2C()
      {
         super();
      }
      
      public function set bossHp(param1:uint) : void
      {
         hasField$0 |= 1;
         boss_hp$field = param1;
      }
      
      public function get hasBossHp() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:ItemInfoChanged32_Message = null;
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc4_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc4_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032159_OnGameStatus_Message_S2C.bossHp cannot be set twice.");
                  }
                  _loc3_++;
                  bossHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  _loc5_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc5_);
                  itemArray.push(_loc5_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc4_ & 7);
                  break;
            }
         }
      }
      
      public function get bossHp() : uint
      {
         if(!hasBossHp)
         {
            return 0;
         }
         return boss_hp$field;
      }
      
      public function removeBossHp() : void
      {
         hasField$0 &= 4294967294;
         boss_hp$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasBossHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,boss_hp$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < itemArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,2);
            WriteUtils.write$TYPE_MESSAGE(param1,itemArray[_loc2_]);
            _loc2_++;
         }
      }
   }
}

