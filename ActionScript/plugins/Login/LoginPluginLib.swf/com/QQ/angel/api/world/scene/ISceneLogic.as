package com.QQ.angel.api.world.scene
{
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.world.action.IActor;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public interface ISceneLogic extends IAngelSysAPIAware
   {
      
      function initialize(... rest) : void;
      
      function finalize() : void;
      
      function getActor() : IActor;
      
      function attachStaticScene(param1:IStaticScene) : void;
      
      function getStaticScene() : IStaticScene;
      
      function getName() : String;
      
      function getSpaceLayer() : ILayer;
      
      function getSkyLayer() : ILayer;
      
      function getGroundLayer() : ILayer;
      
      function getNpcList() : Array;
      
      function getContainer() : DisplayObjectContainer;
      
      function setRender(param1:Boolean = false) : void;
      
      function getLayerByID(param1:int) : ILayer;
      
      function getSPlaceAt(param1:Point) : ISPlace;
      
      function getItemViewAt(param1:Point) : Object;
   }
}

