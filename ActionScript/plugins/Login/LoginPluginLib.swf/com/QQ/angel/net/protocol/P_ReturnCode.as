package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class P_ReturnCode implements IExternalizable
   {
      
      public static const OK:int = 0;
      
      public var code:int;
      
      public var message:String = "";
      
      public function P_ReturnCode()
      {
         super();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         this.code = param1.readInt();
         var _loc2_:int = int(param1.readUnsignedShort());
         this.message = param1.readMultiByte(_loc2_,DEFINE.CHARSET);
      }
      
      public function isError() : Boolean
      {
         return this.code != OK;
      }
   }
}

