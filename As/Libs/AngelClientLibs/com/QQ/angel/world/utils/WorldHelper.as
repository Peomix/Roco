package com.QQ.angel.world.utils
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.media.IAudioPlayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.msg.SysMsgDes;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.world.net.protocol.P_FirstGotSpirit;
   import com.QQ.angel.world.vo.ACTIVENPCVo;
   
   public class WorldHelper
   {
      
      private static var __AwardsMemory:AwardMemory;
      
      private static var __inited:Boolean;
       
      
      public function WorldHelper()
      {
         super();
      }
      
      public static function initialize(param1:IAngelSysAPI) : void
      {
         if(__inited)
         {
            return;
         }
         __inited = true;
         __global.initialize(param1);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_SYSTEM_ON_GLOBAL_INITED);
         __global.NPCCDesClsMap["ACTIVE"] = ACTIVENPCVo;
      }
      
      public static function getSpiritsReq(param1:int, param2:Function) : void
      {
         var _loc3_:P_FreeRequest = new P_FreeRequest(720921,new P_FirstGotSpirit(param1),P_FirstGotSpirit,param2);
         _loc3_.send();
      }
      
      public static function addAward(param1:Object) : void
      {
         if(__AwardsMemory == null)
         {
            __AwardsMemory = new AwardMemory();
         }
         if(param1 is String)
         {
            __global.SysAPI.getMSGAPI().chunnelPush(new SysMsgDes(2,param1));
            return;
         }
         __AwardsMemory.addAward(param1);
         displayAward();
      }
      
      public static function displayAward() : void
      {
         if(__global.SysAPI.getIsRender() && __AwardsMemory != null && __AwardsMemory.getBusy() == false)
         {
            __AwardsMemory.displayAwards();
         }
      }
      
      public static function setBGMusic(param1:Boolean) : void
      {
         var _loc2_:IAudioPlayer = __global.SysAPI.getMediaSysAPI().getBGAudio();
         if(!param1)
         {
            _loc2_.play();
         }
         else
         {
            _loc2_.pause();
         }
      }
      
      public static function onWorldCommand(param1:int, param2:Object) : *
      {
         switch(param1)
         {
            case WorldCmdType.PURCHASE_CLICK:
               __global.buySomething(param2 as int);
               break;
            case WorldCmdType.OPEN_WIN:
               __global.openAsWin(null,param2);
               break;
            case WorldCmdType.CHANGESCENE_CLICK:
               __global.changeScene(null,param2);
               break;
            case WorldCmdType.OPEN_NPC_DIALOG:
               __global.openNPCDialog(null,param2);
               break;
            case WorldCmdType.SET_SYSUI_STATE:
               __global.setSysUIState(param2 as int);
               break;
            case WorldCmdType.OPEN_COMBAT:
               __global.openCombat(null,param2.cType,param2.id,param2.name,param2.handler);
               break;
            case WorldCmdType.GOT_SPIRIT:
               getSpiritsReq(param2.id,param2.handler);
               break;
            case WorldCmdType.GOT_BAG_SPIRITS:
               __global.DataAPI.requestBagSpirits(param2 as Function);
               break;
            case WorldCmdType.SET_SYS_MUTE:
               setBGMusic(param2 as Boolean);
               break;
            case WorldCmdType.USE_MAGIC:
               __global.useMagicSkill(param2);
               break;
            case WorldCmdType.SHOW_MSG_BOX:
               __global.showMsgBox(param2);
               break;
            case WorldCmdType.CHECK_HAVE_ITEM:
               __global.DataAPI.checkHaveItem(param2);
               break;
            case WorldCmdType.CHECK_NPC_VAL:
               __global.DataAPI.checkNpcVal(param2.id,param2.handler);
               break;
            case WorldCmdType.UPDATE_NPC_VAL:
               __global.DataAPI.updateNpcVal(param2.id,param2.val,param2.handler);
               break;
            case WorldCmdType.OPEN_GAME:
               __global.openGame(null,param2.type,param2.id,param2.cid,param2.params,param2.name,param2.handler);
               break;
            case WorldCmdType.OPEN_ITEM_PANEL:
               __global.showItemPanel(param2 as Array);
         }
      }
   }
}

import com.QQ.angel.api.events.AngelSysEvent;
import com.QQ.angel.api.utils.CFunction;
import com.QQ.angel.common.__global;
import com.QQ.angel.data.entity.ItemRewardData;
import com.QQ.angel.data.entity.emblems.EmblemsDes;

class AwardMemory
{
    
   
   private var __awards:Array;
   
   private var __busy:Boolean = false;
   
   private var __circleCall:CFunction;
   
   public function AwardMemory()
   {
      this.__awards = [];
      this.__circleCall = new CFunction(this.displayAwards,this);
      super();
   }
   
   public function getBusy() : Boolean
   {
      return this.__busy;
   }
   
   public function addAward(param1:Object) : void
   {
      if(param1 == null)
      {
         return;
      }
      if(param1 is String)
      {
         this.__awards.push(param1);
      }
      else
      {
         if(param1.items != null)
         {
            this.__awards.push(param1.items);
         }
         if(param1.emblemID != 0)
         {
            this.__awards.push(param1.emblemID);
         }
      }
   }
   
   public function displayAwards(... rest) : void
   {
      var _loc3_:EmblemsDes = null;
      var _loc4_:ItemRewardData = null;
      trace("[AwardMemory] ################call  ");
      if(this.__awards.length == 0)
      {
         this.__busy = false;
         return;
      }
      this.__busy = true;
      var _loc2_:Object = this.__awards.shift();
      if(_loc2_ is int)
      {
         _loc3_ = new EmblemsDes();
         _loc3_.animationIndex = _loc2_ as int;
         __global.GEventAPI.cmdExecuted(AngelSysEvent.ON_DISPLAY_EMBLEMS,_loc3_);
         this.displayAwards();
      }
      else if(_loc2_ is Array)
      {
         (_loc4_ = new ItemRewardData()).infoTxt = "物品放入背包!";
         _loc4_.items = _loc2_ as Array;
         __global.UI.showManagedWin(8,_loc4_,this.__circleCall);
      }
      else if(_loc2_ is String)
      {
         __global.showMsgBox(_loc2_ as String,1,this.__circleCall);
      }
      else
      {
         this.displayAwards();
      }
      trace("[AwardMemory] ################" + _loc2_);
   }
}
