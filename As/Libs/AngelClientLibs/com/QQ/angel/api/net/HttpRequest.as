package com.QQ.angel.api.net
{
   import com.QQ.angel.api.utils.CFunction;
   
   public class HttpRequest
   {
       
      
      public var id:int;
      
      public var url:String;
      
      public var requestType:int = 0;
      
      public var data:Object;
      
      public var method:String = "POST";
      
      public var callBack:CFunction;
      
      public function HttpRequest()
      {
         super();
      }
   }
}
