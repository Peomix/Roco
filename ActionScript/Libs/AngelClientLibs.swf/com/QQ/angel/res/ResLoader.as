package com.QQ.angel.res
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.Loader;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.system.LoaderContext;
   
   public class ResLoader
   {
      
      public static const LOADER:int = 1;
      
      public static const URLSTREAM:int = 2;
      
      private var _type:int;
      
      private var _loader:Loader;
      
      private var _stream:URLStream;
      
      public function ResLoader(param1:int = 1)
      {
         super();
         this._type = param1;
         switch(this._type)
         {
            case LOADER:
               this._loader = new Loader();
               break;
            case URLSTREAM:
               this._stream = new URLStream();
         }
      }
      
      public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         if(param1)
         {
            param1.url = DEFINE.formatFileVersion(param1.url);
         }
         switch(this._type)
         {
            case LOADER:
               this._loader.load(param1,param2);
               break;
            case URLSTREAM:
               this._stream.load(param1);
         }
      }
      
      public function unload() : void
      {
         switch(this._type)
         {
            case LOADER:
               this._loader.unload();
               break;
            case URLSTREAM:
         }
      }
      
      public function get content() : *
      {
         switch(this._type)
         {
            case LOADER:
               return this._loader.content;
            case URLSTREAM:
               return this._stream;
            default:
               return;
         }
      }
      
      public function get type() : int
      {
         return this._type;
      }
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         switch(this._type)
         {
            case LOADER:
               this._loader.contentLoaderInfo.addEventListener(param1,param2,param3,param4,param5);
               break;
            case URLSTREAM:
               this._stream.addEventListener(param1,param2,param3,param4,param5);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         switch(this._type)
         {
            case LOADER:
               this._loader.contentLoaderInfo.removeEventListener(param1,param2,param3);
               break;
            case URLSTREAM:
               this._stream.removeEventListener(param1,param2,param3);
         }
      }
   }
}

