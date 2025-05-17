package com.QQ.angel.world.script
{
   import com.QQ.angel.data.entity.NPCCDConvert;
   import flash.events.IEventDispatcher;
   
   public interface IScript extends IEventDispatcher
   {
      
      function setSource(param1:NPCCDConvert) : void;
      
      function getSource() : NPCCDConvert;
      
      function setGlobalVars(param1:Object) : void;
      
      function execute(param1:XML) : void;
      
      function dispose() : void;
      
      function getType() : String;
   }
}

