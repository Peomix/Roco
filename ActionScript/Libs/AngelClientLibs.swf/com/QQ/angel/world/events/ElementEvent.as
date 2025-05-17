package com.QQ.angel.world.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class ElementEvent extends BaseEvent
   {
      
      public static const ON_MOVE_START:String = "onMoveStart";
      
      public static const ON_MOVE_FINISHED:String = "onMoveFinished";
      
      public static const ON_NEW_POSITION:String = "onNewPosition";
      
      public function ElementEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

