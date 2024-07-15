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
   
   public final class PTB_0x032236_QueryGameStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var gift_num$field:uint;
      
      private var egg_count_down$field:uint;
      
      private var status$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var current_hp$field:uint;
      
      private var total_hp$field:uint;
      
      private var light$field:uint;
      
      public function PTB_0x032236_QueryGameStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasEggCountDown() : Boolean
      {
         return (hasField$0 & 32) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeGiftNum() : void
      {
         hasField$0 &= 4294967279;
         gift_num$field = new uint();
      }
      
      public function get status() : uint
      {
         if(!hasStatus)
         {
            return 0;
         }
         return status$field;
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new uint();
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
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.status cannot be set twice.");
                  }
                  _loc4_++;
                  status = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.light cannot be set twice.");
                  }
                  _loc5_++;
                  light = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.currentHp cannot be set twice.");
                  }
                  _loc6_++;
                  currentHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.totalHp cannot be set twice.");
                  }
                  _loc7_++;
                  totalHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.giftNum cannot be set twice.");
                  }
                  _loc8_++;
                  giftNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032236_QueryGameStatus_Message_S2C.eggCountDown cannot be set twice.");
                  }
                  _loc9_++;
                  eggCountDown = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
                  break;
            }
         }
      }
      
      public function get hasLight() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get light() : uint
      {
         if(!hasLight)
         {
            return 0;
         }
         return light$field;
      }
      
      public function get hasTotalHp() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function set eggCountDown(param1:uint) : void
      {
         hasField$0 |= 32;
         egg_count_down$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,status$field);
         }
         if(hasLight)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,light$field);
         }
         if(hasCurrentHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,current_hp$field);
         }
         if(hasTotalHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,total_hp$field);
         }
         if(hasGiftNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,gift_num$field);
         }
         if(hasEggCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,egg_count_down$field);
         }
      }
      
      public function removeLight() : void
      {
         hasField$0 &= 4294967293;
         light$field = new uint();
      }
      
      public function set light(param1:uint) : void
      {
         hasField$0 |= 2;
         light$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get giftNum() : uint
      {
         if(!hasGiftNum)
         {
            return 0;
         }
         return gift_num$field;
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasGiftNum() : Boolean
      {
         return (hasField$0 & 16) != 0;
      }
      
      public function removeCurrentHp() : void
      {
         hasField$0 &= 4294967291;
         current_hp$field = new uint();
      }
      
      public function set currentHp(param1:uint) : void
      {
         hasField$0 |= 4;
         current_hp$field = param1;
      }
      
      public function get eggCountDown() : uint
      {
         if(!hasEggCountDown)
         {
            return 0;
         }
         return egg_count_down$field;
      }
      
      public function removeTotalHp() : void
      {
         hasField$0 &= 4294967287;
         total_hp$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set totalHp(param1:uint) : void
      {
         hasField$0 |= 8;
         total_hp$field = param1;
      }
      
      public function set status(param1:uint) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function get hasCurrentHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get currentHp() : uint
      {
         if(!hasCurrentHp)
         {
            return 0;
         }
         return current_hp$field;
      }
      
      public function get totalHp() : uint
      {
         if(!hasTotalHp)
         {
            return 0;
         }
         return total_hp$field;
      }
      
      public function removeEggCountDown() : void
      {
         hasField$0 &= 4294967263;
         egg_count_down$field = new uint();
      }
      
      public function set giftNum(param1:uint) : void
      {
         hasField$0 |= 16;
         gift_num$field = param1;
      }
   }
}
