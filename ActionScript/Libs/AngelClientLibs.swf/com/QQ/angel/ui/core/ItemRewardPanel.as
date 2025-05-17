package com.QQ.angel.ui.core
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.ItemRewardData;
   import com.QQ.angel.newbieGuide.GuideModuleName;
   import com.QQ.angel.newbieGuide.GuideTargetName;
   import com.QQ.angel.newbieGuide.INewbieGuide;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol60")]
   public class ItemRewardPanel extends Window implements IManagedWin, INewbieGuide
   {
      
      public var bg:Sprite;
      
      public var infoTxt:TextField;
      
      public var knowBtn:SimpleButton;
      
      public var item_0:IConItem;
      
      public var arrowMC:MovieClip;
      
      public var icon:MovieClip;
      
      protected var data:ItemRewardData;
      
      protected var currIndex:int = 0;
      
      protected var handler:CFunction;
      
      public function ItemRewardPanel(param1:DisplayObjectContainer, param2:Boolean = false, param3:Point = null)
      {
         super();
         addChild(this.item_0 = new IConItem(0,60));
         this.item_0.x = 50;
         this.item_0.y = 19;
         this.infoTxt.y = 85;
         initialize(param1,this.bg,this.knowBtn,null,param2);
         this.infoTxt.mouseEnabled = false;
         this.arrowMC.mouseEnabled = false;
         this.icon.mouseEnabled = false;
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NEWBIE_GUIDE_ON_REGISTER,[GuideModuleName.REWARD_PANEL,this]);
      }
      
      public function setData(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ItemRewardData = param1 as ItemRewardData;
         if(this.data == null)
         {
            this.data = _loc2_;
            if(this.data == null || this.data.items == null)
            {
               return;
            }
            this.currIndex = 0;
            this.setItemList();
         }
         else if(Boolean(this.data.items) && Boolean(_loc2_.items))
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_.items.length)
            {
               this.data.items.push(_loc2_.items[_loc3_]);
               _loc3_++;
            }
         }
      }
      
      public function bindHandler(param1:CFunction) : void
      {
         this.handler = param1;
      }
      
      protected function setItemList() : Boolean
      {
         if(this.data == null)
         {
            return false;
         }
         var _loc1_:int = this.data.items.length - this.currIndex;
         if(_loc1_ <= 0)
         {
            return false;
         }
         var _loc2_:Object = this.data.items[this.currIndex];
         this.item_0.setData(_loc2_);
         ++this.currIndex;
         var _loc3_:int = this.item_0.getCount();
         if(_loc2_.hasOwnProperty("infoTxt"))
         {
            this.infoTxt.htmlText = _loc2_.infoTxt;
         }
         else
         {
            this.infoTxt.htmlText = "<b><font color=\"#ff0000\">" + _loc2_.name + "</font>x" + _loc3_ + "已放入你的背包</b>";
         }
         if(_loc2_.hasOwnProperty("level"))
         {
            this.icon.gotoAndStop(2);
         }
         else
         {
            this.icon.gotoAndStop(1);
         }
         return true;
      }
      
      override public function show() : void
      {
         this.arrowMC.play();
         super.show();
         center();
      }
      
      override public function close() : void
      {
         if(this.setItemList())
         {
            return;
         }
         this.data = null;
         super.close();
         var _loc1_:CFunction = this.handler;
         this.handler = null;
         if(_loc1_ != null)
         {
            _loc1_.invoke();
         }
         this.arrowMC.gotoAndStop(1);
      }
      
      public function getGuideTarget(param1:String) : DisplayObject
      {
         switch(param1)
         {
            case GuideTargetName.OK:
               return this.knowBtn;
            default:
               return null;
         }
      }
   }
}

