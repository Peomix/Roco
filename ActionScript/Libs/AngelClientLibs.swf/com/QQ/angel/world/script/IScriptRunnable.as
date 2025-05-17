package com.QQ.angel.world.script
{
   import com.QQ.angel.data.entity.WorldScriptDes;
   
   public interface IScriptRunnable
   {
      
      function start(param1:WorldScriptDes) : void;
      
      function execute(param1:XML) : void;
      
      function stop() : void;
      
      function isRuning() : Boolean;
      
      function getCurrent() : IScript;
   }
}

