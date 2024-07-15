package com.QQ.angel.utils
{
   import flash.utils.Dictionary;
   
   public class CustomEventDispatcher
   {
       
      
      private var mEventListeners:Dictionary;
      
      public function CustomEventDispatcher()
      {
         super();
      }
      
      public function addEventListener(param1:String, param2:Function) : void
      {
         if(this.mEventListeners == null)
         {
            this.mEventListeners = new Dictionary();
         }
         var _loc3_:Array = this.mEventListeners[param1] as Array;
         if(_loc3_ == null)
         {
            this.mEventListeners[param1] = [param2];
         }
         else if(_loc3_.indexOf(param2) == -1)
         {
            _loc3_.push(param2);
         }
      }
      
      public function removeEventListener(param1:String, param2:Function) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         if(this.mEventListeners)
         {
            _loc3_ = this.mEventListeners[param1] as Array;
            if(_loc3_)
            {
               _loc4_ = int(_loc3_.length);
               _loc5_ = [];
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  if(_loc3_[_loc6_] != param2)
                  {
                     _loc5_.push(_loc3_[_loc6_]);
                  }
                  _loc6_++;
               }
               this.mEventListeners[param1] = _loc5_;
            }
         }
      }
      
      public function removeEventListeners(param1:String = null) : void
      {
         if(Boolean(param1) && Boolean(this.mEventListeners))
         {
            delete this.mEventListeners[param1];
         }
         else
         {
            this.mEventListeners = null;
         }
      }
      
      public function dispatchEvent(param1:String, param2:*) : void
      {
         if(this.mEventListeners == null || !(param1 in this.mEventListeners))
         {
            return;
         }
         this.invokeEvent(param1,param2);
      }
      
      internal function invokeEvent(param1:String, param2:*) : void
      {
         var _loc5_:int = 0;
         var _loc6_:Function = null;
         var _loc7_:int = 0;
         var _loc3_:Array = !!this.mEventListeners ? this.mEventListeners[param1] as Array : null;
         var _loc4_:int;
         if(_loc4_ = _loc3_ == null ? 0 : int(_loc3_.length))
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if((_loc7_ = (_loc6_ = _loc3_[_loc5_] as Function).length) == 0)
               {
                  _loc6_();
               }
               else
               {
                  if(_loc7_ != 1)
                  {
                     throw new Error();
                  }
                  _loc6_(param2);
               }
               _loc5_++;
            }
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         var _loc2_:Array = !!this.mEventListeners ? this.mEventListeners[param1] as Array : null;
         return !!_loc2_ ? _loc2_.length != 0 : false;
      }
   }
}
