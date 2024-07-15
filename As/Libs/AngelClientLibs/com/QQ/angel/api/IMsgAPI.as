package com.QQ.angel.api
{
   public interface IMsgAPI
   {
       
      
      function onRenderChange(param1:Boolean) : void;
      
      function chunnelPush(param1:Object) : void;
      
      function chunnelPop(param1:Object = null) : Object;
      
      function setAutoRun(param1:Boolean = true) : void;
      
      function manualRun(param1:Boolean = true) : void;
   }
}
