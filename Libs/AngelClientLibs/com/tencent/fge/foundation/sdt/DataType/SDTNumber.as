package com.tencent.fge.foundation.sdt.DataType
{
   import com.tencent.fge.foundation.sdt.Common.SDCore;
   import com.tencent.fge.foundation.sdt.Common.SDListenerInterface;
   import com.tencent.fge.foundation.sdt.Common.SDTBase;
   
   public class SDTNumber extends SDTBase
   {
       
      
      public function SDTNumber(param1:Number = 0, param2:Boolean = false, param3:uint = 0, param4:SDListenerInterface = null)
      {
         super(param2,param3,param4);
         this.value = param1;
      }
      
      public function set value(param1:Number) : void
      {
         var _loc2_:Object = SDCore.string2bytes(param1.toString());
         super.setValue(_loc2_);
         SDCore.freeBytes(_loc2_);
      }
      
      public function get value() : Number
      {
         var _loc1_:Object = super.getValue();
         var _loc2_:Number = Number(SDCore.bytes2string(_loc1_));
         SDCore.freeBytes(_loc1_);
         return _loc2_;
      }
   }
}
