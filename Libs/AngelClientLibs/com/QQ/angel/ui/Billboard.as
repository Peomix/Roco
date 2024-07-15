package com.QQ.angel.ui
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class Billboard extends Loader
   {
      
      public static var src:String;
       
      
      protected var mv:MovieClip;
      
      protected var mvBar:MovieClip;
      
      public function Billboard()
      {
         super();
         this.build();
      }
      
      protected function build() : void
      {
         contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadedComplete);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadedError);
         load(new URLRequest(DEFINE.formatFileVersion(src)));
      }
      
      protected function onLoadedError(param1:IOErrorEvent) : void
      {
         trace("[Billboard] 广播条加载失败!");
      }
      
      protected function onLoadedComplete(param1:Event) : void
      {
         this.mv = content as MovieClip;
         this.mvBar = this.mv.getChildByName("bar") as MovieClip;
         this.setProgress(1);
      }
      
      public function setProgress(param1:Number) : void
      {
         if(this.mvBar != null)
         {
            this.mvBar.gotoAndStop(param1);
         }
      }
      
      public function active() : void
      {
         if(this.mv != null)
         {
            this.mv.play();
         }
      }
      
      public function deactive() : void
      {
         if(this.mv != null)
         {
            this.mv.stop();
         }
      }
   }
}
