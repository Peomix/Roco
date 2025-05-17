package com.QQ.angel.plugs.Login.ui2.views
{
   import com.QQ.angel.plugs.Login.ui2.components.CommSerItemList;
   import com.QQ.angel.plugs.Login.ui2.events.LoginUIEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.IEventDispatcher;
   
   public class RecommendView implements IView
   {
      
      protected var titleMC:MovieClip;
      
      protected var lookAllSerBtn:SimpleButton;
      
      protected var recoSerBtn:SimpleButton;
      
      protected var nextView:IView;
      
      protected var itemList:CommSerItemList;
      
      protected var ui2:IEventDispatcher;
      
      public function RecommendView(param1:Object)
      {
         super();
         this.ui2 = param1 as IEventDispatcher;
         titleMC = param1.titleMC;
         lookAllSerBtn = param1.lookAllSerBtn;
         recoSerBtn = param1.recoSerBtn;
         itemList = param1.itemList;
      }
      
      public function enter() : void
      {
         var _loc1_:LoginUIEvent = null;
         lookAllSerBtn.visible = true;
         recoSerBtn.visible = false;
         titleMC.gotoAndStop(1);
         _loc1_ = new LoginUIEvent(LoginUIEvent.RECOMMAND_REQ);
         this.ui2.dispatchEvent(_loc1_);
      }
      
      public function exit() : void
      {
         this.itemList.clear();
      }
      
      public function setNextView(param1:IView) : void
      {
         this.nextView = param1;
      }
      
      public function setData(param1:Array, param2:int) : void
      {
         this.itemList.setData(param1);
      }
   }
}

