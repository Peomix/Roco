package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0322CD_ApplyBeginFight_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      public var hurtArray:Array = [];
      
      private var hurt_hp$field:uint;
      
      public var hpArray:Array = [];
      
      private var boss_left_hp$field:uint;
      
      private var war_soul_count$field:uint;
      
      public var speedArray:Array = [];
      
      private var ret_code$field:ReturnCode_Message;
      
      private var boss_status$field:uint;
      
      public var rewardArray:Array = [];
      
      private var play_remain$field:uint;
      
      private var boss_time$field:uint;
      
      public var petArray:Array = [];
      
      public function PTB_0x0322CD_ApplyBeginFight_Message_S2C()
      {
         super();
      }
      
      public function set playRemain(param1:uint) : void
      {
         hasField$0 |= 2;
         play_remain$field = param1;
      }
      
      public function set bossStatus(param1:uint) : void
      {
         hasField$0 |= 8;
         boss_status$field = param1;
      }
      
      public function get hasPlayRemain() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get hasWarSoulCount() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc10_:uint = 0;
         var _loc11_:ItemInfoChanged32_Message = null;
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
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.warSoulCount cannot be set twice.");
                  }
                  _loc4_++;
                  warSoulCount = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.playRemain cannot be set twice.");
                  }
                  _loc5_++;
                  playRemain = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.bossLeftHp cannot be set twice.");
                  }
                  _loc6_++;
                  bossLeftHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.bossStatus cannot be set twice.");
                  }
                  _loc7_++;
                  bossStatus = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.bossTime cannot be set twice.");
                  }
                  _loc8_++;
                  bossTime = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if(_loc9_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0322CD_ApplyBeginFight_Message_S2C.hurtHp cannot be set twice.");
                  }
                  _loc9_++;
                  hurtHp = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 8:
                  _loc11_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc11_);
                  rewardArray.push(_loc11_);
                  break;
               case 9:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,petArray);
                  }
                  else
                  {
                     petArray.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 10:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,hpArray);
                  }
                  else
                  {
                     hpArray.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               case 11:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_INT32,speedArray);
                  }
                  else
                  {
                     speedArray.push(ReadUtils.read$TYPE_INT32(param1));
                  }
                  break;
               case 12:
                  if((_loc10_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,hurtArray);
                  }
                  else
                  {
                     hurtArray.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc10_ & 7);
                  break;
            }
         }
      }
      
      public function get hasBossTime() : Boolean
      {
         return (hasField$0 & 0x10) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasWarSoulCount)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,war_soul_count$field);
         }
         if(hasPlayRemain)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,play_remain$field);
         }
         if(hasBossLeftHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,boss_left_hp$field);
         }
         if(hasBossStatus)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,boss_status$field);
         }
         if(hasBossTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,boss_time$field);
         }
         if(hasHurtHp)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,hurt_hp$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < rewardArray.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,8);
            WriteUtils.write$TYPE_MESSAGE(param1,rewardArray[_loc2_]);
            _loc2_++;
         }
         var _loc3_:uint = 0;
         while(_loc3_ < petArray.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,9);
            WriteUtils.write$TYPE_UINT32(param1,petArray[_loc3_]);
            _loc3_++;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < hpArray.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,10);
            WriteUtils.write$TYPE_UINT32(param1,hpArray[_loc4_]);
            _loc4_++;
         }
         var _loc5_:uint = 0;
         while(_loc5_ < speedArray.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,11);
            WriteUtils.write$TYPE_INT32(param1,speedArray[_loc5_]);
            _loc5_++;
         }
         var _loc6_:uint = 0;
         while(_loc6_ < hurtArray.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,12);
            WriteUtils.write$TYPE_UINT32(param1,hurtArray[_loc6_]);
            _loc6_++;
         }
      }
      
      public function removeHurtHp() : void
      {
         hasField$0 &= 4294967263;
         hurt_hp$field = new uint();
      }
      
      public function set warSoulCount(param1:uint) : void
      {
         hasField$0 |= 1;
         war_soul_count$field = param1;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function set bossTime(param1:uint) : void
      {
         hasField$0 |= 16;
         boss_time$field = param1;
      }
      
      public function get hasHurtHp() : Boolean
      {
         return (hasField$0 & 0x20) != 0;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get bossLeftHp() : uint
      {
         if(!hasBossLeftHp)
         {
            return 0;
         }
         return boss_left_hp$field;
      }
      
      public function get bossStatus() : uint
      {
         if(!hasBossStatus)
         {
            return 0;
         }
         return boss_status$field;
      }
      
      public function get playRemain() : uint
      {
         if(!hasPlayRemain)
         {
            return 0;
         }
         return play_remain$field;
      }
      
      public function get warSoulCount() : uint
      {
         if(!hasWarSoulCount)
         {
            return 0;
         }
         return war_soul_count$field;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeBossLeftHp() : void
      {
         hasField$0 &= 4294967291;
         boss_left_hp$field = new uint();
      }
      
      public function removeBossStatus() : void
      {
         hasField$0 &= 4294967287;
         boss_status$field = new uint();
      }
      
      public function removePlayRemain() : void
      {
         hasField$0 &= 4294967293;
         play_remain$field = new uint();
      }
      
      public function set hurtHp(param1:uint) : void
      {
         hasField$0 |= 32;
         hurt_hp$field = param1;
      }
      
      public function get bossTime() : uint
      {
         if(!hasBossTime)
         {
            return 0;
         }
         return boss_time$field;
      }
      
      public function get hasBossLeftHp() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get hurtHp() : uint
      {
         if(!hasHurtHp)
         {
            return 0;
         }
         return hurt_hp$field;
      }
      
      public function removeWarSoulCount() : void
      {
         hasField$0 &= 4294967294;
         war_soul_count$field = new uint();
      }
      
      public function get hasBossStatus() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function removeBossTime() : void
      {
         hasField$0 &= 4294967279;
         boss_time$field = new uint();
      }
      
      public function set bossLeftHp(param1:uint) : void
      {
         hasField$0 |= 4;
         boss_left_hp$field = param1;
      }
   }
}

