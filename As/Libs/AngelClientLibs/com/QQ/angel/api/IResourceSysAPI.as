package com.QQ.angel.api
{
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   
   public interface IResourceSysAPI
   {
       
      
      function getResLoadTaskManager() : IResLoadTaskManager;
      
      function addResAdapter(param1:IResAdapter) : void;
      
      function getResAdapter(param1:String) : IResAdapter;
      
      function getMagicClsByID(param1:uint) : Class;
      
      function getEffectClsByID(param1:uint) : Class;
      
      function borrowObj(param1:uint, param2:int = 0) : Object;
      
      function giveBackObj(param1:uint, param2:Object, param3:int = 0) : void;
      
      function borrowObjByUrl(param1:String, param2:String) : Object;
      
      function giveBackObjByUrl(param1:String, param2:String, param3:Object) : void;
   }
}
