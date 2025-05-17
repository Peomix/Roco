package com.QQ.angel.world
{
   import com.QQ.angel.api.IWorldAPI;
   
   public interface IAngelWorld extends IWorldAPI
   {
      
      function loadScene(param1:int, param2:int = 1) : void;
      
      function onChangeSceneRes(param1:Object) : void;
   }
}

