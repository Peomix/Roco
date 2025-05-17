package com.QQ.angel.data.entity.tasksys
{
   public class TaskState
   {
      
      public static const NOTACCEPTED:int = 1;
      
      public static const ACCEPTED:int = 2;
      
      public static const DONE:int = 3;
      
      public static const LOCK:int = 5;
      
      public static const C_OK:uint = 1;
      
      public static const C_NO:uint = 0;
      
      public var id:int;
      
      public var state:int;
      
      public function TaskState(param1:int = 0, param2:int = -1)
      {
         super();
         this.id = param1;
         this.state = param2;
      }
   }
}

