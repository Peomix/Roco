package com.tencent.fge.foundation.sdt.DataType
{
   import com.tencent.fge.foundation.sdt.Common.SDCore;
   import com.tencent.fge.foundation.sdt.Common.SDListenerInterface;
   import com.tencent.fge.foundation.sdt.Common.SDTBase;
   
   public class SDTString extends SDTBase
   {
      
      public function SDTString(param1:String = "", param2:Boolean = false, param3:uint = 0, param4:SDListenerInterface = null)
      {
         super(param2,param3,param4);
         this.value = param1;
      }
      
      public function set value(param1:String) : void
      {
         var _loc2_:Object = SDCore.string2bytes(param1);
         super.setValue(_loc2_);
         SDCore.freeBytes(_loc2_);
      }
      
      public function get value() : String
      {
         var _loc1_:Object = super.getValue();
         var _loc2_:String = SDCore.bytes2string(_loc1_);
         SDCore.freeBytes(_loc1_);
         return _loc2_;
      }
   }
}

