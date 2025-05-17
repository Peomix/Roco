package com.QQ.angel.api.world
{
   public interface IAIChip
   {
      
      function getType() : int;
      
      function attach(param1:Object) : void;
      
      function active(param1:Object = null) : void;
      
      function dispose() : void;
   }
}

