package com.QQ.angel.api.res
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.system.LoaderContext;
   
   public class ResLoadTask
   {
       
      
      public var taskID:int;
      
      public var priority:String = "medium";
      
      public var resType:String = "";
      
      public var paths:Array;
      
      public var context:LoaderContext;
      
      public var startLoadingTime:int;
      
      public var progressHandler:CFunction;
      
      public var openHandler:CFunction;
      
      public var errorHandler:CFunction;
      
      public var completeHandler:CFunction;
      
      public var allCompleteHandler:CFunction;
      
      public function ResLoadTask()
      {
         super();
      }
   }
}
