package com.QQ.angel.ui.effect
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   
   public class Effect2Controller implements IEffectController
   {
       
      
      protected var container:DisplayObjectContainer;
      
      protected var eDatas:Array;
      
      protected var cEBufferD:Array;
      
      protected var eItems:Array;
      
      protected var lastItem:Effect2Item;
      
      protected var eBegin:Effect2Begin;
      
      public function Effect2Controller(param1:DisplayObjectContainer)
      {
         var _loc3_:Effect2Item = null;
         super();
         this.container = param1;
         this.eDatas = [];
         this.eItems = [];
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = new Effect2Item();
            _loc3_.stop();
            this.eItems.push(_loc3_);
            _loc2_++;
         }
         this.eBegin = new Effect2Begin();
         this.eBegin.addEventListener("onMVEnd",this.onBeginMVEnd);
      }
      
      protected function onBeginMVEnd(param1:Event) : void
      {
         if(this.container.contains(this.eBegin))
         {
            this.container.removeChild(this.eBegin);
         }
      }
      
      protected function nextGroup() : void
      {
         if(this.eDatas.length == 0)
         {
            return;
         }
         this.cEBufferD = this.eDatas.shift() as Array;
         this.container.addChild(this.eBegin);
         this.eBegin.gotoAndPlay(1);
         this.tryNextData();
      }
      
      protected function tryNextData() : void
      {
         var _loc1_:CFunction = null;
         if(this.cEBufferD.length == 0)
         {
            if(this.lastItem == null)
            {
               _loc1_ = this.cEBufferD["endHandler"];
               if(_loc1_ != null)
               {
                  _loc1_.invoke();
               }
               this.nextGroup();
            }
            return;
         }
         if(this.tryNext(this.cEBufferD[0]))
         {
            this.cEBufferD.shift();
         }
      }
      
      protected function tryNext(param1:Object) : Boolean
      {
         if(this.eItems.length == 0)
         {
            return false;
         }
         var _loc2_:Effect2Item = this.eItems.shift() as Effect2Item;
         _loc2_.addEventListener("onNext",this.onItemNextEvent);
         this.container.addChild(_loc2_);
         _loc2_.playData(param1.msg,param1.borderC,param1.color == null ? 16777215 : uint(param1.color));
         this.lastItem = _loc2_;
         return true;
      }
      
      protected function onItemNextEvent(param1:Event) : void
      {
         var _loc2_:Effect2Item = param1.target as Effect2Item;
         _loc2_.removeEventListener("onNext",this.onItemNextEvent);
         _loc2_.addEventListener("onMVEnd",this.onItemMVEndEvent);
         this.tryNextData();
      }
      
      protected function onItemMVEndEvent(param1:Event) : void
      {
         var _loc2_:Effect2Item = param1.target as Effect2Item;
         _loc2_.removeEventListener("onMVEnd",this.onItemNextEvent);
         this.container.removeChild(_loc2_);
         if(this.lastItem == _loc2_)
         {
            this.lastItem = null;
         }
         this.eItems.push(_loc2_);
         if(this.lastItem == null || this.lastItem.hasNextEvent() == false)
         {
            this.tryNextData();
         }
      }
      
      public function start(param1:Object, param2:CFunction = null) : void
      {
         if(!(param1 is Array))
         {
            return;
         }
         param1["endHandler"] = param2;
         this.eDatas.push(param1);
         if(this.lastItem == null)
         {
            this.nextGroup();
         }
      }
   }
}
