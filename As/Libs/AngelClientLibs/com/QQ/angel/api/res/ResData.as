package com.QQ.angel.api.res
{
   import flash.system.ApplicationDomain;
   
   public class ResData
   {
       
      
      public var itemsTotal:int = 0;
      
      public var itemsLoaded:int = 0;
      
      public var bytesTotal:int = 0;
      
      public var bytesLoaded:int = 0;
      
      public var content:*;
      
      public var domain:ApplicationDomain;
      
      public var obj:Object;
      
      public function ResData()
      {
         super();
      }
   }
}
