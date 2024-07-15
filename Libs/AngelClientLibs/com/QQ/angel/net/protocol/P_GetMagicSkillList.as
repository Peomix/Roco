package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   
   public class P_GetMagicSkillList implements IAngelDataInput
   {
       
      
      public var code:P_ReturnCode;
      
      public var list:Array;
      
      public function P_GetMagicSkillList()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = ProtocolHelper.ReadCode(param1);
         if(this.code.isError())
         {
            return;
         }
         var _loc2_:int = int(param1.readUnsignedShort());
         this.list = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.list.push(this.readMagicSkill(param1));
            _loc3_++;
         }
      }
      
      protected function readMagicSkill(param1:IDataInput) : Object
      {
         var _loc2_:Object = {};
         _loc2_.id = param1.readUnsignedShort();
         _loc2_.useCount = param1.readUnsignedShort();
         return _loc2_;
      }
   }
}
