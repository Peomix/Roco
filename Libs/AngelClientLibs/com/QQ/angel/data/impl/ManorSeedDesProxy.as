package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.ManorSeedDes;
   import flash.utils.Dictionary;
   
   public class ManorSeedDesProxy implements IDataProxy
   {
       
      
      private var dic:Dictionary;
      
      private var idList:Array;
      
      public function ManorSeedDesProxy(param1:Object)
      {
         super();
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var _loc6_:ManorSeedDes = null;
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc3_:XMLList = _loc2_.children();
         var _loc4_:uint = uint(_loc3_.length());
         var _loc5_:uint = 0;
         this.dic = new Dictionary();
         this.idList = [];
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            (_loc6_ = new ManorSeedDes()).id = uint(_loc3_[_loc5_].@id);
            _loc6_.name = _loc3_[_loc5_].@name;
            _loc6_.proficiencyExp = _loc3_[_loc5_].@proficiencyExp != undefined ? int(_loc3_[_loc5_].@proficiencyExp) : -1;
            _loc6_.proficiencyType = _loc3_[_loc5_].@proficiencyType != undefined ? int(_loc3_[_loc5_].@proficiencyType) : -1;
            _loc6_.proficiencylv = _loc3_[_loc5_].@proficiencylv != undefined ? int(_loc3_[_loc5_].@proficiencylv) : -1;
            _loc6_.src = _loc3_[_loc5_].@src;
            _loc6_.linkName = _loc3_[_loc5_].@linkName;
            _loc6_.buyLevel = int(_loc3_[_loc5_].@buyLevel);
            _loc6_.seedExp = int(_loc3_[_loc5_].@seedExp);
            _loc6_.seasonN = int(_loc3_[_loc5_].@seasonN);
            _loc6_.grownTime = uint(_loc3_[_loc5_].@grownTime);
            _loc6_.harvestN = uint(_loc3_[_loc5_].@harvestN);
            _loc6_.harvestExpdes = uint(_loc3_[_loc5_].@harvestExpdes);
            _loc6_.harvestId = uint(_loc3_[_loc5_].@harvestId);
            _loc6_.des = _loc3_[_loc5_].@des;
            this.dic[_loc6_.id] = _loc6_;
            this.idList.push(_loc6_.id);
            _loc5_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         var _loc2_:uint = uint(rest[0]);
         if(_loc2_ == -1 || _loc2_ == 0)
         {
            return this.idList;
         }
         return this.dic[_loc2_];
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
         return Constants.MANOR_SEED_DATA;
      }
   }
}
