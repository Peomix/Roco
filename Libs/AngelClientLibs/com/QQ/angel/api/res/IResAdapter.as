package com.QQ.angel.api.res
{
   public interface IResAdapter
   {
       
      
      function initialize(... rest) : void;
      
      function finalize() : void;
      
      function setResLoadTaskManager(param1:IResLoadTaskManager) : void;
      
      function requestRes(... rest) : Object;
      
      function cancelRequest(... rest) : Boolean;
      
      function disposeRes(... rest) : void;
      
      function getAdapterResType() : String;
      
      function removeAllCacheRes() : void;
      
      function stopAllResRequest() : void;
   }
}
