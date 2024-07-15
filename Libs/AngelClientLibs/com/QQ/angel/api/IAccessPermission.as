package com.QQ.angel.api
{
   public interface IAccessPermission
   {
       
      
      function canAccess(param1:int, param2:Boolean = true, param3:String = "", param4:Object = null) : Boolean;
   }
}
