package com.QQ.angel.api
{
   import com.QQ.angel.api.events.IRenderListener;
   import com.QQ.angel.api.events.ITickListener;
   import flash.events.IEventDispatcher;
   
   public interface IGlobalEventAPI
   {
       
      
      function addTickListener(param1:ITickListener) : void;
      
      function removeTickListener(param1:ITickListener) : void;
      
      function addRenderListener(param1:IRenderListener) : void;
      
      function removeRenderListener(param1:IRenderListener) : void;
      
      function setRenderTimer(param1:Boolean = false) : void;
      
      function get angelEventDispatcher() : IEventDispatcher;
      
      function addCmdListener(param1:String, param2:Object) : void;
      
      function removeCmdListener(param1:String) : void;
      
      function cmdExecuted(param1:String, param2:Object) : void;
   }
}
