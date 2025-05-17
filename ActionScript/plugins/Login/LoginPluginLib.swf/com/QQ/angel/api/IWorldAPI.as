package com.QQ.angel.api
{
   import com.QQ.angel.api.world.INPCSysAPI;
   import com.QQ.angel.api.world.IRoleSysAPI;
   import com.QQ.angel.api.world.ISceneAPI;
   
   public interface IWorldAPI
   {
      
      function getRoleSysAPI() : IRoleSysAPI;
      
      function getNPCSysAPI() : INPCSysAPI;
      
      function getSceneAPI() : ISceneAPI;
      
      function setRender(param1:Boolean = false) : void;
   }
}

