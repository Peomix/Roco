package com.tencent.fge.foundation.sdt.DataType
{
   import com.tencent.fge.foundation.sdt.Common.SDCore;
   import com.tencent.fge.foundation.sdt.Common.SDListenerInterface;
   import com.tencent.fge.foundation.sdt.Common.SDTBase;
   
   public class SDTBoolean extends SDTBase
   {
       
      
      public function SDTBoolean(param1:Boolean = false, param2:Boolean = false, param3:uint = 0, param4:SDListenerInterface = null)
      {
         super(param2,param3,param4);
         this.value = param1;
      }
      
      public function set value(param1:Boolean) : void
      {
         var _loc2_:int = int(Math.random() * 100);
         if(param1)
         {
            _loc2_ = 255 - _loc2_;
         }
         var _loc3_:Object = SDCore.string2bytes(_loc2_.toString());
         super.setValue(_loc3_);
         SDCore.freeBytes(_loc3_);
      }
      
      public function get value() : Boolean
      {
         var _loc1_:Object = super.getValue();
         var _loc2_:int = int(SDCore.bytes2string(_loc1_));
         var _loc3_:* = _loc2_ > 100;
         SDCore.freeBytes(_loc1_);
         return _loc3_;
      }
      
      public function not() : Boolean
      {
         var _loc1_:* = !this.value;
         this.value = _loc1_;
         return _loc1_;
      }
   }
}
