package com.QQ.angel.world.scene.data
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.SceneDes;
   import com.QQ.angel.data.entity.world.ISceneInsideData;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.world.net.protocol.P_LoadSceneData;
   import com.QQ.angel.world.net.protocol.P_UpdateSceneData;
   import com.QQ.angel.world.scene.ISceneData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class AngelSceneDataProxy extends EventDispatcher implements ISceneData, ISceneInsideData
   {
      
      protected var values:SceneValues;
      
      protected var sceneID:int;
      
      protected var sceneDes:SceneDes;
      
      protected var scene_cache:Dictionary;
      
      protected var scene_values:Dictionary;
      
      protected var localData:IDataProxy;
      
      public function AngelSceneDataProxy(param1:IDataProxy)
      {
         super();
         this.localData = param1;
         this.scene_values = new Dictionary();
      }
      
      protected function onDataLoaded(param1:P_LoadSceneData) : void
      {
         if(param1 != null)
         {
            if(param1.code.isError() == false)
            {
               this.values.remoteValues = param1.values;
               if(this.values.remoteValues[0] != this.sceneDes.sceneVersion)
               {
                  trace("[SceneDataProxy] 远程数据的版本号与当前版本号不想符!!");
                  this.values.remoteValues = new ByteArray();
                  this.values.remoteValues[0] = this.sceneDes.sceneVersion;
               }
            }
            else
            {
               trace("[SceneDataProxy] 场景数据拉取失败:" + param1.code.message);
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_SCENE_DATA_LOADED);
      }
      
      protected function onDataUpdated(param1:P_UpdateSceneData) : void
      {
         if(param1.code.isError())
         {
            trace("[SceneDataProxy] 场景数据更新失败:" + param1.code.message);
         }
         else if(this.sceneID == param1.sceneID && this.values != null)
         {
            trace("[SceneDataProxy] 场景数据更新成功:" + param1.values);
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_SCENE_DATA_UPDATED);
      }
      
      public function clear() : void
      {
         if(this.values != null)
         {
            this.values.reload();
         }
         this.values = null;
         this.sceneID = 0;
      }
      
      public function load(param1:SceneDes) : void
      {
         var _loc2_:P_FreeRequest = null;
         if(this.sceneID == param1.sceneID)
         {
            return;
         }
         this.sceneDes = param1;
         this.sceneID = param1.sceneID;
         this.values = this.scene_values[this.sceneID];
         if(this.values == null)
         {
            this.scene_values[this.sceneID] = this.values = new SceneValues();
         }
         if(param1.allowData)
         {
            if(this.values.remoteValues != null)
            {
               this.onDataLoaded(null);
               return;
            }
            _loc2_ = new P_FreeRequest(ADFCmdsType.T_LOAD_SCENEDATA,new P_LoadSceneData(this.sceneID),P_LoadSceneData,this.onDataLoaded);
            _loc2_.send();
         }
         else
         {
            this.onDataLoaded(null);
         }
      }
      
      public function getRemoteValue(param1:int) : int
      {
         if(this.values == null)
         {
            return 0;
         }
         return this.values.getRemoteValue(param1);
      }
      
      public function updateRemoteValue(param1:int, param2:int) : void
      {
         if(this.values == null || this.values.remoteValues == null)
         {
            trace("[SceneDataProxy] 此场景不支持数据远程存储!");
            return;
         }
         if(param1 == 0)
         {
            throw new AngelError("[SceneDataProxy.updateRemoteValue] 造出KEY的取值范围是1-19",this);
         }
         this.values.remoteValues[param1] = param2;
         var _loc3_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_UPDATE_SCENEDATA,new RemoteBytes(this.sceneID,this.values.remoteValues),P_UpdateSceneData,this.onDataUpdated);
         _loc3_.send();
      }
      
      public function getDailyValue(param1:int, param2:Boolean = false) : int
      {
         var _loc5_:Date = null;
         var _loc3_:Object = this.getLocalValue(param1,param2);
         if(_loc3_ == null)
         {
            return 0;
         }
         var _loc4_:Date = _loc3_.time as Date;
         if(_loc4_ != null)
         {
            _loc5_ = new Date();
            if(_loc5_.fullYear == _loc4_.fullYear && _loc5_.month == _loc4_.month && _loc5_.date == _loc4_.date)
            {
               return _loc3_.value;
            }
         }
         return 0;
      }
      
      public function setDailyValue(param1:int, param2:int, param3:Boolean = false) : void
      {
         var _loc4_:Object = {
            "time":new Date(),
            "value":param2
         };
         this.setLocalValue(param1,_loc4_,param3);
      }
      
      public function setLocalValue(param1:int, param2:Object, param3:Boolean = false) : void
      {
         var _loc4_:String = "s_" + (param3 ? "" : this.sceneID) + "_" + param1;
         this.localData.insert(_loc4_,param2);
      }
      
      public function getLocalValue(param1:int, param2:Boolean = false) : Object
      {
         var _loc3_:String = "s_" + (param2 ? "" : this.sceneID) + "_" + param1;
         return this.localData.select(_loc3_);
      }
      
      public function getGlobalCache(param1:String) : Object
      {
         if(this.scene_cache == null)
         {
            return null;
         }
         return this.scene_cache[param1];
      }
      
      public function setGlobalCache(param1:String, param2:Object) : void
      {
         if(this.scene_cache == null)
         {
            this.scene_cache = new Dictionary();
         }
         this.scene_cache[param1] = param2;
      }
      
      public function setSceneCache(param1:String, param2:Object) : void
      {
         if(this.values == null)
         {
            return;
         }
         this.values.cache[param1] = param2;
      }
      
      public function getSceneCache(param1:String) : Object
      {
         if(this.values == null)
         {
            return null;
         }
         return this.values.cache[param1];
      }
      
      public function getSceneDes() : SceneDes
      {
         return this.sceneDes;
      }
      
      public function getRemoteValues() : ByteArray
      {
         if(this.values == null)
         {
            return null;
         }
         return this.values.remoteValues;
      }
   }
}

import com.QQ.angel.api.net.protocol.IAngelDataOutput;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.IDataOutput;

class RemoteBytes implements IAngelDataOutput
{
   
   public var bytes:ByteArray;
   
   public var scendID:int;
   
   public function RemoteBytes(param1:int, param2:ByteArray = null)
   {
      super();
      this.scendID = param1;
      this.bytes = param2;
      if(this.bytes != null)
      {
         this.bytes.position = 0;
      }
   }
   
   public function write(param1:IDataOutput) : void
   {
      param1.writeShort(this.scendID);
      param1.writeShort(this.bytes == null ? 0 : int(this.bytes.length));
      if(this.bytes != null)
      {
         param1.writeBytes(this.bytes);
      }
   }
   
   public function get length() : uint
   {
      if(this.bytes == null)
      {
         return 4;
      }
      return this.bytes.length + 4;
   }
}

class SceneValues
{
   
   public var remoteValues:ByteArray;
   
   public var cache:Dictionary;
   
   public function SceneValues()
   {
      super();
      this.reload();
   }
   
   public function reload() : void
   {
      this.cache = new Dictionary();
   }
   
   public function getRemoteValue(param1:int) : int
   {
      if(this.remoteValues == null)
      {
         return 0;
      }
      return this.remoteValues[param1];
   }
}
