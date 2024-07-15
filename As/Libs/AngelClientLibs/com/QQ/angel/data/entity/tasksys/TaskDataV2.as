package com.QQ.angel.data.entity.tasksys
{
   public class TaskDataV2
   {
       
      
      public var themeID:int;
      
      public var storyID:int;
      
      public var taskID:int;
      
      public var state:int;
      
      public var type:int;
      
      public var subType:int;
      
      public var cdtns:Array;
      
      public var submitCDtnVO:Object;
      
      public var acceptCDtnVO:Object;
      
      public function TaskDataV2()
      {
         super();
      }
      
      public function clone() : TaskDataV2
      {
         var _loc1_:TaskDataV2 = new TaskDataV2();
         _loc1_.storyID = this.storyID;
         _loc1_.taskID = this.taskID;
         _loc1_.state = this.state;
         _loc1_.type = this.type;
         _loc1_.subType = this.subType;
         return _loc1_;
      }
   }
}
