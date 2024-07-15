package com.QQ.angel.world.scene.data
{
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.world.IMapModel;
   import com.QQ.angel.data.entity.world.ISceneInsideData;
   import com.QQ.angel.data.entity.world.ISceneModel;
   import com.QQ.angel.data.entity.world.ISceneSpiritModel;
   import flash.events.EventDispatcher;
   
   public class AngelSceneModel extends EventDispatcher implements ISceneModel
   {
       
      
      protected var mapModel:AngelSceneMapModel;
      
      protected var npcdess:Array;
      
      protected var spiritModel:AngelSceneSpiritModel;
      
      protected var des:SceneDes;
      
      protected var dataProxy:AngelSceneDataProxy;
      
      public function AngelSceneModel(param1:SceneDes, param2:AngelSceneDataProxy)
      {
         super();
         this.des = param1;
         this.dataProxy = param2;
      }
      
      protected function processNPCDess(param1:XMLList) : void
      {
         var _loc2_:int = 0;
         this.npcdess = [];
         if(param1 != null && param1.length() > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length())
            {
               this.npcdess.push(new NpcDes(param1[_loc2_]));
               _loc2_++;
            }
         }
      }
      
      public function isNull() : Boolean
      {
         return true;
      }
      
      public function load(param1:AngelSceneContext) : void
      {
         var _loc2_:XML = param1.npcXML != "" ? new XML(param1.npcXML) : null;
         this.mapModel = new AngelSceneMapModel(param1.logic);
         this.processNPCDess(_loc2_ == null ? null : _loc2_.Npc);
         var _loc3_:XML = _loc2_ == null ? null : _loc2_.CreateSpirit[0];
         this.spiritModel = new AngelSceneSpiritModel(_loc3_ == null ? null : _loc3_.Area);
      }
      
      public function unload() : void
      {
         this.dataProxy.clear();
         if(this.mapModel != null)
         {
            this.mapModel.dispose();
            this.mapModel = null;
         }
         this.npcdess = null;
         if(this.spiritModel != null)
         {
            this.spiritModel.removeAll();
            this.spiritModel = null;
         }
      }
      
      public function getMapModel() : IMapModel
      {
         return this.mapModel;
      }
      
      public function getSceneData() : ISceneInsideData
      {
         return this.dataProxy;
      }
      
      public function getSceneSpiritModel() : ISceneSpiritModel
      {
         return this.spiritModel;
      }
      
      public function getXMLNpcDess() : Array
      {
         return this.npcdess;
      }
      
      public function getSceneDes() : SceneDes
      {
         return this.des;
      }
   }
}
