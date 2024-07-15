package com.QQ.angel.actions.data
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.INetSysAPI;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_ItemType;
   
   public class GetBagItemNum extends AbstractDataReceiver
   {
       
      
      private var curHandler:Function;
      
      private var curid:uint;
      
      private var bagData:Array;
      
      private var delayItemIDs:Array;
      
      public function GetBagItemNum(param1:IAngelSysAPI, param2:Function, param3:int = 4)
      {
         super();
         var _loc4_:INetSysAPI;
         (_loc4_ = param1.getNetSysAPI()).addDataReceiver(this);
         var _loc5_:P_ItemType;
         (_loc5_ = new P_ItemType()).itemType = param3;
         _loc5_.itemSubType = 0;
         sendDataToServer(ADFCmdsType.T_GETITEMSBYTYPE,_loc5_);
         this.curHandler = param2;
      }
      
      public function requestBagItemNumByID(param1:uint) : void
      {
         if(this.bagData == null)
         {
            if(this.delayItemIDs == null)
            {
               this.delayItemIDs = [];
            }
            this.delayItemIDs.push(param1);
         }
         else
         {
            this.curHandler(this.getBagItemByID(param1));
         }
      }
      
      private function getBagItemByID(param1:uint) : Object
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.bagData.length)
         {
            if(this.bagData[_loc2_].id == param1)
            {
               return Object(this.bagData[_loc2_]);
            }
            _loc2_++;
         }
         return {
            "id":param1,
            "count":0
         };
      }
      
      override public function onDataReceive(param1:int, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(param1 != ADFCmdsType.T_GETITEMSBYTYPE)
         {
            return;
         }
         this.bagData = param2 as Array;
         while(this.delayItemIDs != null && this.delayItemIDs.length > 0)
         {
            _loc3_ = this.delayItemIDs.pop();
            this.curHandler(this.getBagItemByID(_loc3_));
         }
      }
      
      override public function getAcceptTypes() : Array
      {
         return [ADFCmdsType.T_GETITEMSBYTYPE];
      }
   }
}
