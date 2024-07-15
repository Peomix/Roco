package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.events.AngelDataEvent;
   import com.QQ.angel.api.net.AbstractDataReceiver;
   import com.QQ.angel.api.net.IDataReceiver;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.INetSystem;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   
   public class ADFReceivers extends EventDispatcher
   {
       
      
      protected var netSystem:INetSystem;
      
      protected var maps:Dictionary;
      
      protected var currReqsMap:Dictionary;
      
      public function ADFReceivers(param1:INetSystem)
      {
         super();
         this.maps = new Dictionary();
         this.currReqsMap = new Dictionary();
         this.netSystem = param1;
      }
      
      protected function allSendADFHandler(param1:AngelDataEvent) : void
      {
         var _loc2_:AbstractDataReceiver = param1.target as AbstractDataReceiver;
         var _loc3_:uint = this.netSystem.trySendData(param1.dataType,param1.data,param1.hasSerNum,param1.tcpID);
         if(_loc3_ == 0 && _loc2_ != null)
         {
            _loc2_.catchTrySendDataError(param1.dataType,param1.tcpID,param1.data);
         }
         else if(param1.hasSerNum)
         {
            _loc2_.serNum = _loc3_;
            this.currReqsMap[param1.dataType + " " + _loc3_] = _loc2_;
         }
      }
      
      public function add(param1:IDataReceiver) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         param1.addEventListener(AngelDataEvent.TRYSENDADF,this.allSendADFHandler);
         var _loc2_:Array = param1.getAcceptTypes();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            if(this.maps[_loc4_] == null)
            {
               this.maps[_loc4_] = [];
            }
            if((_loc5_ = this.maps[_loc4_] as Array).indexOf(param1) == -1)
            {
               _loc5_.push(param1);
            }
            _loc3_++;
         }
      }
      
      public function remove(param1:IDataReceiver) : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         param1.removeEventListener(AngelDataEvent.TRYSENDADF,this.allSendADFHandler);
         var _loc2_:Array = param1.getAcceptTypes();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = int(_loc2_[_loc3_]);
            if((_loc5_ = this.maps[_loc4_]) == null)
            {
               return;
            }
            if((_loc6_ = _loc5_.indexOf(param1)) != -1)
            {
               _loc5_.splice(_loc6_,1);
            }
            _loc3_++;
         }
      }
      
      public function onDataReceive(param1:ADF) : void
      {
         var _loc5_:String = null;
         var _loc6_:IDataReceiver = null;
         var _loc7_:int = 0;
         if(param1.head == null)
         {
            return;
         }
         var _loc2_:int = int(param1.head.cmdID);
         var _loc3_:uint = param1.head.uiSerialNum;
         if(_loc3_ != 0)
         {
            _loc5_ = _loc2_ + " " + _loc3_;
            if((_loc6_ = this.currReqsMap[_loc5_]) != null)
            {
               delete this.currReqsMap[_loc5_];
               _loc6_.onDataReceive(_loc2_,param1.body);
               return;
            }
         }
         var _loc4_:Array;
         if((_loc4_ = this.maps[_loc2_] as Array) != null)
         {
            _loc7_ = int(_loc4_.length - 1);
            while(_loc7_ >= 0)
            {
               if((_loc6_ = _loc4_[_loc7_] as IDataReceiver) != null)
               {
                  _loc6_.onDataReceive(_loc2_,param1.body);
               }
               _loc7_--;
            }
            return;
         }
         trace("[NetSystem] 有个命令字为0x" + _loc2_.toString(16) + "被丢弃!");
      }
      
      public function dispose() : void
      {
         this.maps = null;
      }
   }
}
