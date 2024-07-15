package com.QQ.angel.data.entity
{
   public class SysEventDes
   {
      
      public static const ONLINE:int = 101;
      
      public static const LEVEL_UP:int = 102;
      
      public static const GAME_ENTER_TOP_LIST:int = 103;
      
      public static const CHAT_WRONG_INPUT:int = 104;
      
      public static const ENABLE_OWL_DISPLAY:int = 105;
      
      public static const TASK_REFRESH:int = 201;
      
      public static const WORLD_MAP_SWITCH:int = 202;
      
      public static const CONDITION_REFRESH:int = 203;
      
      public static const TASK_DONE:int = 204;
      
      public static const UPDATE_AVATAR:int = 205;
      
      public static const SET_SYSUI_STATE:int = 206;
      
      public static const CONTROL_WEATHER_EFFECT:int = 207;
      
      public static const VIP_LEVEL_CHANGE:int = 301;
      
      public static const REFRESH_TALENT:int = 302;
      
      public static const COMBAT_START:int = 303;
      
      public static const ROLE_SET_VISIBLE:int = 304;
      
      public static const SCRIPT_NODE_CLICK:int = 305;
       
      
      public var type:int;
      
      public var data:Object;
      
      public function SysEventDes()
      {
         super();
      }
   }
}
