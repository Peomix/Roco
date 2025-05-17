package com.QQ.angel.data.entity.world.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class NpcModelEvent extends BaseEvent
   {
      
      public static const ON_MODEL_UPDATE:String = "onModelUpdate";
      
      public static const ON_ADD_NPC:String = "onAddNpc";
      
      public static const ON_REMOVE_NPC:String = "onRemoveNpc";
      
      public static const ON_HEADICON_CHANGE:String = "onHeadiconChange";
      
      public static const ON_TSTATE_CHANGE:String = "onTStateChange";
      
      public static const ON_ASSET_LOADED:String = "onAssetLoaded";
      
      public function NpcModelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}

