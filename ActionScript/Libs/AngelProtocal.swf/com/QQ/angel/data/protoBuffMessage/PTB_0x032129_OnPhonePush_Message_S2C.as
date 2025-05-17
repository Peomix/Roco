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
   
   public final class PTB_0x032129_OnPhonePush_Message_S2C extends Message implements IExternalizable
   {
      
      private var hasField$0:uint = 0;
      
      private var send$field:uint;
      
      private var name$field:String;
      
      private var uin$field:uint;
      
      public function PTB_0x032129_OnPhonePush_Message_S2C()
      {
         super();
      }
      
      public function get hasSend() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasName() : Boolean
      {
         return name$field != null;
      }
      
      public function get send() : uint
      {
         if(!hasSend)
         {
            return 0;
         }
         return send$field;
      }
      
      public function get name() : String
      {
         if(!hasName)
         {
            return "";
         }
         return name$field;
      }
      
      public function set send(param1:uint) : void
      {
         hasField$0 |= 2;
         send$field = param1;
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc6_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc6_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc6_ >>> 3)
            {
               case 1:
                  if(_loc3_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032129_OnPhonePush_Message_S2C.uin cannot be set twice.");
                  }
                  _loc3_++;
                  uin = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032129_OnPhonePush_Message_S2C.send cannot be set twice.");
                  }
                  _loc4_++;
                  send = ReadUtils.read$TYPE_UINT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x032129_OnPhonePush_Message_S2C.name cannot be set twice.");
                  }
                  _loc5_++;
                  name = ReadUtils.read$TYPE_STRING(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc6_ & 7);
                  break;
            }
         }
      }
      
      public function set name(param1:String) : void
      {
         name$field = param1;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasUin)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,uin$field);
         }
         if(hasSend)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_UINT32(param1,send$field);
         }
         if(hasName)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,3);
            WriteUtils.write$TYPE_STRING(param1,name$field);
         }
      }
      
      public function get hasUin() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get uin() : uint
      {
         if(!hasUin)
         {
            return 0;
         }
         return uin$field;
      }
      
      public function removeSend() : void
      {
         hasField$0 &= 4294967293;
         send$field = new uint();
      }
      
      public function removeName() : void
      {
         name$field = null;
      }
      
      public function set uin(param1:uint) : void
      {
         hasField$0 |= 1;
         uin$field = param1;
      }
      
      public function removeUin() : void
      {
         hasField$0 &= 4294967294;
         uin$field = new uint();
      }
   }
}

