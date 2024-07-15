package com.QQ.angel.utils
{
   import flash.utils.Dictionary;
   
   public class CallBacker
   {
       
      
      private var _listeners:Array;
      
      private var _singleListeners:Dictionary;
      
      private var _target:Object;
      
      private var _data:*;
      
      public var userData:*;
      
      public function CallBacker(param1:Object = null)
      {
         super();
         this._target = param1 || this;
         this._listeners = new Array();
         this._singleListeners = new Dictionary();
      }
      
      public function addListener(param1:Function) : void
      {
         if(this._listeners.indexOf(param1) < 0)
         {
            this._listeners.push(param1);
         }
      }
      
      public function removeListener(param1:Function) : void
      {
         this._listeners.splice(this._listeners.indexOf(param1),1);
         delete this._singleListeners[param1];
      }
      
      public function dispatch(param1:* = null) : void
      {
         var _loc3_:Function = null;
         if(this._listeners.length <= 0)
         {
            return;
         }
         this._data = param1;
         var _loc2_:Array = this._listeners.concat();
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.length == 1)
            {
               _loc3_(this);
            }
            else
            {
               _loc3_();
            }
            if(this._singleListeners[_loc3_] != undefined)
            {
               this.removeListener(_loc3_);
            }
         }
      }
      
      public function addSingleListener(param1:Function) : void
      {
         this._singleListeners[param1] = param1;
         this.addListener(param1);
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function get listenerLength() : int
      {
         return this._listeners.length;
      }
      
      public function get data() : *
      {
         return this._data;
      }
   }
}
