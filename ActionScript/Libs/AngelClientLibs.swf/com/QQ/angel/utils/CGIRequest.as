package com.QQ.angel.utils
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class CGIRequest extends EventDispatcher
   {
      
      public static const START:String = "start";
      
      public static const STOP:String = "stop";
      
      public static const FINISH:String = "finish";
      
      protected var _loader:URLLoader;
      
      protected var data:XML;
      
      public var isLoading:Boolean;
      
      public function CGIRequest(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      protected function onError(param1:ErrorEvent) : void
      {
      }
      
      public function initialize(param1:URLLoader) : void
      {
         this._loader = param1;
         this._loader.addEventListener(Event.COMPLETE,this.onComplete);
         this._loader.addEventListener(ErrorEvent.ERROR,this.onError);
      }
      
      protected function dispose() : void
      {
         try
         {
            this._loader.close();
         }
         catch(e:Error)
         {
         }
         this._loader.removeEventListener(Event.COMPLETE,this.onComplete);
         this._loader.removeEventListener(ErrorEvent.ERROR,this.onError);
      }
      
      private function onComplete(param1:Event) : void
      {
         this.isLoading = false;
         dispatchEvent(new Event(STOP));
         this.data = new XML(this._loader.data);
         this.onDataArrived(this.data);
      }
      
      protected function onDataArrived(param1:XML) : void
      {
      }
      
      protected function load(param1:String) : void
      {
         if(this._loader == null)
         {
            throw new Error("CGIRequest need to initialize!");
         }
         this.isLoading = true;
         dispatchEvent(new Event(START));
         this._loader.load(new URLRequest(param1));
      }
   }
}

