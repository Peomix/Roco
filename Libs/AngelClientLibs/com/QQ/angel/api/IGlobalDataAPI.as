package com.QQ.angel.api
{
   import com.QQ.angel.api.data.IDataProxy;
   
   public interface IGlobalDataAPI
   {
       
      
      function addDataProxy(param1:IDataProxy) : void;
      
      function getDataProxy(param1:String) : IDataProxy;
      
      function addGlobalVal(param1:String, param2:Object) : void;
      
      function getGlobalVal(param1:String) : Object;
      
      function removeGlobalVal(param1:String) : Boolean;
      
      function getLocalDataProxy() : IDataProxy;
   }
}
