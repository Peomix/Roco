package com.QQ.angel.apps.utils
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.FurnitureDes;
   import com.QQ.angel.data.entity.ItemDataDes;
   import com.QQ.angel.data.entity.ItemRewardData;
   import com.QQ.angel.data.entity.OpenAsWinDes;
   import com.QQ.angel.data.entity.combatsys.OpenCombatDes;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import flash.geom.Point;
   
   public class CommFunction
   {
       
      
      public function CommFunction()
      {
         super();
      }
      
      public static function callApp(param1:String, param2:String = "", param3:Object = null, param4:Boolean = true, param5:Boolean = true) : void
      {
         var _loc6_:OpenAsWinDes;
         (_loc6_ = new OpenAsWinDes()).event = AngelSysEvent.ON_OPEN_ASWIN;
         _loc6_.src = param1;
         _loc6_.name = param2;
         _loc6_.isModal = param4;
         _loc6_.params = param3;
         _loc6_.cache = param5;
         _loc6_.winPos = new Point(0,0);
         __global.openAsWin(_loc6_);
      }
      
      public static function showItems(param1:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:ItemDataDes = null;
         param1 = param1;
         var _loc2_:ItemRewardData = new ItemRewardData();
         var _loc3_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA);
         _loc2_.items = [];
         var _loc4_:uint = 0;
         while(_loc4_ < param1.length)
         {
            _loc5_ = param1[_loc4_];
            if((_loc6_ = _loc3_.select(_loc5_.id) as ItemDataDes) == null)
            {
               __global.showMsgBox(_loc5_.id + "未找到该物品配置");
            }
            else
            {
               _loc2_.items.push({
                  "num":_loc5_.count,
                  "src":_loc6_.url,
                  "tooltip":_loc6_.name,
                  "name":_loc6_.name
               });
            }
            _loc4_++;
         }
         if(_loc2_.items.length > 0)
         {
            __global.UI.showManagedWin(8,_loc2_);
         }
      }
      
      public static function setWaiting(param1:Boolean) : void
      {
         var _loc2_:ICommUIManager = __global.SysAPI.getUISysAPI().commUIManager;
         if(param1)
         {
            _loc2_.createMiniLoading();
         }
         else
         {
            _loc2_.closeMiniLoading();
         }
      }
      
      public static function alert(param1:String) : void
      {
         var _loc2_:ICommUIManager = __global.SysAPI.getUISysAPI().commUIManager;
         _loc2_.alert("",param1);
      }
      
      public static function getItemName(param1:int) : String
      {
         var _loc3_:ItemDataDes = null;
         var _loc2_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA);
         _loc3_ = _loc2_.select(param1) as ItemDataDes;
         if(_loc3_ == null)
         {
            alert("普通道具:" + param1 + "找不到配置信息.");
            return "";
         }
         return _loc3_.name;
      }
      
      public static function getSpiritName(param1:String) : String
      {
         var _loc2_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
         var _loc3_:SpiritDes = SpiritDes(_loc2_.select(int(param1)));
         if(_loc3_ == null)
         {
            alert("宠物:" + param1 + "找不到配置信息.");
            return "";
         }
         return _loc3_.name;
      }
      
      public static function getFurnitureName(param1:int) : String
      {
         var _loc2_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.FURNITURE_LIST_DATA);
         var _loc3_:FurnitureDes = _loc2_.select(param1) as FurnitureDes;
         if(_loc3_ == null)
         {
            alert("家具:" + param1 + "找不到配置信息.");
            return "";
         }
         return _loc3_.name;
      }
      
      public static function startNpcCombat(param1:int, param2:String, param3:CFunction) : void
      {
         var _loc4_:OpenCombatDes;
         (_loc4_ = new OpenCombatDes()).combatType = 2;
         _loc4_.opponentID = param1;
         _loc4_.oppoentName = param2;
         _loc4_.handler = param3;
         __global.openCombat(_loc4_);
      }
      
      public static function startMultiCombat(param1:int, param2:String, param3:CFunction) : void
      {
         var _loc4_:OpenCombatDes;
         (_loc4_ = new OpenCombatDes()).combatType = 10001;
         _loc4_.opponentID = param1;
         _loc4_.oppoentName = param2;
         _loc4_.handler = param3;
         __global.openMultiCombat(_loc4_);
      }
   }
}
