package com.QQ.angel.data.entity.combatsys.utils
{
   public class CombatResConvert
   {
       
      
      public function CombatResConvert()
      {
         super();
      }
      
      public static function addBidToEid(param1:int) : int
      {
         return 10000 + param1;
      }
      
      public static function addEidToBid(param1:int) : int
      {
         return Math.abs(param1) - 10000;
      }
      
      public static function delBidToEid(param1:int) : int
      {
         return 20000 + param1;
      }
      
      public static function delEidToBid(param1:int) : int
      {
         return Math.abs(param1) - 20000;
      }
      
      public static function convertToBuffId(param1:int) : int
      {
         if(param1 >= 20000)
         {
            return delEidToBid(param1) * -1;
         }
         return addEidToBid(param1);
      }
      
      public static function buffIdToIconId(param1:int) : int
      {
         return 100 + param1;
      }
   }
}
