package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_GetBossAward implements IAngelDataInput, IAngelDataOutput
   {
      
      public var code:int;
      
      public var list:Array;
      
      private var awardIndex:int;
      
      public var msg:String;
      
      public function P_GetBossAward(param1:int = 0)
      {
         super();
         this.awardIndex = param1;
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeUnsignedInt(this.awardIndex);
      }
      
      public function get length() : uint
      {
         return 4;
      }
      
      public function read(param1:IDataInput) : void
      {
         var _loc3_:Object = null;
         this.code = param1.readInt();
         this.msg = DEFINE.ReadChars(param1,param1.readUnsignedShort());
         if(this.code != 0)
         {
            return;
         }
         var _loc2_:int = int(param1.readUnsignedShort());
         this.list = [];
         while(_loc2_-- > 0)
         {
            _loc3_ = {};
            _loc3_.id = param1.readUnsignedInt();
            _loc3_.count = param1.readUnsignedShort();
            this.list.push(_loc3_);
         }
      }
   }
}

