package com.QQ.angel.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   
   public class CacheLocalImgLoader extends Loader
   {
      
      protected var files:Array = [];
      
      protected var loader:Loader;
      
      protected var isLoading:Boolean = false;
      
      protected var currFiles:Array;
      
      protected var currURL:String;
      
      protected var localImgCache:Dictionary;
      
      protected var localImgClassCache:Dictionary;
      
      public function CacheLocalImgLoader()
      {
         super();
         this.localImgCache = new Dictionary();
         this.localImgClassCache = new Dictionary();
         this.loader = new Loader();
         this.loader.contentLoaderInfo.addEventListener(Event.OPEN,this.openHandler);
         this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandler);
      }
      
      public function addLocalImgClass(param1:String, param2:Class) : void
      {
         if(param2 == null || param1 == "")
         {
            return;
         }
         this.localImgClassCache[param1] = param2;
      }
      
      public function addFile(param1:ILocalFile) : void
      {
         if(param1 == null || this.files.indexOf(param1) != -1)
         {
            return;
         }
         var _loc2_:String = param1.getURL();
         var _loc3_:ImgCacheItem = this.localImgCache[_loc2_];
         if(_loc3_ != null)
         {
            ++_loc3_.counts;
            param1.onFileLoaded(_loc3_.content);
            return;
         }
         var _loc4_:Class = this.localImgClassCache[_loc2_] as Class;
         if(_loc4_ != null)
         {
            _loc3_ = this.localImgCache[_loc2_] = new ImgCacheItem(null,1);
            _loc3_.content = new _loc4_();
            param1.onFileLoaded(_loc3_.content);
            return;
         }
         var _loc5_:Array = this.findFileIn(_loc2_);
         if(_loc5_ == null)
         {
            this.files.push([param1]);
         }
         else
         {
            _loc5_.push(param1);
         }
         this.nextLoadFile();
      }
      
      public function removeFile(param1:ILocalFile) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Array = this.findFileIn(param1.getURL());
         if(_loc2_ != null)
         {
            _loc3_ = int(_loc2_.indexOf(param1));
            if(_loc3_ != -1)
            {
               _loc2_.splice(_loc3_,1);
            }
         }
         else
         {
            this.deleteCache(param1);
         }
      }
      
      protected function deleteCache(param1:ILocalFile) : void
      {
         var _loc2_:String = param1.getURL();
         var _loc3_:ImgCacheItem = this.localImgCache[_loc2_];
         if(_loc3_ != null)
         {
            --_loc3_.counts;
            if(_loc3_.counts <= 0 && _loc3_.isStatic == false)
            {
               if(_loc3_.content is Bitmap)
               {
                  (_loc3_.content as Bitmap).bitmapData.dispose();
               }
               else if(_loc3_.content is BitmapData)
               {
                  (_loc3_.content as BitmapData).dispose();
               }
               delete this.localImgCache[_loc2_];
            }
         }
      }
      
      protected function findFileIn(param1:String) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:ILocalFile = null;
         if(param1 == this.currURL)
         {
            return this.currFiles;
         }
         var _loc2_:int = 0;
         while(_loc2_ < this.files.length)
         {
            _loc3_ = this.files[_loc2_];
            _loc4_ = _loc3_[0];
            if(_loc4_.getURL() == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      protected function openHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.currFiles.length)
         {
            (this.currFiles[_loc2_] as ILocalFile).onFileOpen(this.loader.content);
            _loc2_++;
         }
      }
      
      protected function errorHandler(param1:IOErrorEvent) : void
      {
         var i:int = 0;
         var event:IOErrorEvent = param1;
         try
         {
            i = 0;
            while(i < this.currFiles.length)
            {
               (this.currFiles[i] as ILocalFile).onFileLoadError(event.text);
               i++;
            }
            this.loader.unload();
         }
         catch(error:Error)
         {
            trace("LocalFileQueueLoader 调用 errorHandler" + error.message);
         }
         this.currFiles = null;
         this.currURL = "";
         this.isLoading = false;
         this.nextLoadFile();
      }
      
      protected function completeHandler(param1:Event) : void
      {
         var _loc2_:Object = this.loader.content;
         this.loader.unload();
         var _loc3_:ImgCacheItem = this.localImgCache[this.currURL] = new ImgCacheItem(_loc2_,0);
         var _loc4_:int = 0;
         while(_loc4_ < this.currFiles.length)
         {
            (this.currFiles[_loc4_] as ILocalFile).onFileLoaded(_loc2_);
            ++_loc3_.counts;
            _loc4_++;
         }
         this.currFiles = null;
         this.currURL = "";
         this.isLoading = false;
         this.nextLoadFile();
      }
      
      protected function nextLoadFile() : void
      {
         if(this.isLoading)
         {
            return;
         }
         if(this.files.length == 0)
         {
            return;
         }
         this.currFiles = this.files.shift() as Array;
         if(this.currFiles == null || this.currFiles.length == 0)
         {
            this.currFiles = null;
            this.nextLoadFile();
            return;
         }
         this.currURL = this.currFiles[0].getURL();
         this.loader.load(new URLRequest(this.currURL),this.currFiles[0].getContext());
         this.isLoading = true;
      }
   }
}

