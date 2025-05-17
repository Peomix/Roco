package com.QQ.angel.ui.effect
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.IUISysAPI;
   import com.QQ.angel.api.ui.IEffectManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   
   public class AngelEffectManager implements IEffectManager
   {
      
      protected var uiSys:IUISysAPI;
      
      protected var effects:Array;
      
      protected var effectsCls:Array;
      
      private var curCec:ChallengeTowerGlobalEffect = null;
      
      public function AngelEffectManager(param1:IUISysAPI)
      {
         super();
         this.uiSys = param1;
         this.effects = [];
         this.effectsCls = [Effect1Controller,Effect2Controller,Effect3Controller,Effect4Controller,Effect5Controller,ChallengeTowerGlobalEffect,ItemIndicationEffect,GetSpiritAllotExpGlobalEffect7];
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_COMBAT_ON_A_COMBAT_END,this.onCombatEnd,this);
      }
      
      private function onCombatEnd(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         if(this.curCec != null && this.curCec.parent != null)
         {
            this.uiSys.getEffectContainer(1).addChild(this.curCec);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function playEffect(param1:int, param2:Object, param3:CFunction = null) : void
      {
         var _loc5_:Class = null;
         var _loc6_:String = null;
         var _loc4_:IEffectController = this.effects[param1];
         if(_loc4_ == null)
         {
            _loc5_ = this.effectsCls[param1];
            if(_loc5_ == null)
            {
               trace("[AngelEffectManager] 目前不支持此Type的效果!!");
               return;
            }
            _loc4_ = new _loc5_(this.uiSys.getEffectContainer(1)) as IEffectController;
            this.effects[param1] = _loc4_;
         }
         if(param1 == 5)
         {
            _loc6_ = param2 as String;
            this.curCec = _loc4_ as ChallengeTowerGlobalEffect;
            if(this.curCec && _loc6_ && (_loc6_.indexOf("changeScene") != -1 || _loc6_.indexOf("KingChampionship") != -1) && __global.MainRoleData.isInBombat)
            {
               this.curCec.container = this.uiSys.getWorldContainer();
               this.curCec.setDuration(7000);
            }
            else
            {
               this.curCec.container = this.uiSys.getEffectContainer(1);
               this.curCec.setDuration(ChallengeTowerGlobalEffect.LAST_MILISECONDS);
            }
         }
         _loc4_.start(param2,param3);
      }
   }
}

