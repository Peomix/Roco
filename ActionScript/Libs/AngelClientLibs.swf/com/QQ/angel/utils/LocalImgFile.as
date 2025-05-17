package com.QQ.angel.utils
{
   import flash.events.EventDispatcher;
   import flash.system.LoaderContext;
   
   public class LocalImgFile extends EventDispatcher implements ILocalFile
   {
      
      internal static var LIMGQL:CacheLocalImgLoader;
      
      protected var content:Object;
      
      protected var url:String = "";
      
      protected var loadContext:LoaderContext;
      
      protected var isnull:Boolean = false;
      
      public function LocalImgFile(param1:String = "")
      {
         super();
         if(param1 != null)
         {
            this.load(param1);
         }
      }
      
      public static function getCacheLocalImgLoader() : CacheLocalImgLoader
      {
         if(LIMGQL == null)
         {
            LIMGQL = new CacheLocalImgLoader();
         }
         return LIMGQL;
      }
      
      public function getContent() : Object
      {
         return this.content;
      }
      
      public function getURL() : String
      {
         return this.url;
      }
      
      public function onFileOpen(param1:Object) : void
      {
      }
      
      public function onFileLoaded(param1:Object) : void
      {
         this.content = param1;
      }
      
      public function onFileLoadError(param1:String) : void
      {
         trace("LocalFile:" + param1);
      }
      
      public function getContext() : LoaderContext
      {
         return this.loadContext;
      }
      
      public function isNull() : Boolean
      {
         return this.isnull;
      }
      
      public function load(param1:String, param2:LoaderContext = null) : void
      {
         this.url = param1;
         this.loadContext = param2;
         if(LIMGQL == null)
         {
            LIMGQL = new CacheLocalImgLoader();
         }
         LIMGQL.addFile(this);
      }
      
      public function unload(param1:Boolean = false) : void
      {
         this.content = null;
         this.loadContext = null;
         this.isnull = true;
         LIMGQL.removeFile(this);
      }
   }
}

