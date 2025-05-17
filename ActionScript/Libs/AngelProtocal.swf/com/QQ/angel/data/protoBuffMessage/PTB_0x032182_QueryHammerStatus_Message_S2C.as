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
   
   public final class PTB_0x032182_QueryHammerStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var hammer_count_down$field:int;
      
      private var hasField$0:uint = 0;
      
      private var gift_number$field:int;
      
      private var type$field:int;
      
      private var money$field:int;
      
      private var box1$field:int;
      
      private var card_number$field:int;
      
      private var game_count_down$field:int;
      
      private var box0$field:int;
      
      private var box2$field:int;
      
      private var ret_code$field:ReturnCode_Message;
      
      public function PTB_0x032182_QueryHammerStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasBox1() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function get hasGameCountDown() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get gameCountDown() : int
      {
         if(!hasGameCountDown)
         {
            return 0;
         }
         return game_count_down$field;
      }
      
      public function removeHammerCountDown() : void
      {
         hasField$0 &= 4294967293;
         hammer_count_down$field = new int();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function set money(param1:int) : void
      {
         hasField$0 |= 256;
         money$field = param1;
      }
      
      public function set box0(param1:int) : void
      {
         hasField$0 |= 32;
         box0$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc13_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc13_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc13_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.gameCountDown cannot be set twice.");
                  }
                  _loc4_++;
                  gameCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.hammerCountDown cannot be set twice.");
                  }
                  _loc5_++;
                  hammerCountDown = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.type cannot be set twice.");
                  }
                  _loc6_++;
                  type = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.giftNumber cannot be set twice.");
                  }
                  _loc7_++;
                  giftNumber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.cardNumber cannot be set twice.");
                  }
                  _loc8_++;
                  cardNumber = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.box0 cannot be set twice.");
                  }
                  _loc9_++;
                  box0 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.box1 cannot be set twice.");
                  }
                  _loc10_++;
                  box1 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.box2 cannot be set twice.");
                  }
                  _loc11_++;
                  box2 = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 10:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032182_QueryHammerStatus_Message_S2C.money cannot be set twice.");
                  }
                  _loc12_++;
                  money = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc13_ & 7);
                  break;
            }
         }
      }
      
      public function set box1(param1:int) : void
      {
         hasField$0 |= 64;
         box1$field = param1;
      }
      
      public function set box2(param1:int) : void
      {
         hasField$0 |= 128;
         box2$field = param1;
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
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasGameCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,game_count_down$field);
         }
         if(hasHammerCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,hammer_count_down$field);
         }
         if(hasType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,type$field);
         }
         if(hasGiftNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,gift_number$field);
         }
         if(hasCardNumber)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_INT32(param1,card_number$field);
         }
         if(hasBox0)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_INT32(param1,box0$field);
         }
         if(hasBox1)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_INT32(param1,box1$field);
         }
         if(hasBox2)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_INT32(param1,box2$field);
         }
         if(hasMoney)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_INT32(param1,money$field);
         }
      }
      
      public function removeCardNumber() : void
      {
         hasField$0 &= 4294967279;
         card_number$field = new int();
      }
      
      public function get hammerCountDown() : int
      {
         if(!hasHammerCountDown)
         {
            return 0;
         }
         return hammer_count_down$field;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasHammerCountDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set giftNumber(param1:int) : void
      {
         hasField$0 |= 8;
         gift_number$field = param1;
      }
      
      public function get hasCardNumber() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get type() : int
      {
         if(!hasType)
         {
            return 0;
         }
         return type$field;
      }
      
      public function removeGiftNumber() : void
      {
         hasField$0 &= 4294967287;
         gift_number$field = new int();
      }
      
      public function removeMoney() : void
      {
         hasField$0 &= 4294967039;
         money$field = new int();
      }
      
      public function get money() : int
      {
         if(!hasMoney)
         {
            return 0;
         }
         return money$field;
      }
      
      public function get box0() : int
      {
         if(!hasBox0)
         {
            return 0;
         }
         return box0$field;
      }
      
      public function get box1() : int
      {
         if(!hasBox1)
         {
            return 0;
         }
         return box1$field;
      }
      
      public function get hasBox2() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function get hasMoney() : Boolean
      {
         return (hasField$0 & 0x0100) != 0;
      }
      
      public function get box2() : int
      {
         if(!hasBox2)
         {
            return 0;
         }
         return box2$field;
      }
      
      public function get hasGiftNumber() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set hammerCountDown(param1:int) : void
      {
         hasField$0 |= 2;
         hammer_count_down$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeType() : void
      {
         hasField$0 &= 4294967291;
         type$field = new int();
      }
      
      public function removeGameCountDown() : void
      {
         hasField$0 &= 4294967294;
         game_count_down$field = new int();
      }
      
      public function removeBox0() : void
      {
         hasField$0 &= 4294967263;
         box0$field = new int();
      }
      
      public function removeBox1() : void
      {
         hasField$0 &= 4294967231;
         box1$field = new int();
      }
      
      public function removeBox2() : void
      {
         hasField$0 &= 4294967167;
         box2$field = new int();
      }
      
      public function set cardNumber(param1:int) : void
      {
         hasField$0 |= 16;
         card_number$field = param1;
      }
      
      public function set type(param1:int) : void
      {
         hasField$0 |= 4;
         type$field = param1;
      }
      
      public function get cardNumber() : int
      {
         if(!hasCardNumber)
         {
            return 0;
         }
         return card_number$field;
      }
      
      public function get hasType() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set gameCountDown(param1:int) : void
      {
         hasField$0 |= 1;
         game_count_down$field = param1;
      }
      
      public function get hasBox0() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
   }
}

