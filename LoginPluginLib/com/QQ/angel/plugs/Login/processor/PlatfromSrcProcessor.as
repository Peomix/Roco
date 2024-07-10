package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_Char;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class PlatfromSrcProcessor extends EventDispatcher implements IDataProcessor
   {
       
      
      public function PlatfromSrcProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function decode(param1:ADF) : Object
      {
         return null;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = new P_Char(param1 as int);
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return 204836;
      }
   }
}
