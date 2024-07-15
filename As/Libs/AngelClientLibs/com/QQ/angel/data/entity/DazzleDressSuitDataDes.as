package com.QQ.angel.data.entity
{
   public class DazzleDressSuitDataDes
   {
       
      
      public var id:uint;
      
      public var name:String;
      
      public var daAvatar:Array;
      
      public function DazzleDressSuitDataDes()
      {
         super();
         this.daAvatar = [];
      }
      
      public function clone() : DazzleDressSuitDataDes
      {
         var _loc1_:DazzleDressSuitDataDes = new DazzleDressSuitDataDes();
         _loc1_.id = this.id;
         _loc1_.name = this.name;
         var _loc2_:int = 0;
         while(_loc2_ < this.daAvatar.length)
         {
            _loc1_.daAvatar[_loc2_] = this.daAvatar[_loc2_];
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "[DazzleDataSuitDes]";
         _loc1_ += " id = " + this.id;
         _loc1_ += ", name = " + this.name;
         return _loc1_ + (", avatar = [" + this.daAvatar + "]");
      }
   }
}
