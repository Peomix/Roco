package com.QQ.angel.api.net.protocol
{
   import flash.errors.IllegalOperationError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class ADF implements IExternalizable
   {
      
      public var head:ADFHead;
      
      public var body:*;
      
      public function ADF()
      {
         super();
         this.head = new ADFHead();
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.head.readExternal(param1);
         var _loc2_:ByteArray = new ByteArray();
         param1.readBytes(_loc2_,0,this.head.length);
         this.body = _loc2_;
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:IAngelDataOutput = null;
         if(this.body != null)
         {
            if(this.body is ByteArray)
            {
               _loc2_ = this.body as ByteArray;
            }
            else
            {
               if(this.body is IAngelDataOutput)
               {
                  _loc3_ = this.body as IAngelDataOutput;
                  this.head.length = _loc3_.length;
                  this.head.writeExternal(param1);
                  _loc3_.write(param1);
                  return;
               }
               if(!(this.body is IExternalizable))
               {
                  throw new IllegalOperationError("ADF对此" + String(this.body) + "的读写不支持!");
               }
               _loc2_ = new ByteArray();
               (this.body as IExternalizable).writeExternal(_loc2_);
            }
         }
         if(_loc2_ != null)
         {
            this.head.length = _loc2_.length;
            this.head.writeExternal(param1);
            param1.writeBytes(_loc2_);
         }
         else
         {
            this.head.length = 0;
            this.head.writeExternal(param1);
         }
      }
   }
}

