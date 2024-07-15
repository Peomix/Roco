package com.QQ.angel.net.ProtoNet
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.tencent.protobuf.Message;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class NetProcessor implements IAngelDataInput, IAngelDataOutput
   {
       
      
      private var _cmd:int;
      
      private var _reqBuffer:Message;
      
      private var _rspClass:Class;
      
      public var onsuccess:Function;
      
      public var onerror:Function;
      
      public function NetProcessor(param1:int, param2:Message = null, param3:Class = null)
      {
         super();
         this._cmd = param1;
         this._reqBuffer = param2;
         this._rspClass = param3;
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc2_:Message = null;
         if(this._rspClass != null)
         {
            _loc2_ = new this._rspClass();
            _loc2_.readExternal(param1);
            if(_loc2_)
            {
               this.onsuccess && this.onsuccess(_loc2_);
            }
            else
            {
               this.onerror && this.onerror("系统繁忙，请稍后再试。");
            }
         }
      }
      
      public function write(param1:IDataOutput) : void
      {
         if(this._reqBuffer)
         {
            this._reqBuffer.writeExternal(param1);
         }
      }
      
      public function get length() : uint
      {
         if(this._reqBuffer != null)
         {
            return (this._reqBuffer.encode(null).body as ByteArray).length;
         }
         return 0;
      }
   }
}
