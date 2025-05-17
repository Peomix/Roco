package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.RoleData;
   
   public class AngelRoleDataProxy implements IDataProxy
   {
      
      private var _roleList:Array;
      
      public function AngelRoleDataProxy()
      {
         super();
         this.clear();
      }
      
      public function insert(... rest) : Boolean
      {
         var _loc2_:int = int(rest.length);
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_)
            {
               _loc3_ = this.insertRoleData(rest[_loc4_]);
            }
            else
            {
               this.insertRoleData(rest[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function insertRoleData(param1:RoleData) : Boolean
      {
         var _loc3_:RoleData = null;
         var _loc2_:int = int(this._roleList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._roleList[_loc4_] as RoleData;
            if(_loc3_.id == param1.id)
            {
               return false;
            }
            _loc4_++;
         }
         this._roleList.push(param1);
         return true;
      }
      
      public function select(... rest) : Object
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:RoleData = null;
         var _loc5_:int = 0;
         if(rest[0] == "*")
         {
            return this._roleList;
         }
         if(rest.length <= 1)
         {
            return this.selectRoleData(rest[0]);
         }
         _loc2_ = int(rest.length);
         _loc3_ = [];
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = this.selectRoleData(rest[_loc5_]);
            if(_loc4_ != null)
            {
               _loc3_.push(_loc4_);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function selectRoleData(param1:uint) : RoleData
      {
         var _loc3_:RoleData = null;
         var _loc2_:int = int(this._roleList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._roleList[_loc4_] as RoleData;
            if(_loc3_.id == param1)
            {
               return _loc3_;
            }
            _loc4_++;
         }
         return null;
      }
      
      public function update(... rest) : Boolean
      {
         var _loc2_:int = int(rest.length);
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_)
            {
               _loc3_ = this.updateRoleData(rest[_loc4_]);
            }
            else
            {
               this.updateRoleData(rest[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function updateRoleData(param1:RoleData) : Boolean
      {
         var _loc3_:RoleData = null;
         var _loc2_:int = int(this._roleList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._roleList[_loc4_] as RoleData;
            if(_loc3_.id == param1.id)
            {
               _loc3_.uin = param1.uin;
               _loc3_.nickName = param1.nickName;
               _loc3_.avatarVersion = param1.avatarVersion;
               _loc3_.direction = param1.direction;
               _loc3_.motionType = param1.motionType;
               _loc3_.speed = param1.speed;
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         var _loc2_:int = int(rest.length);
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(_loc3_)
            {
               _loc3_ = this.deleteRoleData(rest[_loc4_]);
            }
            else
            {
               this.deleteRoleData(rest[_loc4_]);
            }
            _loc4_++;
         }
         return _loc3_;
      }
      
      public function deleteRoleData(param1:uint) : Boolean
      {
         var _loc3_:RoleData = null;
         var _loc2_:int = int(this._roleList.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = this._roleList[_loc4_] as RoleData;
            if(_loc3_.id == param1)
            {
               this._roleList.splice(_loc4_,1);
               return true;
            }
            _loc4_++;
         }
         return false;
      }
      
      public function clear() : void
      {
         this._roleList = [];
      }
      
      public function getName() : String
      {
         return Constants.ROLE_DATA;
      }
   }
}

