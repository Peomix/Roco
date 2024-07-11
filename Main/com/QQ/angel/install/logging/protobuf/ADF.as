package com.QQ.angel.install.logging.protobuf
{
   import flash.errors.IllegalOperationError;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class ADF implements IExternalizable
   {
      
      public static var USERUIN:uint = 0;
       
      
      public var head:ADFHead;
      
      public var body:*;
      
      public function ADF()
      {
         super();
         head = new ADFHead();
      }
      
      public static function CreateADF(param1:int, param2:uint = 0) : ADF
      {
         var _loc3_:ADF = new ADF();
         _loc3_.head.cmdID = param1;
         if(param2 != 0)
         {
            _loc3_.head.uin = param2;
         }
         else
         {
            _loc3_.head.uin = USERUIN;
         }
         return _loc3_;
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         head.readExternal(param1);
         var _loc2_:ByteArray = new ByteArray();
         param1.readBytes(_loc2_,0,head.length);
         body = _loc2_;
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         var _loc2_:ByteArray = null;
         if(body != null)
         {
            if(body is ByteArray)
            {
               _loc2_ = body as ByteArray;
            }
            else
            {
               if(!(body is IExternalizable))
               {
                  throw new IllegalOperationError("ADF对此" + String(body) + "的读写不支持!");
               }
               _loc2_ = new ByteArray();
               (body as IExternalizable).writeExternal(_loc2_);
            }
         }
         if(_loc2_ != null)
         {
            head.length = _loc2_.length;
            head.writeExternal(param1);
            param1.writeBytes(_loc2_);
         }
         else
         {
            head.length = 0;
            head.writeExternal(param1);
         }
      }
   }
}
