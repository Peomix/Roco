package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x032157_OnWeapon_Message_S2C extends Message implements IExternalizable
   {
      
      public var itemArray:Array = [];
      
      public function PTB_0x032157_OnWeapon_Message_S2C()
      {
         super();
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < itemArray.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,itemArray[_loc2_]);
            _loc2_++;
         }
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:uint = 0;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc3_ >>> 3)
            {
               case 1:
                  if((_loc3_ & 7) == WireType.LENGTH_DELIMITED)
                  {
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,itemArray);
                  }
                  else
                  {
                     itemArray.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
                  break;
            }
         }
      }
   }
}

