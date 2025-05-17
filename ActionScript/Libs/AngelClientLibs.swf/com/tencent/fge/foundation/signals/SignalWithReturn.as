package com.tencent.fge.foundation.signals
{
   import com.tencent.fge.foundation.log.client.Log;
   import flash.utils.getQualifiedClassName;
   
   public class SignalWithReturn implements ISignal
   {
      
      private static var log:Log = new Log(SignalWithReturn);
      
      protected var m_valueClasses:Array;
      
      protected var m_lstSlot:Array = [];
      
      protected var m_lstSlotOnce:Array = [];
      
      public function SignalWithReturn(... rest)
      {
         super();
         this.m_valueClasses = rest.length == 1 && rest[0] is Array ? rest[0] : rest;
         var _loc2_:int = int(this.m_valueClasses.length);
         while(_loc2_--)
         {
            if(!(this.m_valueClasses[_loc2_] is Class))
            {
               throw new ArgumentError("无效的 valueClasses 参数: " + "第 " + _loc2_ + " 个参数应该是一个Class, 而不应该是:<" + this.m_valueClasses[_loc2_] + ">." + getQualifiedClassName(this.m_valueClasses[_loc2_]));
            }
         }
      }
      
      public function get numListeners() : uint
      {
         return this.m_lstSlot.length;
      }
      
      public function addOnce(param1:Function) : void
      {
         if(this.m_lstSlotOnce.length > 0)
         {
            log.warn("addOnce","如果有多个回调，则将以最后一个回调的返回值为最终返回值！");
         }
         var _loc2_:int = int(this.m_lstSlotOnce.indexOf(param1));
         if(_loc2_ < 0)
         {
            this.m_lstSlotOnce.push(param1);
         }
      }
      
      public function add(param1:Function) : void
      {
         if(this.m_lstSlotOnce.length > 0)
         {
            log.warn("add","如果有多个回调，则将以最后一个回调的返回值为最终返回值！");
         }
         var _loc2_:int = int(this.m_lstSlot.indexOf(param1));
         if(_loc2_ < 0)
         {
            this.m_lstSlot.push(param1);
         }
      }
      
      public function remove(param1:Function) : void
      {
         var _loc2_:int = int(this.m_lstSlot.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.m_lstSlot.splice(_loc2_,1);
         }
         _loc2_ = int(this.m_lstSlotOnce.indexOf(param1));
         if(_loc2_ >= 0)
         {
            this.m_lstSlotOnce.splice(_loc2_,1);
         }
      }
      
      public function removeAll() : void
      {
         this.m_lstSlot.length = 0;
         this.m_lstSlotOnce.length = 0;
      }
      
      public function dispatch(... rest) : *
      {
         return this.dispatchWorker(rest);
      }
      
      private function dispatchWorker(param1:Array) : *
      {
         var _loc7_:* = undefined;
         var _loc2_:int = int(this.m_valueClasses.length);
         var _loc3_:int = int(param1.length);
         if(_loc3_ < _loc2_)
         {
            throw new ArgumentError("不正确的参数个数： " + "应该至少有 " + _loc2_ + " 个参数，但只收到" + _loc3_ + "个.");
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(!(param1[_loc4_] is this.m_valueClasses[_loc4_] || param1[_loc4_] === null))
            {
               throw new ArgumentError("参数类型错误： object <" + param1[_loc4_] + "> is not an instance of <" + this.m_valueClasses[_loc4_] + ">.");
            }
            _loc4_++;
         }
         var _loc5_:Array = this.m_lstSlot.concat();
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = this.execute(_loc5_[_loc6_],param1);
            _loc6_++;
         }
         _loc5_ = this.m_lstSlotOnce.concat();
         this.m_lstSlotOnce.length = 0;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc7_ = this.execute(_loc5_[_loc6_],param1);
            _loc6_++;
         }
         return _loc7_;
      }
      
      private function execute(param1:Function, param2:Array) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:int = int(param2.length);
         if(_loc4_ == 0)
         {
            _loc3_ = param1();
         }
         else if(_loc4_ == 1)
         {
            _loc3_ = param1(param2[0]);
         }
         else if(_loc4_ == 2)
         {
            _loc3_ = param1(param2[0],param2[1]);
         }
         else if(_loc4_ == 3)
         {
            _loc3_ = param1(param2[0],param2[1],param2[2]);
         }
         else
         {
            _loc3_ = param1.apply(null,param2);
         }
         return _loc3_;
      }
   }
}

