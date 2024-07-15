package com.QQ.angel.data.entity.tasksys.model
{
   import flash.events.IEventDispatcher;
   
   public interface IModelManager extends IEventDispatcher
   {
       
      
      function isLoaded() : Boolean;
      
      function getTaskModelByID(param1:int) : ITaskModel;
      
      function getTaskModels(param1:int = -1) : Array;
      
      function setTaskList(param1:Array) : void;
      
      function submitNpcClick(param1:int) : void;
      
      function submitTask(param1:int) : void;
      
      function acceptTask(param1:int) : void;
      
      function updateTaskCdtn(param1:int) : void;
      
      function taskIsComplete(param1:int, param2:Function) : void;
   }
}
