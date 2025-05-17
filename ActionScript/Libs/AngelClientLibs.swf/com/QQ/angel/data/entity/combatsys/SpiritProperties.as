package com.QQ.angel.data.entity.combatsys
{
   public class SpiritProperties
   {
      
      public var pa:int;
      
      public var pd:int;
      
      public var ma:int;
      
      public var md:int;
      
      public var ve:int;
      
      public var sp:int;
      
      public var dp:int;
      
      public var crit:int;
      
      public function SpiritProperties()
      {
         super();
      }
      
      public function toString() : String
      {
         return "pa:" + this.pa + "pd:" + this.pd + "ma:" + this.ma + "md:" + this.md + "ve:" + this.ve + "sp:" + this.sp + "dp:" + this.dp + "crit:" + this.crit;
      }
   }
}

