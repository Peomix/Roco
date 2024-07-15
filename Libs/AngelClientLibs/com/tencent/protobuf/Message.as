package com.tencent.protobuf
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class Message extends EventDispatcher implements IMessage, IDataProcessor
   {
       
      
      private var _type:int;
      
      private var _data:ByteArray;
      
      public function Message()
      {
         this._data = new ByteArray();
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         this.readExternal(param1.body);
         this.dispatchEvent(new Event(Event.COMPLETE));
         trace("[Message]decode:",this._type.toString(16));
         return this;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         trace("[Message]encode:",this._type.toString(16));
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = new ByteArray();
         this.writeExternal(_loc3_.body);
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         trace("[Message]:",this._type);
         return this._type;
      }
      
      override public function toString() : String
      {
         return messageToString(this);
      }
      
      public function setADFType(param1:int) : void
      {
         this._type = param1;
      }
      
      public function readFromSlice(param1:IDataInput, param2:uint) : void
      {
         throw new IllegalOperationError("Not implemented.");
      }
      
      final public function readExternal(param1:IDataInput) : void
      {
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
