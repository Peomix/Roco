package com.QQ.angel.res
{
   public interface IResourcePool
   {
       
      
      function borrowObject(param1:Object = null) : Object;
      
      function returnObject(param1:Object, param2:Object = null) : void;
   }
}
