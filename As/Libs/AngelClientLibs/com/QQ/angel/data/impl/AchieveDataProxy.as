package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.AchieveDes;
   import flash.utils.Dictionary;
   
   public class AchieveDataProxy implements IDataProxy
   {
       
      
      public var ids:Array;
      
      private var types:Array;
      
      private var dic:Dictionary;
      
      private var xml:XML;
      
      public function AchieveDataProxy(param1:Object)
      {
         super();
         this.types = [];
         this.ids = [];
         this.dic = new Dictionary();
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:AchieveDes = null;
         var _loc7_:String = null;
         this.xml = param1 is XML ? param1 as XML : new XML(param1);
         this.types = new Array(5);
         var _loc2_:int = 0;
         while(_loc2_ < this.xml.title.length())
         {
            _loc3_ = int(this.xml.title[_loc2_].@type);
            if(this.types[_loc3_] == null)
            {
               this.types[_loc3_] = [];
            }
            if((_loc4_ = this.xml.title[_loc2_].level.length()) > 0)
            {
               _loc5_ = 0;
               while(_loc5_ < _loc4_)
               {
                  (_loc6_ = new AchieveDes()).achieveId = int(this.xml.title[_loc2_].@id);
                  _loc6_.titleLevel = int(this.xml.title[_loc2_].level[_loc5_].@id);
                  _loc6_.label = String(this.xml.title[_loc2_].level[_loc5_].@label);
                  _loc6_.total = int(this.xml.title[_loc2_].level[_loc5_].@total);
                  _loc6_.tips = String(this.xml.title[_loc2_].@tips).replace("$total$",_loc6_.total);
                  _loc6_.typeId = _loc3_;
                  if(_loc7_ = String(this.xml.title[_loc2_].@startDate))
                  {
                     _loc6_.startDate = new Date(int(_loc7_.substr(0,4)),int(_loc7_.substr(4,2)) - 1,int(_loc7_.substr(6,2)));
                  }
                  if(_loc7_ = String(this.xml.title[_loc2_].@endDate))
                  {
                     _loc6_.endDate = new Date(int(_loc7_.substr(0,4)),int(_loc7_.substr(4,2)) - 1,int(_loc7_.substr(6,2)));
                  }
                  this.types[_loc3_].push(_loc6_.achieveId + "_" + _loc6_.titleLevel);
                  this.dic[_loc6_.achieveId + "_" + _loc6_.titleLevel] = _loc6_;
                  this.ids.push(_loc6_.achieveId + "_" + _loc6_.titleLevel);
                  _loc5_++;
               }
            }
            _loc2_++;
         }
      }
      
      public function getIdByType(param1:int) : Array
      {
         return this.types[param1];
      }
      
      public function getTitleById(param1:String) : AchieveDes
      {
         return this.dic[param1];
      }
      
      public function getTitle(param1:int, param2:int) : AchieveDes
      {
         return this.getTitleById(param1 + "_" + param2);
      }
      
      public function getHasTitleNum() : int
      {
         var _loc2_:AchieveDes = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.dic)
         {
            if(_loc2_.achieveId > 80 && _loc2_.value >= _loc2_.total)
            {
               if(_loc1_.indexOf(_loc2_.achieveId) == -1)
               {
                  _loc1_.push(_loc2_.achieveId);
               }
            }
         }
         return _loc1_.length;
      }
      
      public function getHasMedalNum() : int
      {
         var _loc1_:int = 0;
         var _loc2_:AchieveDes = null;
         for each(_loc2_ in this.dic)
         {
            if(_loc2_.achieveId <= 80 && _loc2_.value >= _loc2_.total)
            {
               _loc1_++;
            }
         }
         return _loc1_;
      }
      
      public function getTypeLength() : int
      {
         return this.types.length;
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         var _loc2_:int = int(rest[0]);
         var _loc3_:int = int(rest[1]);
         return this.getTitle(_loc2_,_loc3_);
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
         return Constants.ACHIEVE_LIST_DATA;
      }
   }
}
