package com.QQ.angel.data.entity.world
{
   public class SceneSpiritKey
   {
      
      public var id:uint;
      
      public var caughtTime:uint;
      
      public var headTxt:String;
      
      public var headIcon:int = 0;
      
      public var words:Array;
      
      public var clickListener:Function;
      
      public var isMotion:Boolean = false;
      
      public var direction:int = 0;
      
      public function SceneSpiritKey(param1:uint = 0, param2:uint = 0, param3:Function = null)
      {
         super();
         this.id = param1;
         this.caughtTime = param2;
         this.clickListener = param3;
      }
      
      public function equal(param1:SceneSpiritKey) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return param1.id == this.id && param1.caughtTime == this.caughtTime;
      }
   }
}

