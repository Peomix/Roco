package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.MagicSkillDes;
   import flash.utils.Dictionary;
   
   public class AngelMSDataProxy implements IDataProxy
   {
       
      
      protected var magicSkills:Dictionary;
      
      public function AngelMSDataProxy(param1:Object)
      {
         super();
         this.magicSkills = new Dictionary();
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var _loc5_:XML = null;
         var _loc6_:MagicSkillDes = null;
         var _loc7_:String = null;
         var _loc2_:XML = param1 is XML ? param1 as XML : new XML(param1);
         var _loc3_:XMLList = _loc2_.Magic;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            _loc5_ = _loc3_[_loc4_];
            (_loc6_ = new MagicSkillDes()).id = _loc5_.@id;
            _loc6_.name = _loc5_.@name;
            _loc6_.target = _loc5_.@target;
            _loc6_.magicType = _loc5_.@type;
            _loc6_.dur = int(_loc5_.@dur) * 1000;
            _loc6_.iconSrc = DEFINE.ITEM_RES_ROOT + _loc5_.@itemID + ".png";
            _loc6_.actionType = int(_loc5_.@actionType);
            _loc7_ = _loc5_.@resEx;
            _loc6_.resSrc = DEFINE.MAGIC_RES_ROOT + _loc6_.id + (_loc7_ == "" ? ".swf" : _loc7_);
            _loc6_.tips = _loc5_.toString();
            _loc6_.isReady = true;
            _loc6_.app = _loc5_.@app;
            this.insert(_loc6_);
            _loc4_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return this.addMagicSkillDes(rest[0]);
      }
      
      public function select(... rest) : Object
      {
         if(rest[0] == "*")
         {
            return this.getMagicSkillList();
         }
         return this.getMagicSkillDes(rest[0]);
      }
      
      public function update(... rest) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < rest.length)
         {
            this.updateMagicSkillDes(rest[_loc2_] as MagicSkillDes);
            _loc2_++;
         }
         return true;
      }
      
      public function deleted(... rest) : Boolean
      {
         var _loc2_:int = 0;
         while(_loc2_ < rest.length)
         {
            this.removeMagicSkillDes(rest[_loc2_]);
            _loc2_++;
         }
         return true;
      }
      
      public function clear() : void
      {
         this.magicSkills = new Dictionary();
      }
      
      public function getName() : String
      {
         return Constants.MAGIC_DATA;
      }
      
      protected function addMagicSkillDes(param1:MagicSkillDes) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(this.hasMagic(param1.id))
         {
            throw new Error("魔法ID为" + param1.id + "已经存在于内存中!");
         }
         this.magicSkills[param1.id] = param1;
         return true;
      }
      
      protected function removeMagicSkillDes(param1:int) : Boolean
      {
         if(this.hasMagic(param1) == false)
         {
            return false;
         }
         delete this.magicSkills[param1];
         return true;
      }
      
      protected function getMagicSkillDes(param1:int) : MagicSkillDes
      {
         return this.magicSkills[param1] as MagicSkillDes;
      }
      
      protected function updateMagicSkillDes(param1:MagicSkillDes) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:MagicSkillDes = this.getMagicSkillDes(param1.id);
         if(_loc2_ == null)
         {
            return;
         }
         _loc2_.iconSrc = param1.iconSrc;
         _loc2_.resSrc = param1.resSrc;
      }
      
      protected function getMagicSkillList() : Array
      {
         var _loc2_:Object = null;
         var _loc1_:Array = [];
         for each(_loc2_ in this.magicSkills)
         {
            _loc1_.push(_loc2_);
         }
         return _loc1_;
      }
      
      protected function hasMagic(param1:int) : Boolean
      {
         return this.magicSkills[param1] != null;
      }
   }
}
