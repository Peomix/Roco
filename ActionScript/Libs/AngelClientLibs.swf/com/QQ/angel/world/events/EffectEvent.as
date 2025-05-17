package com.QQ.angel.world.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class EffectEvent extends BaseEvent
   {
      
      public static const LOADED_EFFECT:String = "loadedEffect";
      
      public static const END_EFFECT:String = "endEffect";
      
      public function EffectEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

