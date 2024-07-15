package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0322D2_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var box_type$field:int;
      
      private var hasField$0:uint = 0;
      
      private var evil_type$field:int;
      
      private var state$field:uint;
      
      private var count_down$field:uint;
      
      public var evilHp:Array;
      
      private var item_num1$field:uint;
      
      public var evilState:Array;
      
      private var hp$field:int;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var round_succ$field:uint;
      
      private var item_num0$field:uint;
      
      private var is_first$field:uint;
      
      private var week$field:uint;
      
      public function PTB_0x0322D2_QueryStatus_Message_S2C()
      {
         evilState = [];
         evilHp = [];
         super();
      }
      
      public function removeIsFirst() : void
      {
         hasField$0 &= 4294967231;
         is_first$field = new uint();
      }
      
      public function removeBoxType() : void
      {
         hasField$0 &= 4294967279;
         box_type$field = new int();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hp() : int
      {
         if(!hasHp)
         {
            return 0;
         }
         return hp$field;
      }
      
      public function set hp(param1:int) : void
      {
         hasField$0 |= 4;
         hp$field = param1;
      }
      
      public function get state() : uint
      {
         if(!hasState)
         {
            return 0;
         }
         return state$field;
      }
      
      public function removeEvilType() : void
      {
         hasField$0 &= 4294967287;
         evil_type$field = new int();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc14_:uint = 0;
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
         var _loc13_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc14_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc14_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.state cannot be set twice.");
                  }
                  _loc4_++;
                  state = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.countDown cannot be set twice.");
                  }
                  _loc5_++;
                  countDown = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.hp cannot be set twice.");
                  }
                  _loc6_++;
                  hp = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if((_loc14_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,evilState);
                  }
                  else
                  {
                     evilState.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 6:
                  if((_loc14_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,evilHp);
                  }
                  else
                  {
                     evilHp.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 7:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.evilType cannot be set twice.");
                  }
                  _loc7_++;
                  evilType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.boxType cannot be set twice.");
                  }
                  _loc8_++;
                  boxType = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.roundSucc cannot be set twice.");
                  }
                  _loc9_++;
                  roundSucc = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 10:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.isFirst cannot be set twice.");
                  }
                  _loc10_++;
                  isFirst = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 11:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.itemNum0 cannot be set twice.");
                  }
                  _loc11_++;
                  itemNum0 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 12:
                  if(_loc12_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.itemNum1 cannot be set twice.");
                  }
                  _loc12_++;
                  itemNum1 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 13:
                  if(_loc13_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322D2_QueryStatus_Message_S2C.week cannot be set twice.");
                  }
                  _loc13_++;
                  week = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc14_ & 7);
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
         if(hasState)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,state$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,count_down$field);
         }
         if(hasHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,hp$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < evilState.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,evilState[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < evilHp.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_INT32(param1,evilHp[_loc3_]);
            _loc3_++;
         }
         if(hasEvilType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_INT32(param1,evil_type$field);
         }
         if(hasBoxType)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_INT32(param1,box_type$field);
         }
         if(hasRoundSucc)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,round_succ$field);
         }
         if(hasIsFirst)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,is_first$field);
         }
         if(hasItemNum0)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_UINT32(param1,item_num0$field);
         }
         if(hasItemNum1)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,12);
            WriteUtils.write$TYPE_UINT32(param1,item_num1$field);
         }
         if(hasWeek)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,13);
            WriteUtils.write$TYPE_UINT32(param1,week$field);
         }
      }
      
      public function get itemNum0() : uint
      {
         if(!hasItemNum0)
         {
            return 0;
         }
         return item_num0$field;
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function removeWeek() : void
      {
         hasField$0 &= 4294966783;
         week$field = new uint();
      }
      
      public function set state(param1:uint) : void
      {
         hasField$0 |= 1;
         state$field = param1;
      }
      
      public function get boxType() : int
      {
         if(!hasBoxType)
         {
            return 0;
         }
         return box_type$field;
      }
      
      public function get isFirst() : uint
      {
         if(!hasIsFirst)
         {
            return 0;
         }
         return is_first$field;
      }
      
      public function set countDown(param1:uint) : void
      {
         hasField$0 |= 2;
         count_down$field = param1;
      }
      
      public function get hasBoxType() : Boolean
      {
         return (hasField$0 & 16) != 0;
      }
      
      public function removeHp() : void
      {
         hasField$0 &= 4294967291;
         hp$field = new int();
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967293;
         count_down$field = new uint();
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasEvilType() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get hasIsFirst() : Boolean
      {
         return (hasField$0 & 64) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasWeek() : Boolean
      {
         return (hasField$0 & 512) != 0;
      }
      
      public function get itemNum1() : uint
      {
         if(!hasItemNum1)
         {
            return 0;
         }
         return item_num1$field;
      }
      
      public function removeItemNum0() : void
      {
         hasField$0 &= 4294967167;
         item_num0$field = new uint();
      }
      
      public function get hasHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set itemNum1(param1:uint) : void
      {
         hasField$0 |= 256;
         item_num1$field = param1;
      }
      
      public function removeRoundSucc() : void
      {
         hasField$0 &= 4294967263;
         round_succ$field = new uint();
      }
      
      public function get countDown() : uint
      {
         if(!hasCountDown)
         {
            return 0;
         }
         return count_down$field;
      }
      
      public function set isFirst(param1:uint) : void
      {
         hasField$0 |= 64;
         is_first$field = param1;
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set boxType(param1:int) : void
      {
         hasField$0 |= 16;
         box_type$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get hasItemNum1() : Boolean
      {
         return (hasField$0 & 256) != 0;
      }
      
      public function set roundSucc(param1:uint) : void
      {
         hasField$0 |= 32;
         round_succ$field = param1;
      }
      
      public function set evilType(param1:int) : void
      {
         hasField$0 |= 8;
         evil_type$field = param1;
      }
      
      public function removeItemNum1() : void
      {
         hasField$0 &= 4294967039;
         item_num1$field = new uint();
      }
      
      public function get hasItemNum0() : Boolean
      {
         return (hasField$0 & 128) != 0;
      }
      
      public function set itemNum0(param1:uint) : void
      {
         hasField$0 |= 128;
         item_num0$field = param1;
      }
      
      public function set week(param1:uint) : void
      {
         hasField$0 |= 512;
         week$field = param1;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967294;
         state$field = new uint();
      }
      
      public function get evilType() : int
      {
         if(!hasEvilType)
         {
            return 0;
         }
         return evil_type$field;
      }
      
      public function get roundSucc() : uint
      {
         if(!hasRoundSucc)
         {
            return 0;
         }
         return round_succ$field;
      }
      
      public function get week() : uint
      {
         if(!hasWeek)
         {
            return 0;
         }
         return week$field;
      }
      
      public function get hasRoundSucc() : Boolean
      {
         return (hasField$0 & 32) != 0;
      }
   }
}
