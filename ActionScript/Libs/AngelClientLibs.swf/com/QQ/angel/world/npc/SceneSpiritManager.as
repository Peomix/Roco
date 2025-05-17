package com.QQ.angel.world.npc
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.IGlobalEventAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.net.IDataReceiver;
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.action.TickManager;
   import com.QQ.angel.api.world.scene.ILayer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.SceneCMDDes;
   import com.QQ.angel.data.entity.combatsys.CombatType;
   import com.QQ.angel.data.entity.combatsys.OpenCombatDes;
   import com.QQ.angel.data.entity.world.ISceneModel;
   import com.QQ.angel.data.entity.world.ISceneSpiritModel;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.net.processor.RefreshSpiritsP;
   import com.QQ.angel.world.npc.chip.RandomMoveAIChip;
   import com.QQ.angel.world.npc.chip.ThinkAloudAIChip;
   import com.QQ.angel.world.npc.spirit.SimpleSpiritLogic;
   import com.QQ.angel.world.npc.spirit.SimpleSpiritView;
   import com.QQ.angel.world.scene.ChallengeTowerEvent;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   import com.QQ.angel.world.scene.ISceneManager;
   import com.QQ.angel.world.scene.events.AngelSceneModelEvent;
   import com.QQ.angel.world.vo.RefreshSpiritList;
   import com.QQ.angel.world.vo.RefreshSpiritVo;
   import com.QQ.angel.world.vo.SpiritData;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   
   public class SceneSpiritManager extends TickManager implements IDataReceiver, IAngelSysAPIAware
   {
      
      protected var sys:IAngelSysAPI;
      
      protected var gEventer:IGlobalEventAPI;
      
      protected var npcListener:INPCListener;
      
      protected var spiritResAdapter:IResAdapter;
      
      protected var netSys:INetSysAPI;
      
      protected var sManager:ISceneManager;
      
      protected var spiritDesProxy:IDataProxy;
      
      protected var currSpiritModel:ISceneSpiritModel;
      
      protected var currSceneID:int;
      
      protected var hasUpdate:Boolean = false;
      
      protected var serverSpirits:Array;
      
      protected var sPools:Array;
      
      protected var logic:IAngelSceneLogic;
      
      protected var layer:ILayer;
      
      protected var isActived:Boolean = false;
      
      protected var lastReflashTime:int;
      
      protected var reflashDTime:int;
      
      protected var spiritID:int = 0;
      
      protected var isRender:Boolean = true;
      
      protected var sceneClear:Boolean = false;
      
      protected var spiritRect_conf:XML;
      
      public function SceneSpiritManager()
      {
         super();
      }
      
      protected function fireChallengeEvent(param1:String) : void
      {
         var _loc2_:SceneCMDDes = new SceneCMDDes();
         _loc2_.cmd = SceneCMDDes.CHALLENGE_CMD;
         _loc2_.params = param1;
         this.gEventer.cmdExecuted(AngelSysEvent.ON_SCENECMD_CALL,_loc2_);
      }
      
      protected function onSceneSpiritUpdate(param1:AngelSceneModelEvent) : void
      {
         this.hasUpdate = true;
         this.reflashSpiritNow();
      }
      
      protected function reflashSpiritNow() : void
      {
         var _loc4_:RefreshSpiritVo = null;
         if(!this.hasUpdate)
         {
            return;
         }
         this.hasUpdate = false;
         var _loc1_:Array = this.currSpiritModel.getSceneSpirits();
         var _loc2_:Array = this.serverSpirits;
         if(_loc2_ != null)
         {
            if(_loc1_ != null)
            {
               _loc2_ = this.serverSpirits.concat(_loc1_);
            }
         }
         else if(_loc1_)
         {
            _loc2_ = _loc1_.concat();
         }
         else
         {
            _loc2_ = [];
         }
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.length == 0)
         {
            this.removeAllSpirit();
            if(this.isRender)
            {
               this.fireChallengeEvent(ChallengeTowerEvent.SCENE_CLEAR);
            }
            else
            {
               this.sceneClear = true;
            }
            return;
         }
         this.filterSpirits(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_.visible)
            {
               if(_loc4_.isNPCBoss)
               {
                  this.fireChallengeEvent(ChallengeTowerEvent.BOSS_INIT);
               }
               else
               {
                  this.createASpirits(_loc4_);
               }
            }
            _loc3_++;
         }
      }
      
      protected function buildSpirit() : SimpleSpiritLogic
      {
         var _loc1_:SimpleSpiritLogic = new SimpleSpiritLogic();
         _loc1_.attachView(new SimpleSpiritView(this.spiritResAdapter));
         return _loc1_;
      }
      
      protected function borrowSpirit() : SimpleSpiritLogic
      {
         if(this.sPools.length == 0)
         {
            return null;
         }
         return this.sPools.pop() as SimpleSpiritLogic;
      }
      
      protected function createASpirits(param1:RefreshSpiritVo) : void
      {
         var aIndex:int = 0;
         var area:Rectangle = null;
         var spirit:SimpleSpiritLogic = null;
         var svo:SpiritData = null;
         var list:XMLList = null;
         var vo:RefreshSpiritVo = param1;
         var areas:Array = this.currSpiritModel.getAreas();
         var i:int = 0;
         while(i < vo.num)
         {
            ++this.spiritID;
            aIndex = vo.areaIndex;
            if(aIndex > 0)
            {
               aIndex--;
            }
            else
            {
               aIndex = int(areas.length * Math.random());
            }
            area = areas[aIndex];
            spirit = this.borrowSpirit();
            if(spirit == null)
            {
               spirit = this.buildSpirit();
            }
            svo = vo.createData(this.spiritID,area);
            spirit.setData(svo);
            spirit.addClickListener(this);
            if(vo.sceneKey != null && !vo.sceneKey.isMotion)
            {
               spirit.setDirection(vo.sceneKey.direction);
            }
            else
            {
               spirit.insertChip(new RandomMoveAIChip(area));
            }
            if(vo.sceneKey != null && vo.sceneKey.clickListener == null)
            {
               spirit.getView().buttonMode = false;
               spirit.getView().useHandCursor = false;
            }
            if(svo.words != null && svo.words.length != 0)
            {
               spirit.insertChip(new ThinkAloudAIChip(svo.words));
            }
            spirit.insertEffect(vo.isRare);
            if(this.spiritRect_conf && this.spiritRect_conf.spirit && Boolean(spirit.getData()))
            {
               list = this.spiritRect_conf.spirit.(@id == spirit.getData().typeID && @scene == currSceneID);
               if(Boolean(list) && list.length() > 0)
               {
                  spirit.tips = "" + list[0].@lv + " " + list[0].@name;
               }
            }
            spirit.initialize();
            this.layer.addElement(spirit);
            addTick(spirit);
            i++;
         }
      }
      
      protected function removeAllSpirit() : void
      {
         var _loc1_:SimpleSpiritLogic = null;
         var _loc2_:int = int(ticksList.length - 1);
         while(_loc2_ >= 0)
         {
            _loc1_ = ticksList[_loc2_] as SimpleSpiritLogic;
            this.layer.removeElement(_loc1_);
            _loc1_.reset();
            this.sPools.push(_loc1_);
            _loc2_--;
         }
         ticksList = [];
      }
      
      protected function filterSpirits(param1:Array) : void
      {
         var _loc2_:SimpleSpiritLogic = null;
         var _loc4_:SpiritData = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:RefreshSpiritVo = null;
         var _loc10_:uint = 0;
         if(param1 == null)
         {
            return;
         }
         var _loc3_:int = int(ticksList.length - 1);
         while(_loc3_ >= 0)
         {
            _loc2_ = ticksList[_loc3_] as SimpleSpiritLogic;
            _loc4_ = _loc2_.getData() as SpiritData;
            _loc5_ = _loc4_.typeID;
            _loc6_ = _loc4_.sceneKey == null ? 0 : _loc4_.sceneKey.caughtTime;
            _loc7_ = false;
            _loc8_ = 0;
            while(_loc8_ < param1.length)
            {
               _loc9_ = param1[_loc8_];
               _loc10_ = _loc9_.sceneKey == null ? 0 : _loc9_.sceneKey.caughtTime;
               if(_loc9_.id == _loc5_ && _loc6_ == _loc10_ && _loc9_.visible)
               {
                  --_loc9_.num;
                  if(_loc9_.num == 0)
                  {
                     param1.splice(_loc8_,1);
                  }
                  _loc7_ = true;
                  break;
               }
               _loc8_++;
            }
            if(!_loc7_)
            {
               this.layer.removeElement(_loc2_);
               _loc2_.reset();
               ticksList.splice(_loc3_,1);
               this.sPools.push(_loc2_);
            }
            _loc3_--;
         }
      }
      
      public function initialize() : void
      {
         this.gEventer = this.sys.getGEventAPI();
         this.spiritResAdapter = this.sys.getResSysAPI().getResAdapter(Constants.SCENE_RES);
         this.netSys = this.sys.getNetSysAPI();
         this.spiritDesProxy = this.sys.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
         this.sManager = this.sys.getWorldAPI().getSceneAPI() as ISceneManager;
         this.netSys.addDataProcessor(new RefreshSpiritsP(this.spiritDesProxy));
         this.netSys.addDataReceiver(this);
         this.sPools = [];
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_ON_GLOBAL_INITED,this.onGlobalInit);
      }
      
      private function onGlobalInit(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc6_:Object = null;
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_ON_GLOBAL_INITED,this.onGlobalInit);
         var _loc5_:Object = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CONFS);
         if(_loc5_)
         {
            _loc6_ = _loc5_["spiritRect_conf"];
            if(_loc6_)
            {
               this.spiritRect_conf = _loc6_ is XML ? _loc6_ as XML : new XML(_loc6_);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function setRender(param1:Boolean) : void
      {
         this.isRender = param1;
         if(this.isRender && this.sceneClear)
         {
            this.fireChallengeEvent(ChallengeTowerEvent.SCENE_CLEAR);
            this.sceneClear = false;
         }
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.sys = param1;
      }
      
      public function setNpcListener(param1:INPCListener) : void
      {
         this.npcListener = param1;
      }
      
      public function onItemClick(param1:SimpleSpiritLogic) : void
      {
         var _loc3_:OpenCombatDes = null;
         var _loc4_:Function = null;
         var _loc2_:SpiritData = param1.getData() as SpiritData;
         if(_loc2_.sceneKey == null)
         {
            _loc3_ = new OpenCombatDes();
            _loc3_.combatType = CombatType.PVE;
            _loc3_.distance = 60;
            _loc3_.opponentID = param1.getTypeID();
            _loc3_.oppoentName = (param1.getData() as SpiritData).spiritDes.name;
            _loc3_.distance = 60;
            _loc3_.aimPos = param1.getPosition();
            _loc3_.event = AngelSysEvent.ON_OPEN_COMBAT;
            __global.executeClick(_loc3_);
         }
         else
         {
            _loc4_ = _loc2_.sceneKey.clickListener;
            if(_loc4_ != null)
            {
               __global.heroClosedExec(param1.getPosition(),60,new CFunction(_loc4_,null,[_loc2_.sceneKey]));
            }
         }
      }
      
      public function isFrequency(param1:int) : Boolean
      {
         return this.npcListener.isFrequency(param1);
      }
      
      override public function onTickEvent(param1:Event) : void
      {
         if(!this.isRender)
         {
            return;
         }
         super.onTickEvent(param1);
         var _loc2_:int = getTimer();
         if(_loc2_ - this.lastReflashTime >= this.reflashDTime)
         {
            if(this.hasUpdate)
            {
               this.reflashSpiritNow();
               this.lastReflashTime = _loc2_;
            }
         }
      }
      
      public function active() : void
      {
         var _loc1_:ISceneModel = this.sManager.getSceneModel() as ISceneModel;
         this.currSpiritModel = _loc1_.getSceneSpiritModel();
         if(this.currSpiritModel == null || this.currSpiritModel.getAreas().length == 0)
         {
            return;
         }
         this.currSceneID = this.sManager.getCurrentScene().sceneID;
         this.logic = this.sManager.getSceneLogic() as IAngelSceneLogic;
         this.layer = this.logic.getSpaceLayer();
         this.isActived = true;
         this.spiritID = 0;
         this.reflashDTime = 120000;
         this.lastReflashTime = getTimer() - (this.reflashDTime - 2000);
         this.currSpiritModel.addEventListener(AngelSceneModelEvent.UPDATE_DATA,this.onSceneSpiritUpdate);
         this.gEventer.addTickListener(this);
         this.isActived = true;
      }
      
      public function deactivate() : void
      {
         this.serverSpirits = null;
         if(this.isActived == false)
         {
            return;
         }
         this.gEventer.removeTickListener(this);
         if(this.currSpiritModel)
         {
            this.currSpiritModel.removeEventListener(AngelSceneModelEvent.UPDATE_DATA,this.onSceneSpiritUpdate);
            this.currSpiritModel = null;
         }
         this.isActived = false;
         this.sceneClear = false;
         this.currSceneID = 0;
         this.lastReflashTime = 0;
         this.removeAllSpirit();
         this.logic = null;
         this.layer = null;
      }
      
      public function onDataReceive(param1:int, param2:Object) : void
      {
         var _loc3_:RefreshSpiritList = param2 as RefreshSpiritList;
         if(_loc3_.sceneID != this.currSceneID && this.currSceneID != 0)
         {
            trace("[SceneSpiritManager]场景不吻合",this.currSceneID,_loc3_.sceneID);
            return;
         }
         if(this.lastReflashTime != 0)
         {
            this.lastReflashTime = getTimer() - this.reflashDTime;
         }
         this.hasUpdate = true;
         this.serverSpirits = _loc3_.arr;
      }
      
      public function sendDataToServer(param1:int, param2:Object) : void
      {
      }
      
      public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_SPIRIT_REFLASH];
      }
   }
}

