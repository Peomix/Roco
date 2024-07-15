package com.QQ.angel.ui.core
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   
   public class DefaultImgCache implements IImageCache
   {
       
      
      protected var imgsDict:Dictionary;
      
      public function DefaultImgCache()
      {
         super();
         this.imgsDict = new Dictionary();
      }
      
      public function save(param1:String, param2:BitmapData) : BitmapData
      {
         var _loc3_:BitmapData = this.imgsDict[param1];
         trace("[DefaultImgCache] save ",param1,param2,_loc3_);
         if(_loc3_ != null)
         {
            param2.dispose();
         }
         else
         {
            this.imgsDict[param1] = _loc3_ = param2;
         }
         return _loc3_;
      }
      
      public function find(param1:String) : BitmapData
      {
         return this.imgsDict[param1];
      }
      
      public function disposeImage(param1:String) : void
      {
         var _loc2_:BitmapData = this.imgsDict[param1];
         if(_loc2_ != null)
         {
            _loc2_.dispose();
         }
         delete this.imgsDict[param1];
      }
      
      public function compareAndDispose(param1:Array) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in this.imgsDict)
         {
            if(param1.indexOf(_loc2_) == -1)
            {
               this.disposeImage(_loc2_);
            }
         }
      }
      
      public function disposeAll() : void
      {
         var _loc1_:String = null;
         var _loc2_:BitmapData = null;
         for(_loc1_ in this.imgsDict)
         {
            _loc2_ = this.imgsDict[_loc1_];
            if(_loc2_ != null)
            {
               _loc2_.dispose();
            }
         }
         this.imgsDict = null;
      }
   }
}
