package com.QQ.angel.data.protoBuffMessage
{
   import com.tencent.protobuf.*;
   import flash.utils.IDataInput;
   import flash.utils.IExternalizable;
   
   public final class PTB_0x0300A7_OnCourageRewardNotify_Message_S2C extends Message implements IExternalizable
   {
      
      public var item:Array = [];
      
      public function PTB_0x0300A7_OnCourageRewardNotify_Message_S2C()
      {
         super();
      }
      
      final override public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:ItemInfoChanged32_Message = null;
         while(param1.bytesAvailable > param2)
         {
            _loc3_ = uint(ReadUtils.read$TYPE_UINT32(param1));
            switch(_loc3_ >>> 3)
            {
               case 1:
                  _loc4_ = new ItemInfoChanged32_Message();
                  ReadUtils.read$TYPE_MESSAGE(param1,_loc4_);
                  item.push(_loc4_);
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
         while(_loc2_ < item.length)
         {
            WriteUtils.writeTag(param1,WireType.LENGTH_DELIMITED,1);
            WriteUtils.write$TYPE_MESSAGE(param1,item[_loc2_]);
            _loc2_++;
         }
      }
   }
}

