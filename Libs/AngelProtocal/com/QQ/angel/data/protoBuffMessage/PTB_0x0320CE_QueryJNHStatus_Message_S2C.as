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
   
   public final class PTB_0x0320CE_QueryJNHStatus_Message_S2C extends Message implements IExternalizable
   {
       
      
      private var ever_get$field:int;
      
      private var hasField$0:uint = 0;
      
      private var times$field:int;
      
      private var num_big$field:int;
      
      private var ret_code$field:ReturnCode_Message;
      
      private var num_small$field:int;
      
      public function PTB_0x0320CE_QueryJNHStatus_Message_S2C()
      {
         super();
      }
      
      public function removeEverGet() : void
      {
         hasField$0 &= 4294967287;
         ever_get$field = new int();
      }
      
      public function removeNumSmall() : void
      {
         hasField$0 &= 4294967293;
         num_small$field = new int();
      }
      
      public function get times() : int
      {
         if(!hasTimes)
         {
            return 0;
         }
         return times$field;
      }
      
      public function set numSmall(param1:int) : void
      {
         hasField$0 |= 2;
         num_small$field = param1;
      }
      
      public function removeRetCode() : void
      {
         ret_code$field = null;
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
                     throw new IOError("Bad data format: PTB_0x0320CE_QueryJNHStatus_Message_S2C.retCode cannot be set twice.");
                  }
                  _loc3_++;
                  retCode = new ReturnCode_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,retCode);
                  break;
               case 2:
                  if(_loc4_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320CE_QueryJNHStatus_Message_S2C.numBig cannot be set twice.");
                  }
                  _loc4_++;
                  numBig = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 3:
                  if(_loc5_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320CE_QueryJNHStatus_Message_S2C.numSmall cannot be set twice.");
                  }
                  _loc5_++;
                  numSmall = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 4:
                  if(_loc6_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320CE_QueryJNHStatus_Message_S2C.times cannot be set twice.");
                  }
                  _loc6_++;
                  times = ReadUtils.read$TYPE_INT32(param1);
                  break;
               case 5:
                  if(_loc7_ != 0)
                  {
                     throw new IOError("Bad data format: PTB_0x0320CE_QueryJNHStatus_Message_S2C.everGet cannot be set twice.");
                  }
                  _loc7_++;
                  everGet = ReadUtils.read$TYPE_INT32(param1);
                  break;
               default:
                  ReadUtils.skip(param1,_loc8_ & 7);
                  break;
            }
         }
      }
      
      public function get hasTimes() : Boolean
      {
         return (hasField$0 & 4) != 0;
      }
      
      public function get hasNumBig() : Boolean
      {
         return (hasField$0 & 1) != 0;
      }
      
      public function get numBig() : int
      {
         if(!hasNumBig)
         {
            return 0;
         }
         return num_big$field;
      }
      
      public function get hasNumSmall() : Boolean
      {
         return (hasField$0 & 2) != 0;
      }
      
      public function get hasEverGet() : Boolean
      {
         return (hasField$0 & 8) != 0;
      }
      
      public function get everGet() : int
      {
         if(!hasEverGet)
         {
            return 0;
         }
         return ever_get$field;
      }
      
      public function removeTimes() : void
      {
         hasField$0 &= 4294967291;
         times$field = new int();
      }
      
      public function set retCode(param1:ReturnCode_Message) : void
      {
         ret_code$field = param1;
      }
      
      public function get numSmall() : int
      {
         if(!hasNumSmall)
         {
            return 0;
         }
         return num_small$field;
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         if(hasRetCode)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,ret_code$field);
         }
         if(hasNumBig)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,2);
            WriteUtils.write$TYPE_INT32(param1,num_big$field);
         }
         if(hasNumSmall)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,3);
            WriteUtils.write$TYPE_INT32(param1,num_small$field);
         }
         if(hasTimes)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,4);
            WriteUtils.write$TYPE_INT32(param1,times$field);
         }
         if(hasEverGet)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,5);
            WriteUtils.write$TYPE_INT32(param1,ever_get$field);
         }
      }
      
      public function get retCode() : ReturnCode_Message
      {
         return ret_code$field;
      }
      
      public function set everGet(param1:int) : void
      {
         hasField$0 |= 8;
         ever_get$field = param1;
      }
      
      public function set numBig(param1:int) : void
      {
         hasField$0 |= 1;
         num_big$field = param1;
      }
      
      public function set times(param1:int) : void
      {
         hasField$0 |= 4;
         times$field = param1;
      }
      
      public function get hasRetCode() : Boolean
      {
         return ret_code$field != null;
      }
      
      public function removeNumBig() : void
      {
         hasField$0 &= 4294967294;
         num_big$field = new int();
      }
   }
}
