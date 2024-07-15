package com.QQ.angel.api.net
{
   import com.QQ.angel.api.net.protocol.ADF;
   
   public interface IDataProcessor
   {
       
      
      function decode(param1:ADF) : Object;
      
      function encode(param1:Object, param2:int = -1) : ADF;
      
      function getADFType() : int;
   }
}
