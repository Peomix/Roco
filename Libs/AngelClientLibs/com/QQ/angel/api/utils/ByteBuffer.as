package com.QQ.angel.api.utils
{
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class ByteBuffer extends ByteArray
   {
       
      
      protected var limitCapacity:int = -1;
      
      public function ByteBuffer()
      {
         super();
      }
      
      public function allocate(param1:int) : void
      {
         this.limitCapacity = length = param1;
         position = 0;
      }
      
      public function get limit() : int
      {
         return this.limitCapacity;
      }
      
      public function fill(param1:IDataInput) : void
      {
         if(this.limitCapacity != 0)
         {
            param1.readBytes(this,0,this.limitCapacity);
         }
      }
      
      public function copyToByteArray() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         position = 0;
         _loc1_.writeBytes(this);
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public function get buffLen() : int
      {
         if(this.limitCapacity == -1)
         {
            return bytesAvailable;
         }
         return this.limitCapacity - position;
      }
   }
}
