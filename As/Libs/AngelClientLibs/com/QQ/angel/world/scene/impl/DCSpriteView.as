package com.QQ.angel.world.scene.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.LoadTaskEvent;
   import com.QQ.angel.api.res.IResLoadTaskManager;
   import com.QQ.angel.api.res.ResLoadTask;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.api.world.scene.IElementView;
   import com.QQ.angel.utils.LocalFile;
   import com.QQ.angel.world.scene.IDCreateView;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class DCSpriteView extends Sprite implements IDCreateView, IElementView
   {
      
      public static var RLTM:IResLoadTaskManager;
      
      public static var RESTYPE:String = Constants.SCENE_RES;
      
      public static var READY:int = 0;
      
      public static var LOADING:int = 1;
      
      public static var LOADED:int = 2;
       
      
      protected var locXY:Point;
      
      protected var path:String;
      
      protected var loadTask:ResLoadTask;
      
      protected var content:DisplayObject;
      
      protected var mustRender:Boolean = false;
      
      protected var lazy:Boolean = false;
      
      protected var state:int;
      
      public function DCSpriteView()
      {
         this.state = READY;
         super();
         mouseEnabled = false;
         mouseChildren = false;
         this.locXY = new Point();
      }
      
      public function load(param1:String = "") : void
      {
         if(param1 != "")
         {
            this.path = param1;
         }
         if(this.path == null || this.path == "" || this.state > READY)
         {
            return;
         }
         if(RLTM == null)
         {
            throw new Error("DCSpriteView只能在系统内部使用!!");
         }
         this.loadTask = new ResLoadTask();
         this.loadTask.resType = RESTYPE;
         this.loadTask.allCompleteHandler = new CFunction(this.onLoadComplete,this);
         this.loadTask.paths = [this.path];
         RLTM.addLoadTask(this.loadTask);
         this.state = LOADING;
      }
      
      protected function onLoadComplete(param1:LoadTaskEvent, param2:DisplayObject = null) : void
      {
         if(param1 != null)
         {
            this.content = param1.resData.content as DisplayObject;
         }
         else
         {
            this.content = param2;
         }
         if(this.content != null)
         {
            addChildAt(this.content,0);
         }
         this.loadTask = null;
         this.state = LOADED;
      }
      
      protected function disposeObj(param1:DisplayObject) : void
      {
         var _loc2_:BitmapData = null;
         if(param1.hasOwnProperty("dispose"))
         {
            param1["dispose"]();
         }
         else if(param1 is Bitmap)
         {
            _loc2_ = (param1 as Bitmap).bitmapData;
            if(_loc2_ != null)
            {
               _loc2_.dispose();
               (param1 as Bitmap).bitmapData = null;
            }
         }
         else if(param1 is DisplayObjectContainer)
         {
            LocalFile.STOPContainer(param1 as DisplayObjectContainer);
         }
      }
      
      public function setXYLocation(param1:Number, param2:Number) : void
      {
         this.locXY.x = param1;
         this.locXY.y = param2;
         this.x = int(param1 + 0.5);
         this.y = int(param2 + 0.5);
      }
      
      public function onRender(param1:Event) : void
      {
      }
      
      public function setPath(param1:String) : void
      {
         this.path = param1;
      }
      
      public function setLazyLoad(param1:Boolean) : void
      {
         this.lazy = param1;
      }
      
      public function hasRender() : Boolean
      {
         return this.mustRender;
      }
      
      public function getLocation() : Point
      {
         return this.locXY.clone();
      }
      
      public function setLocation(param1:Point) : void
      {
         this.setXYLocation(param1.x,param1.y);
      }
      
      public function get display() : DisplayObject
      {
         return this;
      }
      
      public function unload() : void
      {
         if(this.loadTask != null)
         {
            RLTM.delLoadTask(this.loadTask);
            this.loadTask.completeHandler = null;
            this.loadTask.paths = null;
            this.loadTask = null;
         }
         if(this.content != null)
         {
            removeChild(this.content);
            this.disposeObj(this.content);
         }
         this.state = READY;
      }
   }
}
