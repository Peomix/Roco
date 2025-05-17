package com.QQ.angel.plugs.Login.utils
{
   public class SvrNameEngine
   {
      
      private var _data:XML;
      
      public function SvrNameEngine()
      {
         super();
      }
      
      public function initialize(param1:XML) : void
      {
         _data = param1;
      }
      
      public function getNameByID(param1:uint) : String
      {
         var _loc2_:int = int(param1 - 1);
         var _loc3_:XML = _data.Row[_loc2_];
         if(_loc3_)
         {
            if(Number(_loc3_.Cell[0]) == Number(param1))
            {
               return _loc3_.Cell[1].toString();
            }
         }
         return "未知名称";
      }
      
      public function getTotal() : uint
      {
         return _data.Row.length();
      }
   }
}

