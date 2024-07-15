package com.QQ.angel.world.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class ElementViewEvent extends BaseEvent
   {
      
      public static const ON_MAGIC_ENDED:String = "onMagicEnded";
      
      public static const ON_MOTION_CHANGE:String = "onMotionChange";
      
      public static const ON_DIR_CHANGE:String = "onDirChange";
      
      public static const ON_CLOTHES_LOADED:String = "onClothesLoaded";
       
      
      public function ElementViewEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
