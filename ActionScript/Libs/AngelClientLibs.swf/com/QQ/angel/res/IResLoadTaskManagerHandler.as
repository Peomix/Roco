package com.QQ.angel.res
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   
   public interface IResLoadTaskManagerHandler
   {
      
      function onTaskProgress(param1:*, param2:ProgressEvent) : void;
      
      function onTaskOpen(param1:*, param2:Event) : void;
      
      function onTaskError(param1:*, param2:ErrorEvent) : void;
      
      function onTaskComplete(param1:*, param2:Event) : void;
      
      function onTasksAllComplete(param1:*, param2:Event) : void;
   }
}

