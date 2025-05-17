package com.QQ.angel.world.res
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.res.AvatarRequest;
   import com.QQ.angel.world.vo.Avatar;
   
   public class AvatarLoadArg
   {
      
      public var index:int = 0;
      
      public var taskID:int;
      
      public var url:String;
      
      public var avatarType:uint;
      
      public var avatarVersion:int;
      
      public var reqs:Array;
      
      public function AvatarLoadArg()
      {
         super();
      }
      
      public function isEmpty() : Boolean
      {
         return this.reqs == null || this.reqs.length == 0;
      }
      
      public function addReq(param1:AvatarRequest, param2:String = "") : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.reqs == null)
         {
            this.reqs = [];
            this.avatarType = param1.avatarType;
            this.avatarVersion = param1.avatarVersion;
            this.url = param2;
         }
         else if(this.reqs.indexOf(param1) != -1)
         {
            return;
         }
         this.reqs.push(param1);
      }
      
      public function removeReq(param1:AvatarRequest) : void
      {
         var _loc2_:int = int(this.reqs.indexOf(param1));
         if(_loc2_ != -1)
         {
            this.reqs.splice(_loc2_,1);
            param1.reset();
         }
      }
      
      public function match(param1:AvatarRequest) : Boolean
      {
         return this.avatarType == param1.avatarType && this.avatarVersion == param1.avatarVersion;
      }
      
      public function avatarLoadedCall(param1:Avatar) : void
      {
         var _loc3_:AvatarRequest = null;
         var _loc4_:CFunction = null;
         if(this.isEmpty())
         {
            return;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.reqs.length)
         {
            _loc3_ = this.reqs[_loc2_];
            _loc4_ = _loc3_.callBack;
            if(_loc4_ != null)
            {
               _loc4_.call(param1);
            }
            _loc2_++;
         }
      }
      
      public function clear() : void
      {
         this.reqs = null;
      }
   }
}

