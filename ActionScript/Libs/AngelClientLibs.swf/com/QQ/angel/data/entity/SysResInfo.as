package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.system.LoaderContext;
   
   public class SysResInfo
   {
      
      public var context:LoaderContext;
      
      public var contents:Array;
      
      public var callBack:CFunction;
      
      public var loadingViewType:int;
      
      public var title:String;
      
      public var label:String;
      
      public function SysResInfo()
      {
         super();
      }
      
      public function reset() : void
      {
         this.contents = null;
         this.callBack = null;
         this.loadingViewType = -1;
         this.title = "";
         this.label = "";
      }
   }
}

