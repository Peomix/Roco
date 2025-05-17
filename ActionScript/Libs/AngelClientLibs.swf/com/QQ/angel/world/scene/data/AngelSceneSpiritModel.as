package com.QQ.angel.world.scene.data
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.data.entity.world.ISceneSpiritModel;
   import com.QQ.angel.data.entity.world.SceneSpiritKey;
   import com.QQ.angel.world.scene.events.AngelSceneModelEvent;
   import com.QQ.angel.world.vo.RefreshSpiritVo;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   
   public class AngelSceneSpiritModel extends EventDispatcher implements ISceneSpiritModel
   {
      
      private static var __desProxy:IDataProxy;
      
      protected var areas:Array;
      
      protected var spirits:Array;
      
      protected var keys:Array;
      
      public function AngelSceneSpiritModel(param1:XMLList)
      {
         var _loc2_:int = 0;
         var _loc3_:XML = null;
         var _loc4_:Rectangle = null;
         super();
         this.areas = [];
         this.keys = [];
         this.spirits = [];
         if(param1 != null && param1.length() > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.length())
            {
               _loc3_ = param1[_loc2_];
               _loc4_ = new Rectangle(_loc3_.@x,_loc3_.@y,_loc3_.@width,_loc3_.@height);
               this.areas.push(_loc4_);
               _loc2_++;
            }
         }
      }
      
      public static function getSpiritDes(param1:uint) : SpiritDes
      {
         if(__desProxy == null)
         {
            __desProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
         }
         return __desProxy.select(param1) as SpiritDes;
      }
      
      public function getAreas() : Array
      {
         return this.areas;
      }
      
      public function addSpirit(param1:SceneSpiritKey, param2:int = 0) : void
      {
         if(param1 == null || param1.id == 0)
         {
            return;
         }
         if(this.spirits == null)
         {
            this.spirits = [];
         }
         var _loc3_:RefreshSpiritVo = new RefreshSpiritVo();
         _loc3_.id = param1.id;
         _loc3_.areaIndex = param2;
         _loc3_.num = 1;
         _loc3_.sceneKey = param1;
         _loc3_.spiritDes = getSpiritDes(param1.id);
         this.spirits.push(_loc3_);
         this.keys.push(param1);
      }
      
      public function removeSpirit(param1:SceneSpiritKey) : void
      {
         var _loc3_:RefreshSpiritVo = null;
         if(this.spirits == null || param1 == null)
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.spirits.length)
         {
            _loc3_ = this.spirits[_loc2_];
            if(_loc3_ != null && param1.equal(_loc3_.sceneKey))
            {
               this.spirits.splice(_loc2_,1);
               this.keys.splice(_loc2_,1);
               return;
            }
            _loc2_++;
         }
      }
      
      public function removeAllSpirit() : void
      {
         this.spirits = [];
         this.keys = [];
      }
      
      public function removeAll() : void
      {
         this.spirits = null;
         this.areas = null;
         this.keys = null;
      }
      
      public function update() : void
      {
         dispatchEvent(new AngelSceneModelEvent(AngelSceneModelEvent.UPDATE_DATA));
      }
      
      public function getSceneSpirits() : Array
      {
         return this.spirits;
      }
      
      public function getKeys() : Array
      {
         return this.keys;
      }
   }
}

