package com.QQ.angel.world.panel
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.OpenGameDes;
   
   public class OpenGameHandler implements ICmdListener
   {
       
      
      public function OpenGameHandler(param1:IAngelSysAPI)
      {
         super();
         param1.getGEventAPI().addCmdListener("onOpenGame",this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_GAME_BY_ID,OpenGameHandler.onApplyOpenGame);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_GAME_BY_DES,OpenGameHandler.onApplyOpenGame);
      }
      
      public static function onApplyOpenGame(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:Array = null;
         var _loc6_:OpenGameDes = null;
         if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_GAME_BY_DES)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,[AngelSysEvent.ON_OPEN_GAME,param2 as OpenGameDes]);
         }
         else if(param1 == CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_GAME_BY_ID)
         {
            _loc5_ = param2 as Array;
            (_loc6_ = new OpenGameDes()).gameID = _loc5_[0];
            _loc6_.gameType = _loc5_[1];
            if(_loc6_.gameType == 0)
            {
               _loc6_.gameType = 2;
            }
            _loc6_.dialogTxt = _loc5_[2] as String;
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_OPEN_GAME_BY_DES,_loc6_);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function call(param1:Object) : *
      {
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_SYNC,[AngelSysEvent.ON_OPEN_GAME,param1]);
         return null;
      }
   }
}
