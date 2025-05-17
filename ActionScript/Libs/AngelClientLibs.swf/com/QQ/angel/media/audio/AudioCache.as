package com.QQ.angel.media.audio
{
   import com.QQ.angel.api.res.ResData;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class AudioCache
   {
      
      private var _dict:Dictionary;
      
      private var _cacheSeconds:int;
      
      private var _timer:AudioTimer;
      
      public function AudioCache(param1:int = 10)
      {
         super();
         this._dict = new Dictionary();
         this._cacheSeconds = param1;
         this._timer = new AudioTimer(this.onGC);
         this._timer.delay = param1 + 1;
         if(this._cacheSeconds > 0)
         {
            this._timer.start();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:Object = null;
         if(this._dict != null)
         {
            for(_loc1_ in this._dict)
            {
               delete this._dict[_loc1_];
            }
            this._dict = null;
         }
         if(this._timer != null)
         {
            this._timer.dispose();
            this._timer = null;
         }
      }
      
      public function add(param1:String, param2:*) : void
      {
         if(this._cacheSeconds <= 0)
         {
            return;
         }
         var _loc3_:Object = new Object();
         _loc3_.creationTime = getTimer();
         _loc3_.data = param2;
         this._dict[param1] = _loc3_;
      }
      
      public function remove(param1:String) : void
      {
         if(this._dict[param1] != null)
         {
            delete this._dict[param1];
         }
      }
      
      public function getCache(param1:String) : ResData
      {
         if(this._dict[param1] != null)
         {
            return this._dict[param1].data as ResData;
         }
         return null;
      }
      
      private function onGC() : void
      {
         var _loc1_:Object = null;
         for(_loc1_ in this._dict)
         {
            if(this._dict[_loc1_] != null && getTimer() - this._dict[_loc1_].creationTime > this._cacheSeconds * 1000)
            {
               delete this._dict[_loc1_];
            }
         }
      }
   }
}

