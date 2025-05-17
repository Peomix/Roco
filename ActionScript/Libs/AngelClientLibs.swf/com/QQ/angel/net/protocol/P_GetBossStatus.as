package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import flash.utils.IDataInput;
   
   public class P_GetBossStatus implements IAngelDataInput
   {
      
      public var code:int;
      
      public var braveMode:uint;
      
      public var heroMode:uint;
      
      public var awardStatus:uint;
      
      public function P_GetBossStatus()
      {
         super();
      }
      
      public function read(param1:IDataInput) : void
      {
         this.code = param1.readInt();
         if(this.code != 0)
         {
            return;
         }
         this.braveMode = param1.readUnsignedInt();
         this.heroMode = param1.readUnsignedInt();
         this.awardStatus = param1.readUnsignedInt();
      }
      
      public function isBossHadChallenged(param1:int) : Boolean
      {
         var _loc2_:uint = 1;
         if(param1 == 0)
         {
            param1 == 1;
         }
         _loc2_ <<= param1 - 1;
         return (_loc2_ & this.heroMode) != 0;
      }
      
      public function isAwardHadOpen(param1:int) : Boolean
      {
         var _loc2_:uint = 1;
         if(param1 == 0)
         {
            param1 == 1;
         }
         _loc2_ <<= (param1 - 1) * 2;
         return (_loc2_ & this.awardStatus) != 0;
      }
      
      public function isAwardHadGot(param1:int) : Boolean
      {
         var _loc2_:uint = 2;
         if(param1 == 0)
         {
            param1 == 1;
         }
         _loc2_ <<= (param1 - 1) * 2;
         return (_loc2_ & this.awardStatus) != 0;
      }
   }
}

