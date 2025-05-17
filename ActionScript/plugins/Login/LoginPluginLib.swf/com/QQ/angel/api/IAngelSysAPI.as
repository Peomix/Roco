package com.QQ.angel.api
{
   public interface IAngelSysAPI
   {
      
      function getMSGAPI() : IMsgAPI;
      
      function getWorldAPI() : IWorldAPI;
      
      function getNetSysAPI() : INetSysAPI;
      
      function getGDataAPI() : IGlobalDataAPI;
      
      function getUISysAPI() : IUISysAPI;
      
      function getGEventAPI() : IGlobalEventAPI;
      
      function getMediaSysAPI() : IMediaSysAPI;
      
      function getResSysAPI() : IResourceSysAPI;
      
      function getPlugSysAPI() : IPlugManagerAPI;
      
      function getExternalAPI() : IExternalAPI;
      
      function getAccessPermission() : IAccessPermission;
      
      function setRender(param1:Boolean = false) : void;
      
      function getIsRender() : Boolean;
   }
}

