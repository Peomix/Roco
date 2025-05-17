package com.QQ.angel.data.entity.tasksys.model
{
   import com.QQ.angel.data.entity.tasksys.TaskDataV2;
   import flash.events.IEventDispatcher;
   
   public interface ITaskModel extends IEventDispatcher
   {
      
      function getID() : int;
      
      function getStoryID() : int;
      
      function accept() : void;
      
      function submit() : void;
      
      function getValue() : TaskDataV2;
      
      function isAccepted() : Boolean;
      
      function isComplete(param1:Function) : void;
      
      function isDone() : Boolean;
      
      function updateCdtn(param1:Object = null) : void;
      
      function isActive() : Boolean;
   }
}

