package com.QQ.angel.world.render
{
   public class MotionFCS
   {
      
      public var type:int;
      
      public var frameTimes:Array;
      
      public var yOffsets:Array;
      
      public var labels:Array;
      
      public function MotionFCS(param1:int, param2:Array, param3:Array = null, param4:Array = null)
      {
         super();
         this.type = param1;
         this.frameTimes = param2;
         this.labels = param3;
         this.yOffsets = param4;
      }
      
      public function getFrameTimes(param1:int) : int
      {
         if(this.frameTimes != null)
         {
            return this.frameTimes[param1];
         }
         return 1;
      }
      
      public function getFrameLabel(param1:int) : String
      {
         if(this.labels != null)
         {
            return this.labels[param1];
         }
         return "";
      }
      
      public function getYOffsets(param1:int) : int
      {
         if(this.yOffsets == null)
         {
            return 0;
         }
         return this.yOffsets[param1];
      }
      
      public function reset() : void
      {
      }
   }
}

