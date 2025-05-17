package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataOutput;
   
   public class P_Struct implements IAngelDataOutput
   {
      
      protected var len:uint = 0;
      
      protected var structs:Array;
      
      public function P_Struct(param1:Array = null)
      {
         super();
         if(param1 != null)
         {
            this.fill(param1);
         }
      }
      
      public function fill(param1:Array) : void
      {
         var _loc3_:IAngelDataOutput = null;
         this.len = 0;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            this.len += _loc3_.length;
            _loc2_++;
         }
         this.structs = param1;
      }
      
      public function write(param1:IDataOutput) : void
      {
         var _loc3_:IAngelDataOutput = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.structs.length)
         {
            _loc3_ = this.structs[_loc2_];
            _loc3_.write(param1);
            _loc2_++;
         }
      }
      
      public function get length() : uint
      {
         return this.len;
      }
   }
}

