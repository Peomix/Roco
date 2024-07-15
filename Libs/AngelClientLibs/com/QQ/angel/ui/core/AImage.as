package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class AImage extends Sprite
   {
      
      private static var RLTM:IResLoadTaskManager;
       
      
      protected var content:Bitmap;
      
      protected var task:ResLoadTask;
      
      protected var isLoading:Boolean = false;
      
      protected var imgSize:Point;
      
      protected var imgGC:Boolean = true;
      
      protected var cachePath:Boolean = false;
      
      protected var src:String = "";
      
      protected var imgCache:IImageCache;
      
      public function AImage(param1:Number = 0, param2:Number = 0, param3:Boolean = false)
      {
         super();
         if(RLTM == null)
         {
            throw new Error("[Image] #########Error此类只能在系统内使用!!");
         }
         this.imgSize = new Point(param1,param2);
         this.cachePath = param3;
         this.task = new ResLoadTask();
         this.task.resType = Constants.SMALL_RES;
         this.task.paths = [""];
         this.task.completeHandler = new CFunction(this.onImageLoaded,this);
         this.task.errorHandler = new CFunction(this.onImageLoadedError,this);
      }
      
      public static function setRLTM(param1:IResLoadTaskManager) : void
      {
         if(RLTM != null || param1 == null)
         {
            return;
         }
         RLTM = param1;
      }
      
      protected function addImage(param1:Bitmap) : void
      {
         this.content = param1;
         if(this.imgSize.x > 0)
         {
            this.content.width = this.imgSize.x;
         }
         if(this.imgSize.y > 0)
         {
            this.content.height = this.imgSize.y;
         }
         this.content.smoothing = true;
         addChild(this.content);
      }
      
      protected function onImageLoaded(param1:LoadTaskEvent) : void
      {
         var _loc3_:Bitmap = null;
         this.isLoading = false;
         var _loc2_:ResData = param1.resData;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.content as Bitmap;
            if(_loc3_ != null)
            {
               if(this.imgCache != null)
               {
                  _loc3_.bitmapData = this.imgCache.save(this.src,_loc3_.bitmapData);
               }
               this.addImage(_loc3_);
            }
            else
            {
               trace("[Image] " + this.task.paths[0] + "非图片类型!");
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function onImageLoadedError(param1:LoadTaskEvent) : void
      {
         this.isLoading = false;
         trace("[Image] " + param1.message);
      }
      
      public function setImageCache(param1:IImageCache) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(this.imgCache != null)
         {
            throw new Error("[AImage] 已经存在一个缓存!");
         }
         this.imgCache = param1;
         this.imgGC = false;
      }
      
      public function getImage() : Bitmap
      {
         return this.content;
      }
      
      public function setPath(param1:String) : void
      {
         var _loc2_:BitmapData = null;
         if(this.cachePath && this.src == param1)
         {
            return;
         }
         this.task.paths[0] = param1;
         if(this.imgCache != null)
         {
            _loc2_ = this.imgCache.find(param1);
            if(_loc2_ != null)
            {
               this.setSource(_loc2_);
               this.src = param1;
               return;
            }
         }
         this.unload();
         RLTM.addLoadTask(this.task);
         this.isLoading = true;
         this.src = param1;
      }
      
      public function setSource(param1:*) : void
      {
         this.unload();
         if(param1 is Bitmap)
         {
            this.addImage(param1 as Bitmap);
         }
         else if(param1 is BitmapData)
         {
            this.addImage(new Bitmap(param1 as BitmapData));
         }
         else
         {
            trace("[Image] " + this.task.paths[0] + "非图片类型!");
         }
      }
      
      public function unload() : void
      {
         this.src = "";
         if(this.isLoading)
         {
            RLTM.delLoadTask(this.task);
            this.isLoading = false;
         }
         if(this.content != null)
         {
            if(contains(this.content))
            {
               removeChild(this.content);
            }
            if(this.content.bitmapData != null && this.imgGC)
            {
               this.content.bitmapData.dispose();
            }
            this.content.bitmapData = null;
            this.content = null;
         }
      }
      
      public function reset() : void
      {
         this.unload();
         this.imgCache = null;
         this.imgGC = true;
      }
   }
}
