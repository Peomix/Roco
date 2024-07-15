package com.QQ.angel.net.center
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class FreeRequestProxy implements IAngelDataInput, IAngelDataOutput
   {
       
      
      private var m_inputBuffer:ByteArray;
      
      private var m_outputBuffer:ByteArray;
      
      private var m_protocolHash:Object;
      
      private var m_callbackFunc:Function;
      
      public function FreeRequestProxy(param1:I_C2S_Socket, param2:Object, param3:Function)
      {
         super();
         this.m_callbackFunc = param3;
         this.m_protocolHash = param2;
         this.m_outputBuffer = new ByteArray();
         if(param1)
         {
            param1.writeData(this.m_outputBuffer);
         }
         this.m_outputBuffer.position = 0;
      }
      
      public static function onReqReply(param1:FreeRequestProxy) : void
      {
         param1.onReqReplyLocal();
      }
      
      public function get protocolHash() : int
      {
         return int(this.m_protocolHash);
      }
      
      private function onReqReplyLocal() : void
      {
         var _loc1_:Class = null;
         var _loc2_:ProtocolBase = null;
         if(this.m_inputBuffer)
         {
            if(this.m_callbackFunc != null && this.m_protocolHash != null)
            {
               _loc1_ = NetProtocalCenter.getS2CProtocalClassByHash(this.m_protocolHash);
               if(_loc1_)
               {
                  _loc2_ = new _loc1_() as ProtocolBase;
                  if(_loc2_ is I_S2C_Socket)
                  {
                     I_S2C_Socket(_loc2_).readData(this.m_inputBuffer);
                     this.m_callbackFunc(_loc2_);
                  }
               }
            }
            this.m_callbackFunc = null;
            this.m_inputBuffer = null;
         }
         this.m_protocolHash = null;
      }
      
      public function read(param1:IDataInput) : void
      {
         this.m_inputBuffer = new ByteArray();
         param1.readBytes(this.m_inputBuffer,0,param1.bytesAvailable);
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeBytes(this.m_outputBuffer);
         this.m_outputBuffer = null;
      }
      
      public function get length() : uint
      {
         if(this.m_outputBuffer)
         {
            return this.m_outputBuffer.length;
         }
         return 0;
      }
   }
}
