package com.QQ.angel.plugs.Login.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class InitialComponentDataProcessor extends EventDispatcher implements IDataProcessor
   {
       
      
      public function InitialComponentDataProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function decode(param1:ADF) : Object
      {
         return null;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return 459012;
      }
   }
}
