package com.QQ.angel.api.events
{
   public class AngelSysEvent extends BaseEvent
   {
      
      public static const ON_SYS_EVENT:String = "onSystemEvent";
      
      public static const LOGIN_OK:String = "loginOk";
      
      public static const ON_SCENE_BUILT:String = "onSceneBuilt";
      
      public static const ON_SCENE_DESTROY:String = "onSceneDestroy";
      
      public static const ON_SCENEDATA_INIT:String = "onSceneDataInit";
      
      public static const ON_CHANGE_SCENE:String = "onChangeScene";
      
      public static const ON_SCENECMD_CALL:String = "onSceneCMDCall";
      
      public static const ON_OPEN_WORLDMAP:String = "onWorldMap";
      
      public static const ON_OPEN_GAME:String = "onExternalGame";
      
      public static const ON_USER_INFO:String = "onUserInfo";
      
      public static const ON_SPIRIT_BAG:String = "onSpiritBag";
      
      public static const ON_PURCHASE:String = "onPurchase";
      
      public static const ON_TASK_CALL:String = "onTaskV5";
      
      public static const ON_OWL_CALL:String = "onOwl";
      
      public static const ON_MAGIC_CALL:String = "onMagic";
      
      public static const ON_OPEN_ASWIN:String = "onOpenAsWin";
      
      public static const ON_OPEN_COMBAT:String = "onCombat";
      
      public static const ON_OPEN_MULTI_COMBAT:String = "onMultiCombat";
      
      public static const ON_RUN_SCRIPT:String = "onRunScript";
      
      public static const ON_DISPLAY_EMBLEMS:String = "onEmblemsBoard";
      
      public static const ON_TIMES_PAPER:String = "onTimesPaper";
      
      public static const ON_BOSS_PANEL:String = "onBossPanel";
      
      public static const ON_LOGIN_HOMESTEAD:String = "onHome";
      
      public static const ON_INVITE_FRIEND:String = "onInviteFriend";
      
      public static const ON_RIDDLEIS_LAND:String = "onRiddleIsland";
      
      public static const ON_CHRISTMAS_TREE:String = "onChristmasTree";
      
      public static const CMDLIS_NOT_FOUND:String = "cmdListenerNotFound";
      
      public static const ON_LOGIN_MANOR:String = "onManor";
      
      public static const ON_MOVIE_AD_TEMP:String = "onMovieAdTemp";
      
      public static const ON_ACHIEVE_PANEL:String = "onAchievePanel";
      
      public static const ON_GUARDIANPET:String = "onGuardianPet";
       
      
      public function AngelSysEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
