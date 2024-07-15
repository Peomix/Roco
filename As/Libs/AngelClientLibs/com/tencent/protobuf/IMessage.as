package com.tencent.protobuf
{
   import flash.utils.IDataInput;
   
   internal interface IMessage
   {
       
      
      function readFromSlice(param1:IDataInput, param2:uint) : void;
      
      function writeToBuffer(param1:WritingBuffer) : void;
   }
}
