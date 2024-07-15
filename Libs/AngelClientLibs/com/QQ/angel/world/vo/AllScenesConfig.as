package com.QQ.angel.world.vo
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.*;
   import com.QQ.angel.utils.ConfigLoader;
   import flash.utils.Dictionary;
   
   public class AllScenesConfig extends ConfigLoader implements IDataProxy
   {
       
      
      protected var scenesDict:Dictionary;
      
      public function AllScenesConfig(param1:Object = null)
      {
         this.scenesDict = new Dictionary();
         super(param1);
      }
      
      override public function analyse(param1:Object) : Boolean
      {
         var _loc5_:XML = null;
         var _loc6_:SceneDes = null;
         var _loc7_:String = null;
         var _loc8_:Array = null;
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc3_:XMLList = _loc2_.SceneDes;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc5_ = _loc3_[_loc4_];
            (_loc6_ = new SceneDes()).sceneID = _loc5_.@id;
            _loc6_.ver = _loc5_.@sceneVer;
            _loc6_.topID = int(_loc5_.@top);
            _loc6_.sceneName = _loc5_.@name;
            _loc7_ = _loc5_.@ver;
            _loc6_.sceneVersion = uint(_loc7_);
            _loc6_.sceneSrc = DEFINE.SCENE_RES_ROOT + _loc6_.sceneID + (_loc6_.ver == 1 ? "" : "." + _loc6_.ver) + "/scene.swf?" + _loc7_;
            _loc6_.npcConf = DEFINE.SCENE_RES_ROOT + _loc6_.sceneID + (_loc6_.ver == 1 ? "" : "." + _loc6_.ver) + "/npc.xml?" + _loc7_;
            _loc6_.description = _loc5_.toString();
            if(_loc5_.@bgMusic != undefined)
            {
               _loc6_.bgMusic = [];
               if((_loc8_ = String(_loc5_.@bgMusic).split("|"))[0] != null && _loc8_[0] != undefined && _loc8_[0] != "")
               {
                  if((_loc8_[0] as String).indexOf(".swf") != -1)
                  {
                     _loc6_.bgMusic[0] = DEFINE.COMM_ROOT + "res/music/" + _loc8_[0];
                  }
               }
               if(_loc8_[1] != null && _loc8_[1] != undefined && _loc8_[1] != "")
               {
                  if((_loc8_[1] as String).indexOf(".swf") != -1)
                  {
                     _loc6_.bgMusic[1] = DEFINE.COMM_ROOT + "res/music/" + _loc8_[1];
                  }
               }
            }
            _loc6_.allowData = String(_loc5_.@allowData) == "true";
            if(this.scenesDict[_loc6_.sceneID] == null)
            {
               this.scenesDict[_loc6_.sceneID] = {};
            }
            this.scenesDict[_loc6_.sceneID][_loc6_.ver] = _loc6_;
            _loc4_++;
         }
         ready = true;
         return true;
      }
      
      public function getScenesDesByID(param1:int, param2:int = 1) : SceneDes
      {
         if(this.scenesDict[param1] == null)
         {
            return null;
         }
         return this.scenesDict[param1][param2];
      }
      
      public function getScenesWithoutVer(param1:int) : Object
      {
         return this.scenesDict[param1];
      }
      
      public function getScenesWithLastestVer(param1:int) : SceneDes
      {
         var _loc3_:SceneDes = null;
         var _loc4_:SceneDes = null;
         var _loc2_:Object = this.scenesDict[param1];
         if(_loc2_)
         {
            for each(_loc4_ in _loc2_)
            {
               if(_loc3_ && _loc4_.ver > _loc3_.ver || !_loc3_)
               {
                  _loc3_ = _loc4_;
               }
            }
            return _loc3_;
         }
         return null;
      }
      
      public function getScenesList() : Array
      {
         var _loc2_:Object = null;
         var _loc3_:SceneDes = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.scenesDict)
         {
            for each(_loc3_ in _loc2_)
            {
               _loc1_.push(_loc3_);
            }
         }
         return _loc1_;
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
      }
      
      public function select(... rest) : Object
      {
         return this.getScenesDesByID(rest[0]);
      }
      
      public function getName() : String
      {
         return Constants.SCENE_DATA;
      }
   }
}
