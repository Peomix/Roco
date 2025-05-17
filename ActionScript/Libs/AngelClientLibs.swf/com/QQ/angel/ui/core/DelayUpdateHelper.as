package com.QQ.angel.ui.core
{
   import flash.events.Event;
   
   public class DelayUpdateHelper
   {
      
      private static var _helpers:Array;
      
      private var _updateFun:Function;
      
      private var _isInvalidate:Boolean;
      
      public function DelayUpdateHelper(param1:Function)
      {
         super();
         if(_helpers == null)
         {
            initEvent();
         }
         this._updateFun = param1;
      }
      
      private static function initEvent() : void
      {
         _helpers = [];
         StageManager.stage.addEventListener(Event.ENTER_FRAME,__enterframe);
      }
      
      protected static function __enterframe(param1:Event) : void
      {
         var _loc3_:DelayUpdateHelper = null;
         if(_helpers.length <= 0)
         {
            return;
         }
         var _loc2_:Array = _helpers.concat();
         _helpers.length = 0;
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_._isInvalidate)
            {
               _loc3_.update();
            }
         }
      }
      
      public function invalidate() : void
      {
         if(this._isInvalidate == true)
         {
            return;
         }
         this._isInvalidate = true;
         _helpers.push(this);
      }
      
      public function validate() : void
      {
         this._isInvalidate = false;
         var _loc1_:int = int(_helpers.indexOf(this));
         if(_loc1_ < 0)
         {
            return;
         }
         _helpers.splice(_loc1_,1);
      }
      
      public function update() : void
      {
         this._isInvalidate = false;
         this._updateFun();
      }
   }
}

