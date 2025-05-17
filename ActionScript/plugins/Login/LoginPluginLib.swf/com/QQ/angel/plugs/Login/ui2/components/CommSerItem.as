package com.QQ.angel.plugs.Login.ui2.components
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol51")]
   public class CommSerItem extends Sprite
   {
      
      public static var grayFilter:ColorMatrixFilter;
      
      public var label_txt:TextField;
      
      public var star_mc:MovieClip;
      
      public var icon_mc:MovieClip;
      
      public var bgBtn_1:SimpleButton;
      
      public var bgBtn_2:SimpleButton;
      
      private var __data:Object;
      
      public function CommSerItem()
      {
         super();
         star_mc.gotoAndStop(1);
         icon_mc.gotoAndStop(1);
         label_txt.mouseEnabled = false;
         icon_mc.mouseEnabled = false;
         icon_mc.mouseChildren = false;
         star_mc.mouseEnabled = false;
         bgBtn_1.addEventListener(MouseEvent.CLICK,onDBClicked);
         bgBtn_2.addEventListener(MouseEvent.CLICK,onDBClicked);
      }
      
      protected function onDBClicked(param1:MouseEvent) : void
      {
         dispatchEvent(new Event("ItemDBClick"));
      }
      
      public function reset() : void
      {
         bgBtn_1.visible = true;
         bgBtn_2.visible = true;
         star_mc.gotoAndStop(1);
         icon_mc.gotoAndStop(1);
         label_txt.htmlText = "";
      }
      
      public function set data(param1:Object) : void
      {
         reset();
         __data = param1;
         if(this.__data == null)
         {
            visible = false;
            return;
         }
         visible = true;
         bgBtn_1.visible = __data.roomType != 0;
         var _loc2_:Boolean = bgBtn_2.visible = __data.roomType == 0;
         label_txt.htmlText = "<b><font color=\'" + (_loc2_ ? "#2B2361" : "#803f00") + "\'>" + __data.roomName + "</font></b>";
         var _loc3_:int = 1 + Math.ceil(__data.roomPerson / __data.roomLimit * (star_mc.totalFrames - 1));
         if(_loc3_ <= 4)
         {
            _loc3_ += 2;
         }
         star_mc.gotoAndStop(_loc3_);
         if(__data.roomStat != 0)
         {
            this.filters = [grayFilter];
            this.mouseEnabled = false;
            this.mouseChildren = false;
         }
         else
         {
            this.filters = null;
            this.mouseChildren = true;
            this.mouseEnabled = true;
         }
      }
      
      public function get data() : Object
      {
         return __data;
      }
      
      public function dispose() : void
      {
         bgBtn_1.removeEventListener(MouseEvent.DOUBLE_CLICK,onDBClicked);
         bgBtn_2.removeEventListener(MouseEvent.DOUBLE_CLICK,onDBClicked);
      }
   }
}

