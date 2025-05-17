package com.QQ.angel.world.script.func
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeProtoB implements IInvokeFunc
   {
      
      protected var mGlobal:Object;
      
      protected var mHandle:Function;
      
      private var attribute:String;
      
      public function InvokeProtoB()
      {
         super();
      }
      
      public function setGlobal(param1:Object) : void
      {
         this.mGlobal = param1;
      }
      
      public function onData(param1:Object) : void
      {
         this.mGlobal["msg"] = param1.retCode.message;
         this.mHandle(param1[this.attribute]);
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         var _loc3_:Array = param1.split("|");
         this.attribute = _loc3_[1];
         var _loc4_:int = int(_loc3_[0]);
         this.mHandle = param2;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL_BY_ID,[_loc4_,this.onData]);
      }
      
      public function dispose() : void
      {
         this.mGlobal = null;
         this.mHandle = null;
      }
   }
}

