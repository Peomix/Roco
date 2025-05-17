package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.net.INetSystem;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   
   public class P_FreeRequest
   {
      
      private static var __sys:INetSystem;
      
      public var cmdID:int;
      
      public var data:IAngelDataOutput;
      
      public var respondCls:Class;
      
      public var response:IAngelDataInput;
      
      public var serialNum:uint = 0;
      
      public var handler:Function;
      
      public function P_FreeRequest(param1:int = -1, param2:IAngelDataOutput = null, param3:* = null, param4:Function = null)
      {
         super();
         this.cmdID = param1;
         this.data = param2;
         this.handler = param4;
         if(param3 is Class)
         {
            this.respondCls = param3;
         }
         else
         {
            this.response = param3;
         }
      }
      
      public static function setNetSys(param1:INetSystem) : void
      {
         if(param1 == null)
         {
            return;
         }
         __sys = param1;
      }
      
      public function send(param1:Boolean = false, param2:int = -1) : uint
      {
         if(__sys == null)
         {
            trace("[P_FreeRequest] 网络系统为空发送失败!");
            return 0;
         }
         if(this.cmdID == -1)
         {
            trace("[P_FreeRequest] 命令字错误发送失败!");
            return 0;
         }
         return __sys.trySendData(this.cmdID,this,param1,param2);
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:Object = null;
         var _loc4_:IAngelDataInput = null;
         var _loc3_:IDataInput = param1.body as IDataInput;
         if(this.respondCls != null)
         {
            _loc4_ = new this.respondCls() as IAngelDataInput;
            _loc4_.read(_loc3_);
            _loc2_ = _loc4_;
         }
         else if(this.response != null)
         {
            this.response.read(_loc3_);
            _loc2_ = this.response;
         }
         else
         {
            _loc2_ = _loc3_;
         }
         if(this.handler != null)
         {
            this.handler(_loc2_);
            param1.head = null;
         }
         return _loc2_;
      }
      
      public function encode(param1:int = -1) : ADF
      {
         var _loc2_:ADF = ProtocolHelper.CreateADF(param1);
         _loc2_.head.uiSerialNum = this.serialNum;
         _loc2_.body = this.data;
         return _loc2_;
      }
   }
}

