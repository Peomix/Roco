package com.QQ.angel.world.scene.events
{
   import com.QQ.angel.api.events.BaseEvent;
   
   public class AngelSceneModelEvent extends BaseEvent
   {
      
      public static const ADD_DATA:String = "addData";
      
      public static const REMOVE_DATA:String = "removeData";
      
      public static const UPDATE_DATA:String = "updateData";
       
      
      public function AngelSceneModelEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
