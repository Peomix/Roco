package com.QQ.angel.ui.core
{
   import flash.display.BitmapData;
   
   public interface IImageCache
   {
      
      function save(param1:String, param2:BitmapData) : BitmapData;
      
      function find(param1:String) : BitmapData;
      
      function disposeImage(param1:String) : void;
      
      function compareAndDispose(param1:Array) : void;
      
      function disposeAll() : void;
   }
}

