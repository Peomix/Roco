package com.QQ.angel.plugs.Login.ui2
{
   import com.QQ.angel.plugs.Login.ui2.components.CommSerItem;
   import com.QQ.angel.plugs.Login.ui2.components.CommSerItemList;
   import com.QQ.angel.plugs.Login.ui2.components.MsgBox;
   import com.QQ.angel.plugs.Login.ui2.components.PageNavigation;
   import com.QQ.angel.plugs.Login.ui2.events.LoginUIEvent;
   import com.QQ.angel.plugs.Login.ui2.views.IView;
   import com.QQ.angel.plugs.Login.ui2.views.RangeView;
   import com.QQ.angel.plugs.Login.ui2.views.RecommendView;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   [Embed(source="/_assets/assets.swf", symbol="com.QQ.angel.plugs.Login.ui2.AngelLoginUI2")]
   public class AngelLoginUI2 extends Sprite
   {
      
      public static const RECOMMEND_TYPE:String = "recommend";
      
      public static const RANGE_TYPE:String = "rangeList";
       
      
      public var chooseBtn:MovieClip;
      
      public var btnAge:SimpleButton;
      
      public var stow_btn:SimpleButton;
      
      public var fastGetIn:SimpleButton;
      
      public var connectErrorMsg:Sprite;
      
      public var connectErrorMsgII:Sprite;
      
      public var childWardErrorMsg:Sprite;
      
      public var wrongRoomMsg:Sprite;
      
      public var tooManyTimeMsg:Sprite;
      
      public var tooManyMsg:Sprite;
      
      public var waitingMsg:Sprite;
      
      public var maskSprite:Sprite;
      
      public var lookAllSerBtn:SimpleButton;
      
      public var recoSerBtn:SimpleButton;
      
      public var goBtn:SimpleButton;
      
      public var goTxt:TextField;
      
      public var titleMC:MovieClip;
      
      public var item_0:CommSerItem;
      
      public var item_1:CommSerItem;
      
      public var item_2:CommSerItem;
      
      public var item_3:CommSerItem;
      
      public var item_4:CommSerItem;
      
      public var item_5:CommSerItem;
      
      public var item_6:CommSerItem;
      
      public var item_7:CommSerItem;
      
      public var itemList:CommSerItemList;
      
      public var msgBox:MsgBox;
      
      public var views:Dictionary;
      
      public var curreView:IView;
      
      public var pageNav:PageNavigation;
      
      public function AngelLoginUI2()
      {
         super();
         itemList = new CommSerItemList([item_0,item_1,item_2,item_3,item_4,item_5,item_6,item_7],this);
         msgBox = new MsgBox(this,maskSprite,connectErrorMsg,tooManyMsg,waitingMsg,wrongRoomMsg,tooManyTimeMsg,connectErrorMsgII,childWardErrorMsg);
         titleMC.gotoAndStop(1);
         lookAllSerBtn.visible = true;
         recoSerBtn.visible = false;
         goTxt.restrict = "0-9";
         pageNav = new PageNavigation();
         pageNav.x = 590;
         pageNav.y = 422;
         addChildAt(pageNav,getChildIndex(maskSprite) - 1);
         pageNav.num = 5;
         pageNav.pageSize = 8;
         pageNav.page = 1;
         pageNav.visible = false;
         views = new Dictionary();
         curreView = views[RECOMMEND_TYPE] = new RecommendView(this);
         views[RANGE_TYPE] = new RangeView(this);
         lookAllSerBtn.addEventListener(MouseEvent.CLICK,onChangViewEvent);
         recoSerBtn.addEventListener(MouseEvent.CLICK,onChangViewEvent);
         goBtn.addEventListener(MouseEvent.CLICK,onSpeedIn);
         goTxt.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
         fastGetIn.addEventListener(MouseEvent.CLICK,onFastGetInClick);
      }
      
      public function onFastGetInClick(param1:MouseEvent) : void
      {
         var _loc2_:LoginUIEvent = new LoginUIEvent(LoginUIEvent.FAST_LOGIN);
         dispatchEvent(_loc2_);
      }
      
      protected function onKeyDownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            onSpeedIn(null);
         }
      }
      
      protected function onSpeedIn(param1:MouseEvent) : void
      {
         var _loc2_:int = int(goTxt.text);
         if(_loc2_ <= 0)
         {
            return;
         }
         var _loc3_:LoginUIEvent = new LoginUIEvent(LoginUIEvent.SPEED_IN);
         _loc3_.data = _loc2_;
         dispatchEvent(_loc3_);
      }
      
      protected function onChangViewEvent(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.target == lookAllSerBtn ? RANGE_TYPE : RECOMMEND_TYPE;
         if(curreView != views[_loc2_])
         {
            curreView.exit();
            curreView = views[_loc2_];
            curreView.enter();
         }
      }
      
      public function setData(param1:String, param2:Array, param3:int = 0) : void
      {
         if(curreView != null)
         {
            curreView.setData(param2,param3);
         }
      }
      
      public function setWaiting(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(2);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setWrongRoom(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(3);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setTooManyTime(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(4);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setTooManyPeople(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(1);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setErroMsg(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(0);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setErroRefreshMsg(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(5);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function setErroChildWardMsg(param1:Boolean) : void
      {
         if(param1)
         {
            msgBox.show(6);
         }
         else
         {
            msgBox.hidden();
         }
      }
      
      public function dispose() : void
      {
         lookAllSerBtn.removeEventListener(MouseEvent.CLICK,onChangViewEvent);
         recoSerBtn.removeEventListener(MouseEvent.CLICK,onChangViewEvent);
         goBtn.removeEventListener(MouseEvent.CLICK,onSpeedIn);
         goTxt.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyDownHandler);
         fastGetIn.removeEventListener(MouseEvent.CLICK,onFastGetInClick);
      }
   }
}
