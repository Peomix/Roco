package com.QQ.angel.data.entity
{
   public class ItemDataDes
   {
      
      public var id:uint;
      
      public var name:String;
      
      public var description:String;
      
      public var unique:Boolean;
      
      public var type:int;
      
      public var subtype:int;
      
      public var url:String;
      
      public var price:int;
      
      public var expireTime:int;
      
      public function ItemDataDes()
      {
         super();
      }
      
      public function clone() : ItemDataDes
      {
         var _loc1_:ItemDataDes = new ItemDataDes();
         _loc1_.id = this.id;
         _loc1_.name = this.name;
         _loc1_.description = this.description;
         _loc1_.unique = this.unique;
         _loc1_.type = this.type;
         _loc1_.subtype = this.subtype;
         _loc1_.url = this.url;
         _loc1_.price = this.price;
         _loc1_.expireTime = this.expireTime;
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "[ItemDataDes]";
         _loc1_ += " id = " + this.id;
         _loc1_ += ", name = " + this.name;
         _loc1_ += ", description = " + this.description;
         _loc1_ += ", unique = " + this.unique;
         _loc1_ += ", type = " + this.type;
         _loc1_ += ", subtype = " + this.subtype;
         _loc1_ += ", url = " + this.url;
         _loc1_ += ", price = " + this.price;
         return _loc1_ + (", expireTime = " + this.expireTime);
      }
   }
}

