package com.QQ.angel.common
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.RoleData;
   import com.QQ.angel.data.entity.tasksys.model.IModelManager;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.processor.RoleDetailProcessor;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.net.protocol.P_GetBagSpirits;
   import com.QQ.angel.net.protocol.P_GetBossAward;
   import com.QQ.angel.net.protocol.P_GetBossStatus;
   import com.QQ.angel.net.protocol.P_LoadNpcVal;
   import com.QQ.angel.net.protocol.P_Query;
   import com.QQ.angel.net.protocol.P_UInt;
   import com.QQ.angel.net.protocol.P_UpdateNpcVal;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class CommonDataAPI extends AbstractDataReceiver
   {
       
      
      private var __heroData:RoleData;
      
      private var __models:IModelManager;
      
      private var __cgiLoader:URLLoader;
      
      private var __netSysApi:INetSysAPI;
      
      private var __handlerMaps:Dictionary;
      
      public function CommonDataAPI(param1:IAngelSysAPI)
      {
         super();
         setAngelSysAPI(param1);
         this.__cgiLoader = sysApi.getNetSysAPI().createURLLoader(true);
         this.__cgiLoader.addEventListener(Event.COMPLETE,this.__clickCGIResponse);
         this.__cgiLoader.addEventListener(IOErrorEvent.IO_ERROR,this.__clickCGIResponse);
         this.__netSysApi = sysApi.getNetSysAPI();
         this.__netSysApi.addDataProcessor(new RoleDetailProcessor());
         this.__netSysApi.addDataReceiver(this);
         this.__handlerMaps = new Dictionary();
      }
      
      private function __onNpcValUpdate(param1:P_UpdateNpcVal) : void
      {
         trace("[GDataProvider] NPC数据存储:" + param1.code.message + "," + param1.npcID + "," + param1.value);
      }
      
      private function __clickCGIResponse(param1:Event) : void
      {
         if(param1.type == IOErrorEvent.IO_ERROR)
         {
            trace("[GDataProvider] NPC点击CGI请求失败:" + (param1 as IOErrorEvent).text);
            return;
         }
         var _loc2_:String = this.__cgiLoader.data as String;
         var _loc3_:XML = new XML(_loc2_);
         trace("[GDataProvider] NPC点击CGI请求成功:" + _loc2_);
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         var _loc3_:Function = null;
         var _loc4_:int = 0;
         switch(param1)
         {
            case ADFCmdsType.T_GET_USER_DETAIL:
               _loc4_ = int(param2.serNum);
               _loc3_ = this.__handlerMaps[_loc4_];
               delete this.__handlerMaps[_loc4_];
               if(_loc3_ != null)
               {
                  _loc3_(param2);
               }
         }
      }
      
      public function get modelManager() : IModelManager
      {
         if(this.__models == null)
         {
            this.__models = sysApi.getGDataAPI().getGlobalVal(Constants.TASK_LIST_DATA) as IModelManager;
         }
         return this.__models;
      }
      
      public function get MainRoleData() : RoleData
      {
         if(this.__heroData == null)
         {
            this.__heroData = sysApi.getGDataAPI().getGlobalVal(Constants.MAIN_ROLE_INFO) as RoleData;
         }
         return this.__heroData;
      }
      
      public function requestRoleDetail(param1:Function, param2:uint = 0) : void
      {
         if(param2 == 0)
         {
            param2 = this.MainRoleData.uin;
         }
         if(param1 == null)
         {
            return;
         }
         sendDataWithSerNum(ADFCmdsType.T_GET_USER_DETAIL,param2);
         if(serNum != 0)
         {
            this.__handlerMaps[serNum] = param1;
         }
      }
      
      public function checkNpcVal(param1:uint, param2:Function) : void
      {
         var _loc3_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_LOAD_NPCVAL,new P_LoadNpcVal(param1),P_LoadNpcVal,param2);
         _loc3_.send();
         trace("[GDataProvider] 获取NPC的远程值:" + param1);
      }
      
      public function checkHaveItem(param1:Object, param2:Array = null, param3:Function = null) : void
      {
         if(param1 != null)
         {
            param2 = param1.array;
            param3 = param1.handler;
         }
         var _loc4_:P_FreeRequest;
         (_loc4_ = new P_FreeRequest(ADFCmdsType.T_QUERY,new P_Query(param2),P_Query,param3)).send();
      }
      
      public function requestBagSpirits(param1:Function) : void
      {
         var _loc2_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_SPIRIT_BAG_DATA,new P_UInt(),P_GetBagSpirits,param1);
         _loc2_.send();
      }
      
      public function updateNpcVal(param1:uint, param2:int, param3:Function = null) : void
      {
         var _loc4_:P_FreeRequest;
         (_loc4_ = new P_FreeRequest(ADFCmdsType.T_UPDATE_NPCVAL,new P_UpdateNpcVal(param1,param2),P_UpdateNpcVal,param3 != null ? param3 : this.__onNpcValUpdate)).send();
         trace("[GDataProvider] 更新NPC的远程值:" + param1 + "," + param2);
      }
      
      public function requestBossStatus(param1:Function) : void
      {
         var _loc2_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.TYPE_BOSS_STATUS,new P_UInt(),P_GetBossStatus,param1);
         _loc2_.send();
      }
      
      public function requestBossAward(param1:int, param2:Function) : void
      {
         var _loc3_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.TYPE_BOSS_AWARD,new P_GetBossAward(param1),P_GetBossAward,param2);
         _loc3_.send();
      }
      
      public function fireClickToCGI(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:URLRequest = null;
         if(param2)
         {
            this.modelManager.submitNpcClick(param1);
         }
         else
         {
            _loc3_ = new URLRequest(DEFINE.CGI_ROOT + "process_task?cmd=2&id=" + param1);
            this.__cgiLoader.load(_loc3_);
         }
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_GET_USER_DETAIL];
      }
   }
}
