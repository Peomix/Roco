package com.tencent.fge.utils
{
   public class ObjectUtil
   {
      
      public function ObjectUtil()
      {
         super();
      }
      
      public static function getObjectMemoryHash(param1:*) : String
      {
         var memoryHash:String = null;
         var arrHash:Array = null;
         var obj:* = param1;
         try
         {
            FakeClass(obj);
         }
         catch(e:Error)
         {
            arrHash = String(e).match(/@[\d\w]+/gi);
            if(Boolean(arrHash) && 0 < arrHash.length)
            {
               memoryHash = arrHash[0];
            }
         }
         return memoryHash;
      }
   }
}

final class FakeClass
{
   
   public function FakeClass()
   {
      super();
   }
}
