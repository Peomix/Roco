package com.QQ.angel.api.data
{
   public interface IDataProxy
   {
       
      
      function insert(... rest) : Boolean;
      
      function select(... rest) : Object;
      
      function update(... rest) : Boolean;
      
      function deleted(... rest) : Boolean;
      
      function clear() : void;
      
      function getName() : String;
   }
}
