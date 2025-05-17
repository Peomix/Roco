package com.QQ.angel.data.entity.world
{
   import flash.events.IEventDispatcher;
   
   public interface ISceneSpiritModel extends IEventDispatcher
   {
      
      function getAreas() : Array;
      
      function addSpirit(param1:SceneSpiritKey, param2:int = 0) : void;
      
      function removeSpirit(param1:SceneSpiritKey) : void;
      
      function removeAllSpirit() : void;
      
      function removeAll() : void;
      
      function update() : void;
      
      function getKeys() : Array;
      
      function getSceneSpirits() : Array;
   }
}

