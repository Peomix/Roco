package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032251_ApplyReward_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var item_female$field:uint;
      
      private var item_male$field:uint;
      
      public var statusAttay:Array;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var count_down$field:uint;
      
      public var rewardArray:Array;
      
      public function PTB_0x032251_ApplyReward_Message_S2C()
      {
         statusAttay = [];
         rewardArray = [];
         super();
      }
      
      public function set itemMale(param1:uint) : void
      {
         hasField$0 |= 2;
         item_male$field = param1;
      }
      
      public function get itemMale() : uint
      {
         if(!hasItemMale)
         {
            return 0;
         }
         return item_male$field;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get countDown() : uint
      {
         if(!hasCountDown)
         {
            return 0;
         }
         return count_down$field;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc7_:uint = 0;
         var _loc8_:ItemInfoChanged32_Message = null;
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
                     throw new IOError("Bad data format: PTB_0x032251_ApplyReward_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032251_ApplyReward_Message_S2C.countDown cannot be set twice.");
                  }
                  _loc4_++;
                  countDown = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032251_ApplyReward_Message_S2C.itemMale cannot be set twice.");
                  }
                  _loc5_++;
                  itemMale = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032251_ApplyReward_Message_S2C.itemFemale cannot be set twice.");
                  }
                  _loc6_++;
                  itemFemale = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if((_loc7_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,statusAttay);
                  }
                  else
                  {
                     statusAttay.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 6:
                  _loc8_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc8_);
                  rewardArray.push(_loc8_);
                  break;
               default:
                  ReadUtils.skip(param1,_loc7_ & 7);
                  break;
            }
         }
      }
      
      public function get hasCountDown() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasCountDown)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,count_down$field);
         }
         if(hasItemMale)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,item_male$field);
         }
         if(hasItemFemale)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,item_female$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < statusAttay.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,statusAttay[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,6);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc3_]);
            _loc3_++;
         }
      }
      
      public function set countDown(param1:uint) : void
      {
         hasField$0 |= 1;
         count_down$field = param1;
      }
      
      public function removeItemFemale() : void
      {
         hasField$0 &= 4294967291;
         item_female$field = new uint();
      }
      
      public function removeItemMale() : void
      {
         hasField$0 &= 4294967293;
         item_male$field = new uint();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeCountDown() : void
      {
         hasField$0 &= 4294967294;
         count_down$field = new uint();
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasItemFemale() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get hasItemMale() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set itemFemale(param1:uint) : void
      {
         hasField$0 |= 4;
         item_female$field = param1;
      }
      
      public function get itemFemale() : uint
      {
         if(!hasItemFemale)
         {
            return 0;
         }
         return item_female$field;
      }
   }
}
