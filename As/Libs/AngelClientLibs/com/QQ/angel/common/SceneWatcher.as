package com.QQ.angel.common
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.world.scene.ISceneLogic;
   import com.QQ.angel.data.entity.SceneDes;
   import flash.events.IEventDispatcher;
   
   public class SceneWatcher
   {
       
      
      protected var sys:IAngelSysAPI;
      
      protected var gDispatcher:IEventDispatcher;
      
      protected var listeners:Array;
      
      protected var currDes:SceneDes;
      
      protected var gData:IGlobalDataAPI;
      
      private var __isInNewWorld:Boolean;
      
      public function SceneWatcher(param1:IAngelSysAPI)
      {
         super();
         this.sys = param1;
         this.listeners = [];
         this.init();
      }
      
      protected function init() : void
      {
         this.gDispatcher = this.sys.getGEventAPI().angelEventDispatcher;
         this.gData = this.sys.getGDataAPI();
         this.gDispatcher.addEventListener(AngelSysEvent.ON_SCENEDATA_INIT,this.onSceneDataInit);
         this.gDispatcher.addEventListener(AngelSysEvent.ON_SCENE_DESTROY,this.onSceneDestory);
      }
      
      protected function onSceneDataInit(param1:AngelSysEvent) : void
      {
         var _loc4_:ISceneListener = null;
         this.currDes = this.gData.getGlobalVal(Constants.CUR_SCENE) as SceneDes;
         var _loc2_:int = this.currDes.sceneID;
         if(_loc2_ == 10005)
         {
            this.__isInNewWorld = true;
         }
         if(_loc2_ > 0 && _loc2_ < 10000 && _loc2_ != 102)
         {
            if(_loc2_ < 2000)
            {
               this.__isInNewWorld = false;
            }
            else if(_loc2_ == 2100)
            {
               this.__isInNewWorld = false;
            }
            else if(_loc2_ == 2041)
            {
               this.__isInNewWorld = false;
            }
            else
            {
               this.__isInNewWorld = true;
            }
         }
         var _loc3_:int = int(this.listeners.length - 1);
         while(_loc3_ >= 0)
         {
            if((_loc4_ = this.listeners[_loc3_]) != null && this.currDes != null)
            {
               _loc4_.enterScene(this.currDes);
            }
            _loc3_--;
         }
      }
      
      public function get isInNewWorld() : Boolean
      {
         return this.__isInNewWorld;
      }
      
      protected function onSceneDestory(param1:AngelSysEvent) : void
      {
         var _loc4_:ISceneListener = null;
         var _loc2_:SceneDes = this.currDes;
         this.currDes = null;
         var _loc3_:int = 0;
         while(_loc3_ < this.listeners.length)
         {
            if((_loc4_ = this.listeners[_loc3_]) != null)
            {
               _loc4_.leaveScene(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function addSceneListener(param1:ISceneListener) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.listeners.indexOf(param1) != -1)
         {
            return;
         }
         this.listeners.push(param1);
         if(this.currDes != null)
         {
            param1.enterScene(this.currDes);
         }
      }
      
      public function removeSceneListener(param1:ISceneListener) : void
      {
         var _loc2_:int = this.listeners.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.listeners.splice(_loc2_,1);
         }
      }
      
      public function getCurrentDes() : SceneDes
      {
         return this.currDes;
      }
      
      public function getCurrentLogic() : ISceneLogic
      {
         return this.sys.getWorldAPI().getSceneAPI().getSceneLogic();
      }
   }
}
