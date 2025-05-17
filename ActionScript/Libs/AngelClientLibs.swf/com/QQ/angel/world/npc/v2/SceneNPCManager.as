package com.QQ.angel.world.npc.v2
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.world.INPCSysAPI;
   import com.QQ.angel.api.world.npc.INPC;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.world.INpcModel;
   import com.QQ.angel.data.entity.world.ISceneModel;
   import com.QQ.angel.data.entity.world.events.NpcModelEvent;
   import com.QQ.angel.world.npc.INPCElement;
   import com.QQ.angel.world.npc.INPCListener;
   import com.QQ.angel.world.scene.IAngelSceneLogic;
   import com.QQ.angel.world.scene.ISceneManager;
   import flash.display.DisplayObject;
   
   public class SceneNPCManager implements IAngelSysAPIAware
   {
      
      protected var npcs:Array;
      
      protected var sLogic:IAngelSceneLogic;
      
      protected var npcModel:AngelNPCModel;
      
      protected var sys:IAngelSysAPI;
      
      protected var npcSys:INPCSysAPI;
      
      protected var listener:INPCListener;
      
      protected var sManager:ISceneManager;
      
      protected var vController:VisibleController;
      
      public function SceneNPCManager()
      {
         super();
      }
      
      protected function createNpc(param1:NpcDataProxy) : INPCElement
      {
         var _loc4_:DisplayObject = null;
         var _loc2_:NpcDes = param1.getNpcDes();
         var _loc3_:Class = this.npcSys.getNPCCls(_loc2_.type);
         if(_loc3_ == null)
         {
            return null;
         }
         if(_loc2_.npcViewDes == null)
         {
            _loc4_ = this.sLogic.getObjectByName(_loc2_.id);
            if(_loc4_ == null)
            {
               return null;
            }
         }
         var _loc5_:INPCElement = new _loc3_() as INPCElement;
         _loc5_.setData(param1);
         if(_loc2_.npcViewDes != null)
         {
            _loc5_.setAtLayer(this.sLogic.getLayerByID(_loc2_.npcViewDes.atLayerID));
            _loc3_ = this.npcSys.getNPCViewCls(_loc2_.npcViewDes.type);
            _loc5_.attachView(new _loc3_());
         }
         else
         {
            _loc5_.attachView(_loc4_);
            switch(_loc2_.world)
            {
               case 0:
                  break;
               case 1:
                  if(__global.isInNewWorld())
                  {
                     _loc4_.visible = false;
                  }
                  break;
               case 2:
                  if(!__global.isInNewWorld())
                  {
                     _loc4_.visible = false;
                  }
            }
         }
         _loc5_.npclistener = this.listener;
         _loc5_.initialize();
         return _loc5_;
      }
      
      protected function filterNpcs(param1:Array) : void
      {
         var _loc3_:INPCElement = null;
         var _loc4_:NpcDataProxy = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         var _loc7_:NpcDes = null;
         if(param1 == null || this.npcs == null)
         {
            return;
         }
         var _loc2_:int = int(this.npcs.length - 1);
         while(_loc2_ >= 0)
         {
            _loc3_ = this.npcs[_loc2_] as INPCElement;
            _loc4_ = _loc3_.getData() as NpcDataProxy;
            _loc5_ = false;
            _loc6_ = 0;
            while(_loc6_ < param1.length)
            {
               _loc7_ = param1[_loc6_];
               if(_loc4_.isNpcDes(_loc7_))
               {
                  param1.splice(_loc6_,1);
                  _loc5_ = true;
                  break;
               }
               _loc6_++;
            }
            if(!_loc5_)
            {
               _loc3_.finalize();
            }
            _loc2_--;
         }
      }
      
      protected function onNpcUpdate(param1:NpcModelEvent) : void
      {
         var _loc4_:NpcDataProxy = null;
         var _loc5_:INPCElement = null;
         var _loc2_:Array = this.npcModel.getCurrNpcProxys();
         if(_loc2_ == null)
         {
            return;
         }
         this.filterNpcs(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = _loc2_[_loc3_];
            if(_loc4_ != null)
            {
               _loc5_ = this.createNpc(_loc4_);
               if(_loc5_ != null)
               {
                  this.npcs.push(_loc5_);
               }
            }
            _loc3_++;
         }
      }
      
      protected function onAddNpc(param1:NpcModelEvent) : void
      {
         var _loc2_:NpcDataProxy = param1.data as NpcDataProxy;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:INPCElement = this.createNpc(_loc2_);
         if(_loc3_ != null)
         {
            this.npcs.push(_loc3_);
         }
      }
      
      protected function onRemoveNpc(param1:NpcModelEvent) : void
      {
         var _loc4_:INPCElement = null;
         var _loc5_:NpcDataProxy = null;
         var _loc2_:NpcDataProxy = param1.data as NpcDataProxy;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = int(this.npcs.length - 1);
         while(_loc3_ >= 0)
         {
            _loc4_ = this.npcs[_loc3_] as INPCElement;
            _loc5_ = _loc4_.getData() as NpcDataProxy;
            if(_loc2_ == _loc5_)
            {
               this.npcs.splice(_loc3_,1);
               _loc4_.finalize();
               return;
            }
            _loc3_--;
         }
      }
      
      public function initialize() : void
      {
         this.npcSys = this.sys.getWorldAPI().getNPCSysAPI();
         this.sManager = this.sys.getWorldAPI().getSceneAPI() as ISceneManager;
         this.vController = new VisibleController(this.sys);
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.sys = param1;
      }
      
      public function setNpcListener(param1:INPCListener) : void
      {
         this.listener = param1;
      }
      
      public function active() : void
      {
         this.npcs = [];
         var _loc1_:ISceneModel = this.sManager.getSceneModel() as ISceneModel;
         this.sLogic = this.sManager.getSceneLogic() as IAngelSceneLogic;
         var _loc2_:Array = _loc1_.getXMLNpcDess();
         this.npcModel = new AngelNPCModel(_loc2_);
         this.vController.watch(this.npcModel);
         this.onNpcUpdate(null);
         this.npcModel.addEventListener(NpcModelEvent.ON_MODEL_UPDATE,this.onNpcUpdate);
         this.npcModel.addEventListener(NpcModelEvent.ON_ADD_NPC,this.onAddNpc);
         this.npcModel.addEventListener(NpcModelEvent.ON_REMOVE_NPC,this.onRemoveNpc);
      }
      
      public function deactivate() : void
      {
         var _loc2_:INPCElement = null;
         if(this.npcModel != null)
         {
            this.npcModel.removeEventListener(NpcModelEvent.ON_MODEL_UPDATE,this.onNpcUpdate);
            this.npcModel.removeEventListener(NpcModelEvent.ON_ADD_NPC,this.onAddNpc);
            this.npcModel.removeEventListener(NpcModelEvent.ON_REMOVE_NPC,this.onRemoveNpc);
            this.npcModel = null;
         }
         this.vController.unwatch();
         if(this.npcs == null)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.npcs.length)
         {
            _loc2_ = this.npcs[_loc1_];
            _loc2_.finalize();
            _loc1_++;
         }
         this.npcs = null;
      }
      
      public function getNPCByName(param1:String) : INPC
      {
         return null;
      }
      
      public function getNPCList() : Array
      {
         return this.npcs;
      }
      
      public function getNPCModel() : INpcModel
      {
         return this.npcModel;
      }
   }
}

