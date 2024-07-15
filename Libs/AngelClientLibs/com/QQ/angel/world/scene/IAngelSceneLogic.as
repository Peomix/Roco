package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.world.scene.ISceneLogic;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.system.ApplicationDomain;
   
   public interface IAngelSceneLogic extends ISceneLogic
   {
       
      
      function setSceneAdapter(param1:ISceneAdapter) : void;
      
      function getWalkData() : Array;
      
      function getWalkAreaAsset() : Class;
      
      function setCurrDomain(param1:ApplicationDomain) : void;
      
      function getCurrDomain() : ApplicationDomain;
      
      function setRunLevel(param1:int = 0) : void;
      
      function onWorldInited(param1:IHero) : void;
      
      function itemAcceptMagic(param1:int, param2:Point, param3:uint = 0) : void;
      
      function getObjectByName(param1:String) : DisplayObject;
   }
}
