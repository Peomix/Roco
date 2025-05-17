package com.QQ.angel.world.scene
{
   import com.QQ.angel.data.entity.SceneDes;
   import flash.events.IEventDispatcher;
   import flash.utils.ByteArray;
   
   public interface ISceneData extends IEventDispatcher
   {
      
      function load(param1:SceneDes) : void;
      
      function getRemoteValues() : ByteArray;
      
      function getRemoteValue(param1:int) : int;
      
      function updateRemoteValue(param1:int, param2:int) : void;
      
      function getSceneDes() : SceneDes;
      
      function getGlobalCache(param1:String) : Object;
      
      function setGlobalCache(param1:String, param2:Object) : void;
      
      function setSceneCache(param1:String, param2:Object) : void;
      
      function getSceneCache(param1:String) : Object;
      
      function setDailyValue(param1:int, param2:int, param3:Boolean = false) : void;
      
      function getDailyValue(param1:int, param2:Boolean = false) : int;
      
      function setLocalValue(param1:int, param2:Object, param3:Boolean = false) : void;
      
      function getLocalValue(param1:int, param2:Boolean = false) : Object;
      
      function clear() : void;
   }
}

