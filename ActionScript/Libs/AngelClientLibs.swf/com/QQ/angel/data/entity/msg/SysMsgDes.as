package com.QQ.angel.data.entity.msg
{
   public class SysMsgDes
   {
      
      public static const ALERT:int = 0;
      
      public static const GOT_ITEMS:int = 1;
      
      public static const H_EFFECT:int = 2;
      
      public static const V_EFFECT:int = 3;
      
      public static const GOT_VALUES:int = 4;
      
      public static const CUSTOM:int = 5;
      
      public static const COMM_EFFECT:int = 6;
      
      public var type:int;
      
      public var data:Object;
      
      public function SysMsgDes(param1:int = 0, param2:Object = null)
      {
         super();
         this.type = param1;
         this.data = param2;
      }
   }
}

