package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x03214E_QueryActivities_Message_S2C extends Message implements IExternalizable
   {
       
      
      public var activities:Array;
      
      public function PTB_0x03214E_QueryActivities_Message_S2C()
      {
         activities = [];
         super();
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
                     ReadUtils.readPackedRepeated(param1,ReadUtils.read$TYPE_UINT32,activities);
                  }
                  else
                  {
                     activities.push(ReadUtils.read$TYPE_UINT32(param1));
                  }
                  break;
               default:
                  ReadUtils.skip(param1,_loc3_ & 7);
                  break;
            }
         }
      }
      
      final override public function writeToBuffer(param1:WritingBuffer) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < activities.length)
         {
            WriteUtils.writeTag(param1,WireType.VARINT,1);
            WriteUtils.write$TYPE_UINT32(param1,activities[_loc2_]);
            _loc2_++;
         }
      }
   }
}
