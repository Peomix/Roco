package com.tencent.protobuf
{
   import flash.errors.IllegalOperationError;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ExtensibleMessage extends Array implements IMessage
   {
       
      
      public function ExtensibleMessage()
      {
         super();
      }
      
      public function toString() : String
      {
         return messageToString(this);
      }
      
      public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         throw new IllegalOperationError("Not implemented.");
      }
      
      final public function readExternal(param1:IDataInput) : void
      {
         param1.endian = Endian.LITTLE_ENDIAN;
         this.readFromSlice(param1,0);
      }
      
      public function writeToBuffer(param1:WritingBuffer) : void
      {
         throw new IllegalOperationError("Not implemented.");
      }
      
      final public function writeExternal(param1:IDataOutput) : void
      {
         var _loc2_:WritingBuffer = new WritingBuffer();
         this.writeToBuffer(_loc2_);
         _loc2_.toNormal(param1);
      }
   }
}
