package com.QQ.angel.world.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class SceneEvent extends BaseEvent
   {
      
      public static const SCENE_EVENT:String = "sceneEvent";
       
      
      public function SceneEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
