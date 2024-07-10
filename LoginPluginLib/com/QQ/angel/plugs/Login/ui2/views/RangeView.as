package com.QQ.angel.plugs.Login.ui2.views
{
   import com.QQ.angel.plugs.Login.ui2.components.CommSerItemList;
   import com.QQ.angel.plugs.Login.ui2.components.PageNavigation;
   import com.QQ.angel.plugs.Login.ui2.events.LoginUIEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public class RangeView implements IView
   {
       
      
      protected var titleMC:MovieClip;
      
      protected var lookAllSerBtn:SimpleButton;
      
      protected var recoSerBtn:SimpleButton;
      
      protected var nextView:IView;
      
      protected var itemList:CommSerItemList;
      
      protected var pageNav:PageNavigation;
      
      protected var ui2:IEventDispatcher;
      
      public function RangeView(param1:Object)
      {
         super();
         this.ui2 = param1 as IEventDispatcher;
         titleMC = param1.titleMC;
         lookAllSerBtn = param1.lookAllSerBtn;
         recoSerBtn = param1.recoSerBtn;
         itemList = param1.itemList;
         pageNav = param1.pageNav;
      }
      
      protected function onPageChange(param1:Event) : void
      {
         var _loc3_:LoginUIEvent = null;
         var _loc2_:Array = pageNav.range;
         trace("[RangeView] range:" + _loc2_);
         _loc3_ = new LoginUIEvent(LoginUIEvent.RANGE_REQ);
         _loc3_.data = {
            "start":_loc2_[0],
            "stop":_loc2_[1]
         };
         this.ui2.dispatchEvent(_loc3_);
      }
      
      public function enter() : void
      {
         titleMC.gotoAndStop(2);
         lookAllSerBtn.visible = false;
         recoSerBtn.visible = true;
         pageNav.visible = true;
         pageNav.addEventListener(Event.CHANGE,onPageChange);
         onPageChange(null);
      }
      
      public function exit() : void
      {
         pageNav.visible = false;
         pageNav.removeEventListener(Event.CHANGE,onPageChange);
         this.itemList.clear();
      }
      
      public function setNextView(param1:IView) : void
      {
      }
      
      public function setData(param1:Array, param2:int) : void
      {
         itemList.setData(param1,true);
         trace("[RangeView] 设置翻页的长度:" + param2);
         pageNav.total = param2;
      }
   }
}
