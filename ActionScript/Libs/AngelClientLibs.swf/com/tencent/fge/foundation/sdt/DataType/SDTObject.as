package com.tencent.fge.foundation.sdt.DataType
{
   import com.tencent.fge.foundation.sdt.Common.SDTBase;
   import flash.utils.Dictionary;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   
   use namespace flash_proxy;
   
   public dynamic class SDTObject extends Proxy
   {
      
      protected var m_dynamic:Boolean;
      
      protected var m_sdtValues:Dictionary;
      
      protected var m_otherValues:Dictionary;
      
      public function SDTObject(param1:Boolean = false)
      {
         super();
         this.m_dynamic = param1;
         if(param1)
         {
            this.m_sdtValues = new Dictionary();
            this.m_otherValues = new Dictionary();
         }
      }
      
      private static function getProperties(param1:Object, param2:Array) : void
      {
         var _loc3_:* = undefined;
         if(param2)
         {
            for(_loc3_ in param1)
            {
               param2.push(_loc3_);
            }
         }
      }
      
      private function setValue(param1:String, param2:*) : void
      {
         var _loc3_:SDTBase = null;
         var _loc4_:SDTObject = null;
         var _loc5_:String = null;
         if(this.m_sdtValues.hasOwnProperty(param1))
         {
            this.m_sdtValues[param1].value = param2;
         }
         else if(this.m_otherValues.hasOwnProperty(param1))
         {
            this.m_otherValues[param1] = param2;
         }
         else
         {
            _loc3_ = null;
            if(param2 is Boolean)
            {
               _loc3_ = new SDTBoolean(param2);
            }
            else if(param2 is int)
            {
               _loc3_ = new SDTInt(param2);
            }
            else if(param2 is uint)
            {
               _loc3_ = new SDTUInt(param2);
            }
            else if(param2 is Number)
            {
               _loc3_ = new SDTNumber(param2);
            }
            else if(param2 is String)
            {
               _loc3_ = new SDTString(param2);
            }
            else if(param2 is Date)
            {
               _loc3_ = new SDTDate(param2);
            }
            if(_loc3_)
            {
               this.m_sdtValues[param1] = _loc3_;
            }
            else if(getQualifiedClassName(param2) == "Object")
            {
               _loc4_ = new SDTObject(true);
               for(_loc5_ in param2)
               {
                  _loc4_[_loc5_] = param2[_loc5_];
               }
               this.m_otherValues[param1] = _loc4_;
            }
            else
            {
               this.m_otherValues[param1] = param2;
            }
         }
      }
      
      private function checkDynamic(param1:String) : Boolean
      {
         if(!this.m_dynamic)
         {
            throw new ReferenceError("在 " + getQualifiedClassName(this) + " 上找不到属性" + param1 + "，且没有默认值",1069);
         }
         return this.m_dynamic;
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         var _loc3_:String = param1;
         if(this.checkDynamic(_loc3_))
         {
            this.setValue(_loc3_,param2);
         }
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         var _loc2_:String = param1;
         if(this.checkDynamic(_loc2_))
         {
            if(this.m_sdtValues.hasOwnProperty(_loc2_))
            {
               return this.m_sdtValues[_loc2_].value;
            }
            if(this.m_otherValues.hasOwnProperty(_loc2_))
            {
               return this.m_otherValues[_loc2_];
            }
         }
         return undefined;
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         var _loc2_:String = param1;
         return Boolean(this.m_sdtValues) && Boolean(this.m_sdtValues.hasOwnProperty(_loc2_)) || Boolean(this.m_otherValues) && Boolean(this.m_otherValues.hasOwnProperty(_loc2_));
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean
      {
         var _loc2_:String = param1;
         if(Boolean(this.m_sdtValues) && Boolean(this.m_sdtValues.hasOwnProperty(_loc2_)))
         {
            this.deleteSdtProperty(_loc2_);
            return true;
         }
         if(Boolean(this.m_otherValues) && Boolean(this.m_otherValues.hasOwnProperty(_loc2_)))
         {
            this.deleteOtherProperty(_loc2_);
            return true;
         }
         return false;
      }
      
      private function deleteSdtProperty(param1:String) : void
      {
         SDTBase(this.m_sdtValues[param1]).dispose();
         this.m_sdtValues[param1] = null;
         delete this.m_sdtValues[param1];
      }
      
      private function deleteOtherProperty(param1:String) : void
      {
         var _loc2_:SDTObject = this.m_otherValues[param1] as SDTObject;
         if(_loc2_)
         {
            _loc2_.dispose();
         }
         this.m_otherValues[param1] = null;
         delete this.m_otherValues[param1];
      }
      
      public function dispose() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = [];
         getProperties(this.m_sdtValues,_loc1_);
         for each(_loc2_ in _loc1_)
         {
            this.deleteSdtProperty(_loc2_);
         }
         _loc1_.length = 0;
         getProperties(this.m_otherValues,_loc1_);
         for each(_loc2_ in _loc1_)
         {
            this.deleteOtherProperty(_loc2_);
         }
         _loc1_.length = 0;
      }
   }
}

