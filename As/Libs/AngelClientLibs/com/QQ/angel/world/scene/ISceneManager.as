package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.world.ISceneAPI;
   import com.QQ.angel.data.entity.SceneDes;
   import flash.geom.Point;
   
   public interface ISceneManager extends ISceneAPI
   {
       
      
      function load(param1:SceneDes, param2:ILoadingView) : void;
      
      function unload() : void;
      
      function findPath(param1:Point, param2:Point, param3:int = 0) : Array;
      
      function isWalkable(param1:Point) : Boolean;
      
      function getCurrentScene() : SceneDes;
      
      function getHero() : IHero;
   }
}
