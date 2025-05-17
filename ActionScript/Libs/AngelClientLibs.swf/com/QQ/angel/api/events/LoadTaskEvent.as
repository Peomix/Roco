package com.QQ.angel.api.events
{
   import com.QQ.angel.api.res.ResData;
   import flash.events.Event;
   
   public class LoadTaskEvent extends BaseEvent
   {
      
      public static const TASK_BEGIN:String = "taskBegin";
      
      public static const TASK_COMPLETE:String = "taskComplete";
      
      public static const TASK_ERROR:String = "taskError";
      
      public static const TASK_PROGRESS:String = "taskProgress";
      
      public var taskID:int;
      
      public function LoadTaskEvent(param1:String = "taskComplete", param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      public function get resData() : ResData
      {
         return this.data as ResData;
      }
      
      override public function clone() : Event
      {
         var _loc1_:LoadTaskEvent = super.clone() as LoadTaskEvent;
         _loc1_.taskID = this.taskID;
         return _loc1_;
      }
   }
}

