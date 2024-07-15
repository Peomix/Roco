package com.QQ.angel.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.system.LoaderContext;
   
   public class LocalFile extends Sprite implements ILocalFile
   {
      
      internal static var LFQL:LocalFileQueueLoader;
       
      
      protected var content:Object;
      
      protected var url:String = "";
      
      protected var loadContext:LoaderContext;
      
      protected var isnull:Boolean = false;
      
      public function LocalFile(param1:String = "")
      {
         super();
         if(param1 != null || param1 != "")
         {
            this.load(param1);
         }
      }
      
      public static function STOPContainer(param1:DisplayObjectContainer) : void
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:MovieClip = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:int = param1.numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = param1.getChildAt(_loc3_) as DisplayObjectContainer) != null)
            {
               if((_loc5_ = _loc4_ as MovieClip) != null)
               {
                  _loc5_.stop();
               }
               STOPContainer(_loc4_);
            }
            _loc3_++;
         }
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
         addChild(this.content as DisplayObject);
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
         if(LFQL == null)
         {
            LFQL = new LocalFileQueueLoader();
         }
         LFQL.addFile(this);
      }
      
      public function unload() : void
      {
         var _loc1_:DisplayObject = this.content as DisplayObject;
         if(_loc1_ != null)
         {
            this.contains(_loc1_);
            this.removeChild(_loc1_);
         }
         this.content = null;
         this.loadContext = null;
         this.isnull = true;
      }
   }
}
