package com.QQ.angel.res
{
   import com.QQ.angel.api.res.ResLoadTask;
   
   public interface IResChannel
   {
       
      
      function addTask(param1:ResLoadTask) : int;
      
      function delTask(param1:ResLoadTask) : Boolean;
      
      function isRunning() : Boolean;
      
      function start() : void;
      
      function pause() : void;
      
      function resume() : void;
      
      function clear() : void;
   }
}
