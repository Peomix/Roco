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
   
   public final class PTB_0x032184_OnHammerStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var is_fire$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gift_number$field:int;
      
      private var type$field:int;
      
      private var game_count_down$field:int;
      
      private var hammer_count_down$field:int;
      
      public function PTB_0x032184_OnHammerStatus_Message_S2C()
      {
         super();
      }
      
      public function set isFire(param1:int) : void
      {
         hasField$0 |= 1;
         is_fire$field = param1;
      }
      
      public function get hasGameCountDown() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get isFire() : int
      {
         if(!hasIsFire)
         {
            return 0;
         }
         return is_fire$field;
      }
      
      public function get hasIsFire() : Boolean
      {
         return (hasField$0 & 1) != 0;
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
                     throw new IOError("Bad data format: PTB_0x032184_OnHammerStatus_Message_S2C.isFire cannot be set twice.");
                  }
                  _loc3_++;
                  isFire = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032184_OnHammerStatus_Message_S2C.type cannot be set twice.");
                  }
                  _loc4_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032184_OnHammerStatus_Message_S2C.giftNumber cannot be set twice.");
                  }
                  _loc5_++;
                  giftNumber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032184_OnHammerStatus_Message_S2C.gameCountDown cannot be set twice.");
                  }
                  _loc6_++;
                  gameCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032184_OnHammerStatus_Message_S2C.hammerCountDown cannot be set twice.");
                  }
                  _loc7_++;
                  hammerCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get hasGiftNumber() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeHammerCountDown() : void
      {
         hasField$0 &= 4294967279;
         hammer_count_down$field = new int();
      }
      
      public function get giftNumber() : int
      {
         if(!hasGiftNumber)
         {
            return 0;
         }
         return gift_number$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasIsFire)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_INT32(param1,is_fire$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasGiftNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,gift_number$field);
         }
         if(hasGameCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,game_count_down$field);
         }
         if(hasHammerCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,hammer_count_down$field);
         }
      }
      
      public function removeGameCountDown() : void
      {
         hasField$0 &= 4294967287;
         game_count_down$field = new int();
      }
      
      public function set hammerCountDown(param1:int) : void
      {
         hasField$0 |= 16;
         hammer_count_down$field = param1;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967293;
         type$field = new int();
      }
      
      public function removeIsFire() : void
      {
         hasField$0 &= 4294967294;
         is_fire$field = new int();
      }
      
      public function get hammerCountDown() : int
      {
         if(!hasHammerCountDown)
         {
            return 0;
         }
         return hammer_count_down$field;
      }
      
      public function get hasHammerCountDown() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set giftNumber(param1:int) : void
      {
         hasField$0 |= 4;
         gift_number$field = param1;
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get type() : int
      {
         if(!hasType)
         {
            return 0;
         }
         return type$field;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 2;
         type$field = param1;
      }
      
      public function removeGiftNumber() : void
      {
         hasField$0 &= 4294967291;
         gift_number$field = new int();
      }
      
      public function set gameCountDown(param1:int) : void
      {
         hasField$0 |= 8;
         game_count_down$field = param1;
      }
      
      public function get gameCountDown() : int
      {
         if(!hasGameCountDown)
         {
            return 0;
         }
         return game_count_down$field;
      }
   }
}

