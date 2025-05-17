package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class Animation extends Sprite
   {
      
      private static var RLTM:IResLoadTaskManager;
      
      protected var task:ResLoadTask;
      
      protected var isLoading:Boolean = false;
      
      protected var src:String = "";
      
      protected var content:DisplayObject;
      
      protected var w:Number;
      
      protected var h:Number;
      
      protected var isFreeSize:Boolean = false;
      
      public function Animation(param1:Number = 0, param2:Number = 0)
      {
         super();
         if(RLTM == null)
         {
            throw new Error("[Image] #########Error此类只能在系统内使用!!");
         }
         this.w = param1;
         this.h = param2;
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
      
      public function set setFreeSize(param1:Boolean) : void
      {
         this.isFreeSize = param1;
      }
      
      public function setPath(param1:String) : void
      {
         if(this.src == param1)
         {
            return;
         }
         this.task.paths[0] = param1;
         this.unload();
         RLTM.addLoadTask(this.task);
         this.isLoading = true;
         this.src = param1;
      }
      
      protected function onImageLoaded(param1:LoadTaskEvent) : void
      {
         this.isLoading = false;
         var _loc2_:ResData = param1.resData;
         if(_loc2_ != null)
         {
            this.content = _loc2_.content as DisplayObject;
            if(this.content)
            {
               if(!this.isFreeSize)
               {
                  this.content.width = this.w;
                  this.content.height = this.h;
               }
               addChild(this.content);
            }
         }
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      protected function onImageLoadedError(param1:LoadTaskEvent) : void
      {
         this.isLoading = false;
         trace("[Animation] " + param1.message);
      }
      
      public function getAnimation() : DisplayObject
      {
         return this.content;
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
            this.content = null;
         }
      }
      
      public function reset() : void
      {
         this.unload();
      }
   }
}

