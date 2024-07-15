package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.combatsys.GuardianPetDes;
   import flash.utils.Dictionary;
   
   public class GuardianPetDesProxy implements IDataProxy
   {
       
      
      protected var desMaps:Dictionary;
      
      protected var phaseLvMaps:Dictionary;
      
      protected var lvConsumeMaps:Dictionary;
      
      protected var listMaps:Array;
      
      private var _highestLv:uint;
      
      public function GuardianPetDesProxy(param1:Object)
      {
         super();
         this.desMaps = new Dictionary();
         this.phaseLvMaps = new Dictionary();
         this.lvConsumeMaps = new Dictionary();
         this.listMaps = [];
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var _loc8_:XML = null;
         var _loc9_:XML = null;
         var _loc10_:GuardianPetDes = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = 0;
         var _loc13_:XML = null;
         var _loc14_:XML = null;
         var _loc15_:uint = 0;
         var _loc16_:uint = 0;
         var _loc17_:uint = 0;
         var _loc18_:uint = 0;
         var _loc2_:* = DEFINE.COMM_ROOT + "res/guardianPet/";
         var _loc3_:XML = param1 is XML ? param1 as XML : XML(param1);
         var _loc4_:XMLList = _loc3_.propertyDes;
         var _loc5_:XMLList = _loc3_.guardianPetDes;
         var _loc6_:XMLList = _loc3_.lvPhaseDes;
         var _loc7_:XMLList = _loc3_.consumeDes;
         this._highestLv = _loc3_.highestLv.@value;
         for each(_loc9_ in _loc5_)
         {
            for each(_loc8_ in _loc4_)
            {
               _loc10_ = new GuardianPetDes();
               _loc11_ = uint(_loc9_.@id) * 100 + uint(_loc8_.@lv);
               _loc12_ = uint(_loc9_.@id) * 100 + uint(_loc8_.@phase);
               _loc10_.phase = uint(_loc8_.@phase);
               _loc10_.avatar = this.getAvatarURL(_loc12_,_loc2_);
               _loc10_.id = _loc12_;
               _loc10_.name = String(_loc9_.@name);
               _loc10_.description = String(_loc9_.@description);
               _loc10_.energyBonus = _loc8_.@energy;
               _loc10_.attackBonus = _loc8_.@attack;
               _loc10_.defendBonus = _loc8_.@defend;
               _loc10_.magicAttackBonus = _loc8_.@magicAttack;
               _loc10_.magicDefendBonus = _loc8_.@magicDefend;
               this.desMaps[_loc11_] = _loc10_;
               this.listMaps.push(_loc10_);
            }
         }
         for each(_loc13_ in _loc6_)
         {
            _loc15_ = uint(_loc13_.@phase);
            _loc16_ = uint(_loc13_.@lv);
            this.phaseLvMaps[_loc15_] = _loc16_;
         }
         for each(_loc14_ in _loc7_)
         {
            _loc17_ = uint(_loc14_.@lv);
            _loc18_ = uint(_loc14_.@consume);
            this.lvConsumeMaps[_loc17_] = _loc18_;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function selectLvByPhase(param1:uint) : uint
      {
         return this.phaseLvMaps[param1];
      }
      
      public function selectConsumeByLv(param1:uint) : uint
      {
         return this.lvConsumeMaps[param1];
      }
      
      public function select(... rest) : Object
      {
         if(rest[0] == "*")
         {
            return this.listMaps;
         }
         return this.desMaps[int(rest[0])];
      }
      
      public function getHighestLv() : uint
      {
         return this._highestLv;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         return false;
      }
      
      protected function getAvatarURL(param1:uint, param2:String) : String
      {
         var _loc3_:* = param1 + "";
         return param2 + _loc3_ + ".swf";
      }
      
      protected function getProperty() : void
      {
      }
      
      public function clear() : void
      {
      }
      
      public function getName() : String
      {
         return Constants.GUARDIANPET_DATA;
      }
   }
}
