package com.QQ.angel.world.scene
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class ChallengeTowerEvent extends BaseEvent
   {
      
      public static const BOSS_INIT:String = "bossInit";
      
      public static const SCENE_CLEAR:String = "sceneClear";
      
      public function ChallengeTowerEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

