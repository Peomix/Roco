package com.QQ.angel.world.scene.events
{
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.world.scene.data.AngelSceneContext;
   
   public class AngelSceneEvent extends BaseEvent
   {
      
      public static const ON_SWF_LOADED:String = "onSwfLoaded";
      
      public static const ON_CONF_LOADED:String = "onConfLoaded";
      
      public static const ON_DATA_LOADED:String = "onDataLoaded";
      
      public static const ON_INSTALL_ERROR:String = "onInstallError";
      
      public static const ON_INSTALL_SUCCESS:String = "onInstallSuccess";
       
      
      public var context:AngelSceneContext;
      
      public function AngelSceneEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
