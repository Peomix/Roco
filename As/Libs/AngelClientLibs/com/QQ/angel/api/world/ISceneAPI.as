package com.QQ.angel.api.world
{
   import com.QQ.angel.api.world.scene.ISceneLogic;
   
   public interface ISceneAPI
   {
       
      
      function getSceneLogic() : ISceneLogic;
      
      function getSceneModel(param1:int = -1, param2:int = 1) : Object;
      
      function isBuilded() : Boolean;
      
      function setSceneRender(param1:Boolean = false) : void;
   }
}
