package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.errors.IOError;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var hasField$0:uint = 0;
      
      private var my_support$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var time$field:uint;
      
      private var state$field:uint;
      
      private var score$field:uint;
      
      private var id$field:uint;
      
      public var allSupport:Array;
      
      public function PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C()
      {
         allSupport = [];
         super();
      }
      
      public function get mySupport() : uint
      {
         if(!hasMySupport)
         {
            return 0;
         }
         return my_support$field;
      }
      
      public function set mySupport(param1:uint) : void
      {
         hasField$0 |= 4;
         my_support$field = param1;
      }
      
      public function get hasTime() : Boolean
      {
         return (hasField$0 & 16) != 0;
      }
      
      public function get hasMySupport() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc9_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc9_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc9_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.id cannot be set twice.");
                  }
                  _loc4_++;
                  id = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.state cannot be set twice.");
                  }
                  _loc5_++;
                  state = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.mySupport cannot be set twice.");
                  }
                  _loc6_++;
                  mySupport = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.score cannot be set twice.");
                  }
                  _loc7_++;
                  score = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 6:
                  if(_loc8_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0300F9_QuerySpiritRaceUIState_Message_S2C.time cannot be set twice.");
                  }
                  _loc8_++;
                  time = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 7:
                  if((_loc9_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,allSupport);
                  }
                  else
                  {
                     allSupport.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc9_ & 7);
                  break;
            }
         }
      }
      
      public function get state() : uint
      {
         if(!hasState)
         {
            return 0;
         }
         return state$field;
      }
      
      public function get time() : uint
      {
         if(!hasTime)
         {
            return 0;
         }
         return time$field;
      }
      
      public function get hasId() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get hasState() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function set time(param1:uint) : void
      {
         hasField$0 |= 16;
         time$field = param1;
      }
      
      public function get id() : uint
      {
         if(!hasId)
         {
            return 0;
         }
         return id$field;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function removeMySupport() : void
      {
         hasField$0 &= 4294967291;
         my_support$field = new uint();
      }
      
      public function set state(param1:uint) : void
      {
         hasField$0 |= 2;
         state$field = param1;
      }
      
      public function get score() : uint
      {
         if(!hasScore)
         {
            return 0;
         }
         return score$field;
      }
      
      public function set score(param1:uint) : void
      {
         hasField$0 |= 8;
         score$field = param1;
      }
      
      public function removeState() : void
      {
         hasField$0 &= 4294967293;
         state$field = new uint();
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get hasScore() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,id$field);
         }
         if(hasState)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,state$field);
         }
         if(hasMySupport)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,my_support$field);
         }
         if(hasScore)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,score$field);
         }
         if(hasTime)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,6);
            WriteUtils.write$TYPE_UINT32(param1,time$field);
         }
         var _loc2_:uint = 0;
         while(_loc2_ < allSupport.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,7);
            WriteUtils.write$TYPE_UINT32(param1,allSupport[_loc2_]);
            _loc2_++;
         }
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeScore() : void
      {
         hasField$0 &= 4294967287;
         score$field = new uint();
      }
      
      public function set id(param1:uint) : void
      {
         hasField$0 |= 1;
         id$field = param1;
      }
      
      public function removeTime() : void
      {
         hasField$0 &= 4294967279;
         time$field = new uint();
      }
      
      public function removeId() : void
      {
         hasField$0 &= 4294967294;
         id$field = new uint();
      }
   }
}
