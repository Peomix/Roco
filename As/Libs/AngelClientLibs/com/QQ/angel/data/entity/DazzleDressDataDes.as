package com.QQ.angel.data.entity
{
   public class DazzleDressDataDes
   {
      
      public static const timeLimitString:Array = ["七天","三十天","不过期"];
       
      
      public var id:uint;
      
      public var name:String;
      
      public var type:int;
      
      public var score:int;
      
      public var recoverable:Boolean;
      
      public var recoverprice:int;
      
      public var description:String;
      
      public var prices:Array;
      
      public var isset:int;
      
      public var isvip:Boolean;
      
      public var intime:Number;
      
      public var outtime:Number;
      
      public var url:String;
      
      public function DazzleDressDataDes()
      {
         super();
      }
      
      public function clone() : DazzleDressDataDes
      {
         var _loc1_:DazzleDressDataDes = new DazzleDressDataDes();
         _loc1_.id = this.id;
         _loc1_.name = this.name;
         _loc1_.type = this.type;
         _loc1_.score = this.score;
         _loc1_.recoverable = this.recoverable;
         _loc1_.recoverprice = this.recoverprice;
         _loc1_.description = this.description;
         _loc1_.prices = this.prices;
         _loc1_.isset = this.isset;
         _loc1_.isvip = this.isvip;
         _loc1_.intime = this.intime;
         _loc1_.outtime = this.outtime;
         _loc1_.url = this.url;
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc1_:String = "[DazzleDataDes]";
         _loc1_ += " id = " + this.id;
         _loc1_ += ", name = " + this.name;
         _loc1_ += ", type = " + this.type;
         _loc1_ += ", score = " + this.score;
         _loc1_ += ", recoverable = " + this.recoverable;
         _loc1_ += ", recoverprice = " + this.recoverprice;
         _loc1_ += ", description = " + this.description;
         _loc1_ += ", prices = " + this.prices;
         _loc1_ += ", isset = " + this.isset;
         _loc1_ += ", isvip = " + this.isvip;
         _loc1_ += ", intime = " + this.intime;
         _loc1_ += ", outtime = " + this.outtime;
         return _loc1_ + (", url = " + this.url);
      }
   }
}
