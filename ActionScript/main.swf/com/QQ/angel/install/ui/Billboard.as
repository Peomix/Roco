package com.QQ.angel.install.ui
{
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class Billboard extends Sprite
   {
      
      public static var src:String;
      
      protected static var mv:MovieClip;
      
      protected static var mvBar:MovieClip;
      
      protected var loader:Loader;
      
      public function Billboard()
      {
         super();
         build();
      }
      
      protected function onLoadedError(param1:IOErrorEvent) : void
      {
         trace("[Billboard] 广播条加载失败!");
      }
      
      public function active() : void
      {
         if(mv != null)
         {
            mv.play();
            if(!contains(mv))
            {
               addChild(mv);
            }
         }
      }
      
      public function deactive() : void
      {
         if(mv != null)
         {
            mv.stop();
            if(contains(mv))
            {
               removeChild(mv);
            }
         }
      }
      
      protected function onLoadedComplete(param1:Event) : void
      {
         mv = loader.content as MovieClip;
         mvBar = mv.getChildByName("bar") as MovieClip;
         loader.unload();
         setProgress(1);
         active();
      }
      
      protected function build() : void
      {
         if(mv == null)
         {
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadedComplete);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onLoadedError);
            loader.load(new URLRequest(src));
         }
      }
      
      public function setProgress(param1:Number) : void
      {
         if(mvBar != null)
         {
            mvBar.gotoAndStop(param1);
         }
      }
   }
}

