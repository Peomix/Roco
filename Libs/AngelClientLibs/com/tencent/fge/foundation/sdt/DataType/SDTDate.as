package com.tencent.fge.foundation.sdt.DataType
{
   import com.tencent.fge.foundation.sdt.Common.SDCore;
   import com.tencent.fge.foundation.sdt.Common.SDListenerInterface;
   import com.tencent.fge.foundation.sdt.Common.SDTBase;
   
   public class SDTDate extends SDTBase
   {
       
      
      public function SDTDate(param1:Date = null, param2:Boolean = false, param3:uint = 0, param4:SDListenerInterface = null)
      {
         super(param2,param3,param4);
         if(param1 == null)
         {
            param1 = new Date();
         }
         this.value = param1;
      }
      
      public function set value(param1:Date) : void
      {
         var _loc2_:Object = SDCore.string2bytes(param1.getTime().toString());
         super.setValue(_loc2_);
         SDCore.freeBytes(_loc2_);
      }
      
      public function get value() : Date
      {
         var _loc1_:Object = super.getValue();
         var _loc2_:Number = Number(SDCore.bytes2string(_loc1_));
         var _loc3_:Date = new Date();
         _loc3_.setTime(_loc2_);
         SDCore.freeBytes(_loc1_);
         return _loc3_;
      }
   }
}
