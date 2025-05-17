package com.QQ.angel.world.net
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.ItemRewardData;
   import com.QQ.angel.data.entity.UserItem;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.data.entity.msg.SysMsgDes;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.net.processor.ServerPushedItemsProcessor;
   import com.QQ.angel.world.net.processor.ServerPushedSpiritProcessor;
   import com.QQ.angel.world.vo.ServerPushedItems;
   import com.QQ.angel.world.vo.ServerPushedSpirit;
   
   public class ServerPushReceiver extends AbstractDataReceiver
   {
      
      public function ServerPushReceiver()
      {
         super();
      }
      
      override public function initialize() : void
      {
         super.initialize();
         this.sysApi.getNetSysAPI().addDataProcessor(new ServerPushedItemsProcessor());
         this.sysApi.getNetSysAPI().addDataProcessor(new ServerPushedSpiritProcessor());
      }
      
      override public function finalize() : void
      {
         this.sysApi.getNetSysAPI().removeDataProcessor(new ServerPushedItemsProcessor());
         this.sysApi.getNetSysAPI().removeDataProcessor(new ServerPushedSpiritProcessor());
         super.finalize();
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         switch(param1)
         {
            case ADFCmdsType.T_SERVER_PUSH_ITEMS:
               this.addItemsNotificationToSystemQueue(param2 as ServerPushedItems);
               break;
            case ADFCmdsType.T_SERVER_PUSH_SPIRIT:
               this.addSpiritNotificationToSystemQueue(param2 as ServerPushedSpirit);
         }
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_SERVER_PUSH_ITEMS,ADFCmdsType.T_SERVER_PUSH_SPIRIT];
      }
      
      private function addItemsNotificationToSystemQueue(param1:ServerPushedItems) : void
      {
         var _loc4_:UserItem = null;
         if(param1 == null || param1.items == null)
         {
            return;
         }
         var _loc2_:ItemRewardData = new ItemRewardData();
         _loc2_.items = [];
         var _loc3_:int = int(param1.items.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = param1.items[_loc5_] as UserItem;
            if(_loc4_ != null && _loc4_.count > 0)
            {
               _loc2_.items.push({
                  "name":_loc4_.itemDes.name,
                  "num":_loc4_.count,
                  "src":DEFINE.ITEM_RES_ROOT + _loc4_.id + ".png",
                  "tooltip":_loc4_.itemDes.name
               });
            }
            _loc5_++;
         }
         if(_loc2_.items.length > 0)
         {
            this.sysApi.getMSGAPI().chunnelPush(new SysMsgDes(SysMsgDes.GOT_ITEMS,_loc2_));
         }
      }
      
      private function addSpiritNotificationToSystemQueue(param1:ServerPushedSpirit) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA);
         var _loc3_:SpiritDes = _loc2_.select(param1.spiritID) as SpiritDes;
         var _loc4_:* = "【" + _loc3_.name + "】被放入" + (param1.putTo == 1 ? "宠物背包" : "仓库") + "了";
         this.sysApi.getMSGAPI().chunnelPush(new SysMsgDes(SysMsgDes.H_EFFECT,_loc4_));
      }
   }
}

