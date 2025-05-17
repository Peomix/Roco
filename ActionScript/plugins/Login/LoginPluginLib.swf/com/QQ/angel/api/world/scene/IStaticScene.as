package com.QQ.angel.api.world.scene
{
   public interface IStaticScene
   {
      
      function initialize(... rest) : void;
      
      function finalize() : void;
      
      function addLayer(param1:ILayer) : void;
      
      function removeLayer(param1:int) : void;
      
      function getLayer(param1:int) : ILayer;
   }
}

