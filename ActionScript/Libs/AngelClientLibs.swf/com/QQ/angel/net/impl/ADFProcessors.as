package com.QQ.angel.net.impl
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.net.protocol.P_FreeRequest2;
   import flash.utils.Dictionary;
   
   public class ADFProcessors
   {
      
      protected var maps:Dictionary;
      
      protected var freeProcs:Dictionary;
      
      public function ADFProcessors()
      {
         super();
         this.maps = new Dictionary();
         this.freeProcs = new Dictionary();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc5_:P_FreeRequest = null;
         var _loc6_:* = null;
         var _loc7_:Object = null;
         var _loc2_:int = int(param1.head.cmdID);
         var _loc3_:uint = param1.head.uiSerialNum;
         var _loc4_:IDataProcessor = this.maps[_loc2_] as IDataProcessor;
         if(_loc4_ == null || Boolean(this.freeProcs[_loc3_] as P_FreeRequest2))
         {
            if(_loc3_ != 0 && (_loc5_ = this.freeProcs[_loc3_]) != null)
            {
               delete this.freeProcs[_loc3_];
            }
            else
            {
               _loc6_ = _loc2_ + "_";
               _loc5_ = this.freeProcs[_loc6_];
               if(_loc5_ != null)
               {
                  delete this.freeProcs[_loc6_];
               }
            }
            if(_loc5_ != null)
            {
               return _loc5_.decode(param1);
            }
            trace("[NetSystem] 命令字为:0x" + _loc2_.toString(16) + "找不到解析的IDataProcessor!");
            return null;
         }
         return _loc4_.decode(param1);
      }
      
      public function encode(param1:Object, param2:int = -1, param3:uint = 0) : ADF
      {
         var _loc6_:P_FreeRequest = null;
         var _loc4_:IDataProcessor = this.maps[param2] as IDataProcessor;
         if(_loc4_ == null || param1 is P_FreeRequest2)
         {
            _loc6_ = param1 as P_FreeRequest;
            if(_loc6_ != null)
            {
               if(param3 != 0)
               {
                  _loc6_.serialNum = param3;
                  this.freeProcs[param3] = _loc6_;
               }
               else
               {
                  this.freeProcs[param2 + "_"] = _loc6_;
               }
               return _loc6_.encode(param2);
            }
            trace("[NetSystem] 命令字为:0x" + param2.toString(16) + "找不到打包的IDataProcessor!");
            return null;
         }
         var _loc5_:ADF = _loc4_.encode(param1,param2);
         _loc5_.head.uiSerialNum = param3;
         return _loc5_;
      }
      
      public function getADFType() : int
      {
         return -1;
      }
      
      public function add(param1:IDataProcessor) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(param1 is IMulDataProcessor)
         {
            _loc3_ = (param1 as IMulDataProcessor).getADFTypes();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ = int(_loc3_[_loc4_]);
               this.addProc(_loc2_,param1);
               _loc4_++;
            }
         }
         else if(param1 != null)
         {
            _loc2_ = param1.getADFType();
            this.addProc(_loc2_,param1);
         }
      }
      
      protected function addProc(param1:int, param2:IDataProcessor) : void
      {
         if(ADFCmdsType.ALL_FREE_TS.indexOf(param1) != -1)
         {
            throw new Error("[ADFProcessors] 命令字:0x" + param1.toString(16) + "是一个自由命令字不允许注册!");
         }
         this.maps[param1] = param2;
      }
      
      public function remove(param1:IDataProcessor) : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         if(param1 is IMulDataProcessor)
         {
            _loc2_ = (param1 as IMulDataProcessor).getADFTypes();
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               this.maps[_loc2_[_loc3_]] = null;
               _loc3_++;
            }
         }
         else
         {
            this.maps[param1.getADFType()] = null;
         }
      }
      
      public function dispose() : void
      {
         this.maps = null;
      }
   }
}

