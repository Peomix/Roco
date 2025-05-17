package com.QQ.angel.access
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAccessPermission;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.data.entity.RoleData;
   
   public class AngelAccessPermission implements IAccessPermission, IAngelSysAPIAware
   {
      
      protected var sysApi:IAngelSysAPI;
      
      protected var commUI:ICommUIManager;
      
      public function AngelAccessPermission()
      {
         super();
      }
      
      public function canAccess(param1:int, param2:Boolean = true, param3:String = "", param4:Object = null) : Boolean
      {
         var _loc5_:RoleData = this.sysApi.getGDataAPI().getGlobalVal(Constants.MAIN_ROLE_INFO) as RoleData;
         if(_loc5_.roleType > RoleData.GUEST)
         {
            return true;
         }
         if(param2)
         {
            this.commUI.alert("",param3 == "" ? "游客不允许此操作!!" : param3);
         }
         return false;
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.sysApi = param1;
         this.commUI = this.sysApi.getUISysAPI().commUIManager;
      }
   }
}

