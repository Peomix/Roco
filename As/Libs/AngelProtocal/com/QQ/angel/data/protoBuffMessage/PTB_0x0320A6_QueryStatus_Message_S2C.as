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
   
   public final class PTB_0x0320A6_QueryStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var process$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var is_get_spirit$field:uint;
      
      private var is_get_ticket$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var pray_pet_id$field:uint;
      
      public function PTB_0x0320A6_QueryStatus_Message_S2C()
      {
         super();
      }
      
      public function get hasPrayPetId() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set prayPetId(param1:uint) : void
      {
         hasField$0 |= 4;
         pray_pet_id$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function removeProcess() : void
      {
         hasField$0 &= 4294967293;
         process$field = new uint();
      }
      
      public function get prayPetId() : uint
      {
         if(!hasPrayPetId)
         {
            return 0;
         }
         return pray_pet_id$field;
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
                     throw new IOError("Bad data format: PTB_0x0320A6_QueryStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320A6_QueryStatus_Message_S2C.isGetTicket cannot be set twice.");
                  }
                  _loc4_++;
                  isGetTicket = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320A6_QueryStatus_Message_S2C.process cannot be set twice.");
                  }
                  _loc5_++;
                  process = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320A6_QueryStatus_Message_S2C.prayPetId cannot be set twice.");
                  }
                  _loc6_++;
                  prayPetId = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320A6_QueryStatus_Message_S2C.isGetSpirit cannot be set twice.");
                  }
                  _loc7_++;
                  isGetSpirit = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function removeIsGetTicket() : void
      {
         hasField$0 &= 4294967294;
         is_get_ticket$field = new uint();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasIsGetTicket)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,is_get_ticket$field);
         }
         if(hasProcess)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,process$field);
         }
         if(hasPrayPetId)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,pray_pet_id$field);
         }
         if(hasIsGetSpirit)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,is_get_spirit$field);
         }
      }
      
      public function removePrayPetId() : void
      {
         hasField$0 &= 4294967291;
         pray_pet_id$field = new uint();
      }
      
      public function set process(param1:uint) : void
      {
         hasField$0 |= 2;
         process$field = param1;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get isGetSpirit() : uint
      {
         if(!hasIsGetSpirit)
         {
            return 0;
         }
         return is_get_spirit$field;
      }
      
      public function get hasIsGetSpirit() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get process() : uint
      {
         if(!hasProcess)
         {
            return 0;
         }
         return process$field;
      }
      
      public function set isGetTicket(param1:uint) : void
      {
         hasField$0 |= 1;
         is_get_ticket$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function get hasProcess() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get isGetTicket() : uint
      {
         if(!hasIsGetTicket)
         {
            return 0;
         }
         return is_get_ticket$field;
      }
      
      public function removeIsGetSpirit() : void
      {
         hasField$0 &= 4294967287;
         is_get_spirit$field = new uint();
      }
      
      public function set isGetSpirit(param1:uint) : void
      {
         hasField$0 |= 8;
         is_get_spirit$field = param1;
      }
      
      public function get hasIsGetTicket() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
   }
}
