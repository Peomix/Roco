package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.plugs.Login.data.LoginDataBody;
   import com.QQ.angel.plugs.Login.data.LoginDataRepply;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class LoginDataProcessor extends EventDispatcher implements IDataProcessor
   {
      
      private var loginData:LoginDataRepply = new LoginDataRepply();
      
      private var loginADF:ADF = new ADF();
      
      public function LoginDataProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_LoginRoom;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2,param1.uin);
         var _loc4_:LoginDataBody = new LoginDataBody();
         _loc4_.key = param1.key;
         _loc4_.roomID = param1.roomID;
         _loc3_.body = _loc4_;
         return _loc3_;
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         trace("获取到登录返回数据:" + _loc2_.buffLen);
         loginData.read(_loc2_);
         return loginData;
      }
   }
}

