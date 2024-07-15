package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.SceneDes;
   
   public interface ISceneModel
   {
       
      
      function getMapModel() : IMapModel;
      
      function getSceneData() : ISceneInsideData;
      
      function getXMLNpcDess() : Array;
      
      function getSceneSpiritModel() : ISceneSpiritModel;
      
      function getSceneDes() : SceneDes;
   }
}
