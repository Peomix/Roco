package com.QQ.angel.res
{
   import com.QQ.angel.utils.NewLoader;
   import flash.events.IEventDispatcher;
   import flash.system.ApplicationDomain;
   
   public class NormalLoader extends NewLoader implements IResLoader
   {
      
      public function NormalLoader()
      {
         super();
      }
      
      public function get type() : int
      {
         return 1;
      }
      
      public function getContent() : *
      {
         return this.content;
      }
      
      public function getED() : IEventDispatcher
      {
         return this;
      }
      
      public function getContentDomain() : ApplicationDomain
      {
         return contentLoaderInfo.applicationDomain;
      }
      
      public function getURL() : String
      {
         return contentLoaderInfo.url;
      }
   }
}

