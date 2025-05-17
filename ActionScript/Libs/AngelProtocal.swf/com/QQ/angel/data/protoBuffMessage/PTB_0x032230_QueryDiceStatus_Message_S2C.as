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
   
   public final class PTB_0x032230_QueryDiceStatus_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var grid$field:uint;
      
      private var vip_remain$field:uint;
      
      private var pet_num$field:uint;
      
      private var dice_num$field:uint;
      
      private var time_left$field:uint;
      
      private var pet_id$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var scene$field:uint;
      
      public function PTB_0x032230_QueryDiceStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasGrid() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removePetNum() : void
      {
         hasField$0 &= 4294967263;
         pet_num$field = new uint();
      }
      
      public function get hasScene() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get scene() : uint
      {
         if(!hasScene)
         {
            return 0;
         }
         return scene$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc11_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc11_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc11_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.scene cannot be set twice.");
                  }
                  _loc4_++;
                  scene = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.grid cannot be set twice.");
                  }
                  _loc5_++;
                  grid = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.diceNum cannot be set twice.");
                  }
                  _loc6_++;
                  diceNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.timeLeft cannot be set twice.");
                  }
                  _loc7_++;
                  timeLeft = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.petId cannot be set twice.");
                  }
                  _loc8_++;
                  petId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.petNum cannot be set twice.");
                  }
                  _loc9_++;
                  petNum = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 8:
                  if(_loc10_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032230_QueryDiceStatus_Message_S2C.vipRemain cannot be set twice.");
                  }
                  _loc10_++;
                  vipRemain = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc11_ & 7);
                  break;
            }
         }
      }
      
      public function get petId() : uint
      {
         if(!hasPetId)
         {
            return 0;
         }
         return pet_id$field;
      }
      
      public function set grid(param1:uint) : void
      {
         hasField$0 |= 2;
         grid$field = param1;
      }
      
      public function set scene(param1:uint) : void
      {
         hasField$0 |= 1;
         scene$field = param1;
      }
      
      public function get hasPetId() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      public function get hasPetNum() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function removeTimeLeft() : void
      {
         hasField$0 &= 4294967287;
         time_left$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasScene)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,scene$field);
         }
         if(hasGrid)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,grid$field);
         }
         if(hasDiceNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,dice_num$field);
         }
         if(hasTimeLeft)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,time_left$field);
         }
         if(hasPetId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,pet_id$field);
         }
         if(hasPetNum)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,pet_num$field);
         }
         if(hasVipRemain)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,8);
            WriteUtils.write$TYPE_UINT32(param1,vip_remain$field);
         }
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function set petId(param1:uint) : void
      {
         hasField$0 |= 16;
         pet_id$field = param1;
      }
      
      public function get hasTimeLeft() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set diceNum(param1:uint) : void
      {
         hasField$0 |= 4;
         dice_num$field = param1;
      }
      
      public function removeVipRemain() : void
      {
         hasField$0 &= 4294967231;
         vip_remain$field = new uint();
      }
      
      public function get grid() : uint
      {
         if(!hasGrid)
         {
            return 0;
         }
         return grid$field;
      }
      
      public function set petNum(param1:uint) : void
      {
         hasField$0 |= 32;
         pet_num$field = param1;
      }
      
      public function set vipRemain(param1:uint) : void
      {
         hasField$0 |= 64;
         vip_remain$field = param1;
      }
      
      public function removeDiceNum() : void
      {
         hasField$0 &= 4294967291;
         dice_num$field = new uint();
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
         return (hasField$0 & 4) != 0;
      }
      
      public function get petNum() : uint
      {
         if(!hasPetNum)
         {
            return 0;
         }
         return pet_num$field;
      }
      
      public function removeScene() : void
      {
         hasField$0 &= 4294967294;
         scene$field = new uint();
      }
      
      public function get vipRemain() : uint
      {
         if(!hasVipRemain)
         {
            return 0;
         }
         return vip_remain$field;
      }
      
      public function removeGrid() : void
      {
         hasField$0 &= 4294967293;
         grid$field = new uint();
      }
      
      public function get hasVipRemain() : Boolean
      {
         return (hasField$0 & 0x40) != 0;
      }
      
      public function get timeLeft() : uint
      {
         if(!hasTimeLeft)
         {
            return 0;
         }
         return time_left$field;
      }
      
      public function removePetId() : void
      {
         hasField$0 &= 4294967279;
         pet_id$field = new uint();
      }
      
      public function set timeLeft(param1:uint) : void
      {
         hasField$0 |= 8;
         time_left$field = param1;
      }
   }
}

