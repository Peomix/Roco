package com.QQ.angel.utils
{
   public class ImgCacheItem
   {
       
      
      public var content:Object;
      
      public var counts:int;
      
      public var isStatic:Boolean = false;
      
      public function ImgCacheItem(param1:Object, param2:int = 1)
      {
         super();
         this.content = param1;
         this.counts = param2;
      }
   }
}
