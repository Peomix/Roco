package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import flash.utils.IDataInput;
   
   public class FreeRequestP implements IDataProcessor
   {
       
      
      public var serialNum:uint = 0;
      
      public var request:P_FreeRequest;
      
      public function FreeRequestP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:IAngelDataInput = new this.request.respondCls() as IAngelDataInput;
         _loc2_.read(param1.body as IDataInput);
         return _loc2_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         this.request = param1 as P_FreeRequest;
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = this.request.data;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return 0;
      }
   }
}
