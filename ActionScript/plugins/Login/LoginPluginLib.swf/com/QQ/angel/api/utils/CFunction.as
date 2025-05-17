package com.QQ.angel.api.utils
{
   public class CFunction
   {
      
      public var target:Object;
      
      public var handler:Function;
      
      public var params:Array;
      
      public function CFunction(param1:Function, param2:Object = null, param3:Array = null)
      {
         super();
         this.target = param2;
         this.handler = param1;
         this.params = param3;
      }
      
      public function call(... rest) : *
      {
         if(this.handler != null)
         {
            if((rest as Array).length != 0)
            {
               return this.handler.apply(this.target,rest);
            }
            return this.handler.apply(this.target,null);
         }
      }
      
      public function apply(param1:Array) : *
      {
         return this.handler.apply(this.target,param1);
      }
      
      public function invoke() : *
      {
         return this.apply(this.params);
      }
      
      public function clear() : void
      {
         this.params = null;
         this.target = null;
         this.handler = null;
      }
   }
}

