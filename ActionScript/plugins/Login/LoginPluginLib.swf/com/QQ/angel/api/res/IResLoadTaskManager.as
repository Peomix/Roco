package com.QQ.angel.api.res
{
   public interface IResLoadTaskManager
   {
      
      function addLoadTask(param1:ResLoadTask) : int;
      
      function delLoadTask(param1:ResLoadTask) : Boolean;
      
      function stopAndDelTask(param1:String = "") : void;
      
      function createVipChannel(param1:String) : Boolean;
      
      function hasVipChannel(param1:String = null) : Boolean;
      
      function removeVipChannel(param1:String) : Boolean;
      
      function getVipChannelsList() : Array;
      
      function clear(param1:String = "") : void;
   }
}

