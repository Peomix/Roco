package com.QQ.angel.world.script.autoexec
{
   public interface ITriggerManager
   {
      
      function getType() : String;
      
      function addListener(param1:ITriggerListener) : void;
      
      function watch() : void;
      
      function addTrigger(param1:XML) : Boolean;
   }
}

