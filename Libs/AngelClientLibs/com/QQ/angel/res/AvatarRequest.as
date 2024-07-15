package com.QQ.angel.res
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.RoleData;
   
   public class AvatarRequest
   {
       
      
      public var taskID:int = -1;
      
      public var avatarType:uint;
      
      public var avatarURL:String;
      
      public var avatarVersion:int;
      
      public var roleData:RoleData;
      
      public var motionType:int;
      
      public var callBack:CFunction;
      
      public function AvatarRequest(param1:uint, param2:int, param3:int, param4:CFunction)
      {
         super();
         this.avatarType = param1;
         this.avatarVersion = param2;
         this.motionType = param3;
         this.callBack = param4;
      }
      
      public function reset(param1:Boolean = false) : void
      {
         this.taskID = -1;
         if(param1)
         {
            this.avatarType = 0;
            this.avatarVersion = 0;
            this.motionType = 0;
         }
      }
      
      public function isNull() : Boolean
      {
         return this.taskID == -1;
      }
   }
}
