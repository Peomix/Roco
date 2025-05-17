package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0300CE_QueryLoginGift_Message_S2C extends Message implements IExternalizable
   {
      
      private var money1$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var has_extra_gift$field:uint;
      
      private var index1$field:uint;
      
      private var money0$field:uint;
      
      private var money2$field:uint;
      
      private var is_show_daily_u_i$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      public var itemArray0:Array = [];
      
      public var itemArray1:Array = [];
      
      public var itemArray2:Array = [];
      
      private var index0$field:uint;
      
      private var index2$field:uint;
      
      public function PTB_0x0300CE_QueryLoginGift_Message_S2C()
      {
         super();
      }
      
      public function removeIsShowDailyUI() : void
      {
         hasField$0 &= 4294967167;
         is_show_daily_u_i$field = new uint();
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeHasExtraGift() : void
      {
         hasField$0 &= 4294967231;
         has_extra_gift$field = new uint();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc12_:uint = 0;
         var _loc13_:ItemInfoChanged32_Message = null;
         var _loc14_:ItemInfoChanged32_Message = null;
         var _loc15_:ItemInfoChanged32_Message = null;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc12_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc12_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.index0 cannot be set twice.");
                  }
                  _loc4_++;
                  index0 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.money0 cannot be set twice.");
                  }
                  _loc5_++;
                  money0 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  _loc13_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc13_);
                  itemArray0.push(_loc13_);
                  break;
               case 5:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.index1 cannot be set twice.");
                  }
                  _loc6_++;
                  index1 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.money1 cannot be set twice.");
                  }
                  _loc7_++;
                  money1 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  _loc14_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc14_);
                  itemArray1.push(_loc14_);
                  break;
               case 8:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.index2 cannot be set twice.");
                  }
                  _loc8_++;
                  index2 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 9:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.money2 cannot be set twice.");
                  }
                  _loc9_++;
                  money2 = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 10:
                  _loc15_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc15_);
                  itemArray2.push(_loc15_);
                  break;
               case 11:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.hasExtraGift cannot be set twice.");
                  }
                  _loc10_++;
                  hasExtraGift = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 12:
                  if(_loc11_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300CE_QueryLoginGift_Message_S2C.isShowDailyUI cannot be set twice.");
                  }
                  _loc11_++;
                  isShowDailyUI = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc12_ & 7);
                  break;
            }
         }
      }
      
      public function removeMoney0() : void
      {
         hasField$0 &= 4294967293;
         money0$field = new uint();
      }
      
      public function removeMoney1() : void
      {
         hasField$0 &= 4294967287;
         money1$field = new uint();
      }
      
      public function removeMoney2() : void
      {
         hasField$0 &= 4294967263;
         money2$field = new uint();
      }
      
      public function get index0() : uint
      {
         if(!hasIndex0)
         {
            return 0;
         }
         return index0$field;
      }
      
      public function get index1() : uint
      {
         if(!hasIndex1)
         {
            return 0;
         }
         return index1$field;
      }
      
      public function get index2() : uint
      {
         if(!hasIndex2)
         {
            return 0;
         }
         return index2$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasIndex0)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,index0$field);
         }
         if(hasMoney0)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,money0$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < itemArray0.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,4);
            WriteUtils.write$TYPE_MESSAGE(param1,itemArray0[_loc2_]);
            _loc2_++;
         }
         if(hasIndex1)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,index1$field);
         }
         if(hasMoney1)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,money1$field);
         }
         var _loc3_:uint = 0;
         while(_loc3_ < itemArray1.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,7);
            WriteUtils.write$TYPE_MESSAGE(param1,itemArray1[_loc3_]);
            _loc3_++;
         }
         if(hasIndex2)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,index2$field);
         }
         if(hasMoney2)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,money2$field);
         }
         var _loc4_:uint = 0;
         while(_loc4_ < itemArray2.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,10);
            WriteUtils.write$TYPE_MESSAGE(param1,itemArray2[_loc4_]);
            _loc4_++;
         }
         if(hasHasExtraGift)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_UINT32(param1,has_extra_gift$field);
         }
         if(hasIsShowDailyUI)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,12);
            WriteUtils.write$TYPE_UINT32(param1,is_show_daily_u_i$field);
         }
      }
      
      public function get isShowDailyUI() : uint
      {
         if(!hasIsShowDailyUI)
         {
            return 0;
         }
         return is_show_daily_u_i$field;
      }
      
      public function get hasHasExtraGift() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function get hasMoney0() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasMoney1() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get hasMoney2() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasIsShowDailyUI() : Boolean
      {
         return (hasField$0 & 0x80) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set index0(param1:uint) : void
      {
         hasField$0 |= 1;
         index0$field = param1;
      }
      
      public function set index1(param1:uint) : void
      {
         hasField$0 |= 4;
         index1$field = param1;
      }
      
      public function set index2(param1:uint) : void
      {
         hasField$0 |= 16;
         index2$field = param1;
      }
      
      public function removeIndex1() : void
      {
         hasField$0 &= 4294967291;
         index1$field = new uint();
      }
      
      public function removeIndex2() : void
      {
         hasField$0 &= 4294967279;
         index2$field = new uint();
      }
      
      public function removeIndex0() : void
      {
         hasField$0 &= 4294967294;
         index0$field = new uint();
      }
      
      public function set hasExtraGift(param1:uint) : void
      {
         hasField$0 |= 64;
         has_extra_gift$field = param1;
      }
      
      public function set isShowDailyUI(param1:uint) : void
      {
         hasField$0 |= 128;
         is_show_daily_u_i$field = param1;
      }
      
      public function get hasIndex0() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasIndex1() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get hasIndex2() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set money0(param1:uint) : void
      {
         hasField$0 |= 2;
         money0$field = param1;
      }
      
      public function set money1(param1:uint) : void
      {
         hasField$0 |= 8;
         money1$field = param1;
      }
      
      public function set money2(param1:uint) : void
      {
         hasField$0 |= 32;
         money2$field = param1;
      }
      
      public function get hasExtraGift() : uint
      {
         if(!hasHasExtraGift)
         {
            return 0;
         }
         return has_extra_gift$field;
      }
      
      public function get money0() : uint
      {
         if(!hasMoney0)
         {
            return 0;
         }
         return money0$field;
      }
      
      public function get money1() : uint
      {
         if(!hasMoney1)
         {
            return 0;
         }
         return money1$field;
      }
      
      public function get money2() : uint
      {
         if(!hasMoney2)
         {
            return 0;
         }
         return money2$field;
      }
   }
}

