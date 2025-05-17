package com.QQ.angel.world.role
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.utils.NewLoader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class TitleIconLoader extends NewLoader
   {
      
      public function TitleIconLoader(param1:Boolean = false, param2:Number = 1)
      {
         super(param1);
         scaleX = scaleY = param2;
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         super.load(param1,param2);
         this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompete);
         this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.ioerr);
      }
      
      public function loadIcon(param1:int) : void
      {
         this.load(new URLRequest(DEFINE.formatFileVersion(DEFINE.COMM_ROOT + "res/titile/" + param1 + ".swf")));
      }
      
      private function loadCompete(param1:Event) : void
      {
         var _loc3_:MovieClip = null;
         (param1.currentTarget as LoaderInfo).removeEventListener(Event.COMPLETE,arguments.callee);
         if((param1.currentTarget as LoaderInfo).loader.content is MovieClip)
         {
            _loc3_ = (param1.currentTarget as LoaderInfo).loader.content as MovieClip;
            _loc3_.x = -(_loc3_.width / 2);
            _loc3_.y = -_loc3_.height;
         }
      }
      
      protected function ioerr(param1:IOErrorEvent) : void
      {
         (param1.currentTarget as LoaderInfo).removeEventListener(Event.COMPLETE,this.loadCompete);
         (param1.currentTarget as LoaderInfo).removeEventListener(IOErrorEvent.IO_ERROR,this.ioerr);
      }
      
      public function dispose() : void
      {
         this.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompete);
         this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.ioerr);
      }
   }
}

