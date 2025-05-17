package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.ItemDataDes;
   import com.QQ.angel.data.entity.UserItem;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.ServerPushedItems;
   
   public class ServerPushedItemsProcessor implements IDataProcessor
   {
      
      public function ServerPushedItemsProcessor()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc6_:UserItem = null;
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:IDataProxy = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA);
         var _loc4_:ServerPushedItems = new ServerPushedItems();
         _loc4_.items = [];
         _loc4_.money = _loc2_.readUnsignedInt();
         var _loc5_:int = int(_loc2_.readUnsignedShort());
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_)
         {
            _loc6_ = new UserItem();
            _loc6_.id = _loc2_.readUnsignedInt();
            _loc6_.count = _loc2_.readUnsignedShort();
            _loc6_.itemDes = _loc3_.select(_loc6_.id) as ItemDataDes;
            _loc4_.items.push(_loc6_);
            _loc7_++;
         }
         if(_loc4_.money > 0)
         {
            _loc6_ = new UserItem();
            _loc6_.id = 67239984;
            _loc6_.count = _loc4_.money;
            _loc6_.itemDes = _loc3_.select(_loc6_.id) as ItemDataDes;
            _loc4_.items.push(_loc6_);
         }
         return _loc4_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SERVER_PUSH_ITEMS;
      }
   }
}

