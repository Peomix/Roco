package com.QQ.angel.world.scene
{
   import flash.geom.Rectangle;
   import flash.net.URLLoader;
   
   public interface ISceneAdapter
   {
      
      function onCommand(param1:int, param2:Object) : *;
      
      function getSceneData() : ISceneData;
      
      function createMapArea(param1:Rectangle) : IMapArea;
      
      function createURLLoader() : URLLoader;
      
      function getChallengeTower() : IChallengeTower;
      
      function addSceneCMDLogics(param1:ISceneCMDLogic, param2:int) : void;
   }
}

