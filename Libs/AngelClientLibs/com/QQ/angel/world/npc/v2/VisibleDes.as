package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.NpcFuncDes;
   import com.QQ.angel.data.entity.tasksys.TaskState;
   import com.QQ.angel.data.entity.world.CareTaskID;
   import com.QQ.angel.data.entity.world.VisibleXML;
   
   public class VisibleDes
   {
       
      
      public var attachDes:NpcDes;
      
      public var funcDes:NpcFuncDes;
      
      public var visibleXML:VisibleXML;
      
      public var careTaskID:CareTaskID;
      
      public var currState:TaskState;
      
      public var exist:Boolean = false;
      
      public function VisibleDes()
      {
         super();
      }
   }
}
