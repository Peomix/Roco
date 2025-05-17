package com.QQ.angel.world.vo
{
   public class Avatar
   {
      
      public var styleID:uint = 0;
      
      public var version:int = 0;
      
      public var motionType:int = 0;
      
      public var totalFrame:int = 0;
      
      public var useCounts:int = 0;
      
      public var timer:int;
      
      public var frames:Array;
      
      public function Avatar()
      {
         super();
      }
      
      public function toString() : String
      {
         return "{id:" + this.styleID + ",ver:" + this.version + ",motionType:" + this.motionType + "}";
      }
   }
}

