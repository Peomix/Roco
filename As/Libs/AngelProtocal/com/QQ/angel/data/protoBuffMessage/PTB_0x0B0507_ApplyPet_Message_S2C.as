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
   
   public final class PTB_0x0B0507_ApplyPet_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var status$field:uint;
      
      private var hasField$0:uint = 0;
      
      private var cd_vip$field:uint;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var status_vip$field:uint;
      
      private var cd$field:uint;
      
      public function PTB_0x0B0507_ApplyPet_Message_S2C()
      {
         super();
      }
      
      public function removeCd() : void
      {
         hasField$0 &= 4294967291;
         cd$field = new uint();
      }
      
      public function set cd(param1:uint) : void
      {
         hasField$0 |= 4;
         cd$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
      }
      
      public function get statusVip() : uint
      {
         if(!hasStatusVip)
         {
            return 0;
         }
         return status_vip$field;
      }
      
      public function get hasStatusVip() : Boolean
      {
         return (hasField$0 & 2) != 0;
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
                     throw new IOError("Bad data format: PTB_0x0B0507_ApplyPet_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0B0507_ApplyPet_Message_S2C.status cannot be set twice.");
                  }
                  _loc4_++;
                  status = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0B0507_ApplyPet_Message_S2C.statusVip cannot be set twice.");
                  }
                  _loc5_++;
                  statusVip = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0B0507_ApplyPet_Message_S2C.cd cannot be set twice.");
                  }
                  _loc6_++;
                  cd = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0B0507_ApplyPet_Message_S2C.cdVip cannot be set twice.");
                  }
                  _loc7_++;
                  cdVip = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function removeStatus() : void
      {
         hasField$0 &= 4294967294;
         status$field = new uint();
      }
      
      public function get hasCdVip() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get hasCd() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function set statusVip(param1:uint) : void
      {
         hasField$0 |= 2;
         status_vip$field = param1;
      }
      
      public function removeCdVip() : void
      {
         hasField$0 &= 4294967287;
         cd_vip$field = new uint();
      }
      
      public function set status(param1:uint) : void
      {
         hasField$0 |= 1;
         status$field = param1;
      }
      
      public function removeStatusVip() : void
      {
         hasField$0 &= 4294967293;
         status_vip$field = new uint();
      }
      
      public function get cd() : uint
      {
         if(!hasCd)
         {
            return 0;
         }
         return cd$field;
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
         if(hasStatusVip)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_UINT32(param1,status_vip$field);
         }
         if(hasCd)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_UINT32(param1,cd$field);
         }
         if(hasCdVip)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_UINT32(param1,cd_vip$field);
         }
      }
      
      public function get hasStatus() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function get status() : uint
      {
         if(!hasStatus)
         {
            return 0;
         }
         return status$field;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function set cdVip(param1:uint) : void
      {
         hasField$0 |= 8;
         cd_vip$field = param1;
      }
      
      public function get cdVip() : uint
      {
         if(!hasCdVip)
         {
            return 0;
         }
         return cd_vip$field;
      }
   }
}
