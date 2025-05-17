package com.QQ.angel.plugs.Login.ui2.components
{
   import com.QQ.angel.plugs.Login.ui2.events.LoginUIEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class CommSerItemList extends EventDispatcher
   {
      
      protected var items:Array;
      
      protected var ui2:IEventDispatcher;
      
      public function CommSerItemList(param1:Array, param2:IEventDispatcher)
      {
         super();
         this.ui2 = param2;
         this.items = param1;
         this.ready();
      }
      
      protected function onItemClickHandler(param1:Event) : void
      {
         var _loc2_:CommSerItem = param1.target as CommSerItem;
         var _loc3_:LoginUIEvent = new LoginUIEvent(LoginUIEvent.LOGIN_REQ);
         _loc3_.data = _loc2_.data;
         this.ui2.dispatchEvent(_loc3_);
      }
      
      protected function ready() : void
      {
         var _loc2_:CommSerItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.items[_loc1_];
            _loc2_.addEventListener("ItemDBClick",onItemClickHandler);
            _loc2_.data = null;
            _loc1_++;
         }
      }
      
      public function setData(param1:Array, param2:Boolean = false) : void
      {
         var _loc4_:CommSerItem = null;
         var _loc5_:Object = null;
         if(param1 == null)
         {
            param1 = [];
         }
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            _loc4_ = this.items[_loc3_];
            _loc5_ = param1[_loc3_];
            if(param2 && _loc5_ != null)
            {
               _loc5_.roomType = 1;
            }
            _loc4_.data = _loc5_;
            _loc3_++;
         }
      }
      
      public function clear() : void
      {
         var _loc2_:CommSerItem = null;
         var _loc1_:int = 0;
         while(_loc1_ < 8)
         {
            _loc2_ = this.items[_loc1_];
            _loc2_.data = null;
            _loc1_++;
         }
      }
   }
}

