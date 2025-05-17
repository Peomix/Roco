package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.combatsys.GuardianPetVipAvatarDes;
   import flash.utils.Dictionary;
   
   public class GuardianPetVipAvatarDesProxy implements IDataProxy
   {
      
      protected var desMaps:Dictionary;
      
      protected var listMaps:Array;
      
      public function GuardianPetVipAvatarDesProxy(param1:Object)
      {
         super();
         this.desMaps = new Dictionary();
         this.listMaps = [];
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var _loc4_:XML = null;
         var _loc5_:GuardianPetVipAvatarDes = null;
         var _loc6_:uint = 0;
         var _loc2_:XML = param1 is XML ? param1 as XML : XML(param1);
         var _loc3_:XMLList = _loc2_.avatarDes;
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = new GuardianPetVipAvatarDes();
            _loc6_ = uint(_loc5_.baseId = _loc4_.@id);
            _loc5_.name = _loc4_.@name;
            _loc5_.needVipLv = _loc4_.@needVipLv;
            _loc5_.status = _loc4_.@status;
            _loc5_.curDisplayLv = _loc4_.@curLv;
            _loc5_.isCurAvatar = false;
            this.desMaps[_loc6_] = _loc5_;
            this.listMaps.push(_loc5_);
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(rest[0] == "*")
         {
            return this.listMaps;
         }
         return this.desMaps[int(rest[0])];
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
      
      public function getName() : String
      {
         return Constants.GUARDIANPET_VIPAVATAR_DATA;
      }
   }
}

