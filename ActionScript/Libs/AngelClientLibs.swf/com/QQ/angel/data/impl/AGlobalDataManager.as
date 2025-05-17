package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.IGreenSystem;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.data.entity.ServerInfo;
   import flash.utils.Dictionary;
   
   public class AGlobalDataManager implements IGlobalDataAPI, IGreenSystem
   {
      
      protected var proxyList:Dictionary;
      
      protected var globalData:Dictionary;
      
      public function AGlobalDataManager()
      {
         super();
      }
      
      public function addDataProxy(param1:IDataProxy) : void
      {
         var _loc2_:String = param1.getName();
         this.proxyList[_loc2_] = param1;
      }
      
      public function initialize(... rest) : void
      {
         this.proxyList = new Dictionary();
         this.globalData = new Dictionary();
         var _loc2_:Object = rest[0];
         this.addGlobalVal(Constants.CONFS,rest[0]);
         var _loc3_:ServerInfo = _loc2_[Constants.CUR_SERVER_INFO];
         this.addGlobalVal(Constants.CUR_SERVER_INFO,_loc3_);
         _loc2_[Constants.CUR_SERVER_INFO] = null;
         this.addDataProxy(new AngelLocalDataProxy(_loc3_.uin));
         this.addDataProxy(new AngelRoleDataProxy());
         this.addDataProxy(new AngelMSDataProxy(_loc2_["magic_conf"]));
         _loc2_["magic_conf"] = null;
         this.addDataProxy(new AngelItemDataProxy(_loc2_["ItemConfig"]));
         _loc2_["ItemConfig"] = null;
         this.addDataProxy(new SpiritDesProxy(_loc2_["spirit_conf"]));
         this.addDataProxy(new GuardianPetDesProxy(_loc2_["guardianPet_conf"]));
         this.addDataProxy(new GuardianPetVipAvatarDesProxy(_loc2_["guardianPetVipAvatar_conf"]));
         this.addDataProxy(new SpiritSkillDesProxy(_loc2_["spiritSkill_conf"]));
         _loc2_["spiritSkill_conf"] = null;
         this.addDataProxy(new SpiritEqDesProxy(_loc2_["spiritEquipment_conf"]));
         _loc2_["spiritEquipment_conf"] = null;
         this.addDataProxy(new ManorSeedDesProxy(_loc2_["ManorSeedConfig"]));
         _loc2_["ManorSeedConfig"] = null;
         this.addDataProxy(new AchieveDataProxy(_loc2_["achieve_conf"]));
         _loc2_["achieve_conf"] = null;
         this.addDataProxy(new FurnitureDataProxy(_loc2_["FurnitureConstInfo"]));
         _loc2_["FurnitureConstInfo"] = null;
         this.addDataProxy(new NewbieGuideDataProxy(_loc2_["NewbieGuideConfig"]));
         _loc2_["NewbieGuideConfig"] = null;
         this.addDataProxy(new DressUpItemDataProxy());
         var _loc4_:DazzleDressSuitDataProxy = new DazzleDressSuitDataProxy(_loc2_["DazzleDressSet"]);
         this.addDataProxy(_loc4_);
         _loc2_["DazzleDressSet"] = null;
         this.addDataProxy(new DazzleDressDataProxy(_loc4_,_loc2_["DazzleDress"]));
         _loc2_["DazzleDress"] = null;
      }
      
      public function getDataProxy(param1:String) : IDataProxy
      {
         if(this.proxyList[param1])
         {
            return this.proxyList[param1];
         }
         return null;
      }
      
      public function finalize() : void
      {
      }
      
      public function addGlobalVal(param1:String, param2:Object) : void
      {
         this.globalData[param1] = param2;
      }
      
      public function getGlobalVal(param1:String) : Object
      {
         if(this.globalData[param1])
         {
            return this.globalData[param1];
         }
         return null;
      }
      
      public function removeGlobalVal(param1:String) : Boolean
      {
         if(this.globalData[param1])
         {
            delete this.globalData[param1];
            return true;
         }
         return false;
      }
      
      public function getLocalDataProxy() : IDataProxy
      {
         return this.getDataProxy(Constants.SO_DATA);
      }
   }
}

