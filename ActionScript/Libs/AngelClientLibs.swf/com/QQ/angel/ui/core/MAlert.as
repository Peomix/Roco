package com.QQ.angel.ui.core
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class MAlert extends Window
   {
      
      public var content:AlertContent;
      
      private var _okBtn:SimpleButton;
      
      private var _cancelBtn:SimpleButton;
      
      private var _closeBtn:SimpleButton;
      
      private var _tileTxt:TextField;
      
      private var _msgTxt:TextField;
      
      private var _okHandler:Function;
      
      private var _cancelHandler:Function;
      
      private var _ui:MovieClip;
      
      public function MAlert(param1:DisplayObjectContainer)
      {
         super();
         initialize(param1,null,null,null,true);
      }
      
      public function init(param1:MovieClip, param2:String = "", param3:String = "", param4:Function = null, param5:Function = null) : void
      {
         if(param1.hasOwnProperty("okBtn"))
         {
            this._okBtn = param1.okBtn;
            this._okBtn.addEventListener(MouseEvent.CLICK,this.clickOkHnadler);
         }
         if(param1.hasOwnProperty("cancelBtn"))
         {
            this._cancelBtn = param1.cancelBtn;
            this._cancelBtn.addEventListener(MouseEvent.CLICK,this.clickCancelHnadler);
         }
         if(param1.hasOwnProperty("closeBtn"))
         {
            this._closeBtn = param1.closeBtn;
            this._closeBtn.addEventListener(MouseEvent.CLICK,this.clickCloseHnadler);
         }
         if(param1.hasOwnProperty("tileTxt"))
         {
            this._tileTxt = param1.tileTxt;
            this._tileTxt.text = param2;
         }
         if(param1.hasOwnProperty("msgTxt"))
         {
            this._msgTxt = param1.msgTxt;
            this._msgTxt.text = param3;
         }
         this._okHandler = param4;
         this._cancelHandler = param5;
         this._ui = param1;
      }
      
      override public function show() : void
      {
         super.show();
         if(this._ui == null)
         {
            return;
         }
         this.addChild(this._ui);
         this.center();
      }
      
      private function clickOkHnadler(param1:Event) : void
      {
         if(this._okHandler != null)
         {
            this._okHandler();
         }
         this.closeHandler();
      }
      
      private function clickCancelHnadler(param1:Event) : void
      {
         if(this._cancelHandler != null)
         {
            this._cancelHandler();
         }
         this.closeHandler();
      }
      
      private function closeHandler() : void
      {
         if(_closeAction == WindowCloseAction.CLOSE)
         {
            super.close();
            if(this._okBtn != null)
            {
               this._okBtn.removeEventListener(MouseEvent.CLICK,this.clickOkHnadler);
            }
            if(this._cancelBtn != null)
            {
               this._cancelBtn.removeEventListener(MouseEvent.CLICK,this.clickCancelHnadler);
            }
            if(this._closeBtn != null)
            {
               this._closeBtn.removeEventListener(MouseEvent.CLICK,this.clickCloseHnadler);
            }
            this._okBtn = null;
            this._cancelBtn = null;
            this._closeBtn = null;
            this._okHandler = null;
            this._cancelHandler = null;
            this._msgTxt = null;
            this._tileTxt = null;
            this._ui = null;
         }
         else if(_closeAction == WindowCloseAction.HIDE)
         {
            super.hide();
            if(this._msgTxt != null)
            {
               this._msgTxt.text = "";
            }
            if(this._tileTxt != null)
            {
               this._tileTxt.text = "";
            }
         }
      }
      
      private function clickCloseHnadler(param1:Event) : void
      {
         this.closeHandler();
      }
   }
}

