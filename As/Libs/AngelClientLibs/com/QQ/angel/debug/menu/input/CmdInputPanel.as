package com.QQ.angel.debug.menu.input
{
   import com.QQ.angel.debug.CmdBase;
   import com.QQ.angel.debug.Debugger;
   import com.QQ.angel.debug.menu.CmdItemData;
   import com.tencent.fge.utils.SWFUtil;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class CmdInputPanel extends EventDispatcher
   {
      
      private static var ms_instance:CmdInputPanel = null;
       
      
      private var m_ui:Sprite;
      
      private var m_txtInput:TextField;
      
      private var m_txtTitle:TextField;
      
      private var m_txtExample:TextField;
      
      private var m_btnConfirm:SimpleButton;
      
      private var m_btnClose:SimpleButton;
      
      private var m_btnDropDown:SimpleButton;
      
      private var m_ctlDropDownList:CtlDropDownList;
      
      private var m_data:CmdItemData;
      
      private var m_bOpen:Boolean = false;
      
      private var m_ctlBg:Sprite;
      
      public function CmdInputPanel()
      {
         super();
         this.createUI();
      }
      
      public static function get instance() : CmdInputPanel
      {
         if(null == ms_instance)
         {
            ms_instance = new CmdInputPanel();
         }
         return ms_instance;
      }
      
      private function get container() : DisplayObjectContainer
      {
         return Debugger.container;
      }
      
      public function open(param1:CmdItemData) : void
      {
         if(!this.m_bOpen)
         {
            this.m_bOpen = true;
            this.m_txtInput.text = "请输入参数";
            this.m_data = param1;
            this.m_ctlDropDownList.data = this.analyse(this.m_data.lstDefaultParams);
            this.updateView();
            SWFUtil.safeAddChild(this.container,this.m_ui);
            this.m_txtInput.addEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
            this.m_txtInput.addEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
            this.m_btnConfirm.addEventListener(MouseEvent.CLICK,this.onConfrim);
            this.m_btnClose.addEventListener(MouseEvent.CLICK,this.onClose);
            this.m_btnDropDown.addEventListener(MouseEvent.CLICK,this.onDropDown);
            this.m_ctlBg.addEventListener(MouseEvent.MOUSE_DOWN,this.onBgMouseDown);
            this.resetPos();
         }
      }
      
      public function close() : void
      {
         if(this.m_bOpen)
         {
            this.m_bOpen = false;
            SWFUtil.safeRemoveChild(this.container,this.m_ui);
            this.m_txtInput.removeEventListener(FocusEvent.FOCUS_IN,this.onFocusIn);
            this.m_txtInput.removeEventListener(FocusEvent.FOCUS_OUT,this.onFocusOut);
            this.m_btnConfirm.removeEventListener(MouseEvent.CLICK,this.onConfrim);
            this.m_btnClose.removeEventListener(MouseEvent.CLICK,this.onClose);
            this.m_btnDropDown.removeEventListener(MouseEvent.CLICK,this.onDropDown);
            if(Boolean(this.container) && Boolean(this.container.stage))
            {
               this.container.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            }
            this.m_ctlBg.removeEventListener(MouseEvent.MOUSE_DOWN,this.onBgMouseDown);
            this.m_ctlDropDownList.hide();
         }
      }
      
      private function analyse(param1:Array) : Array
      {
         var _loc3_:String = null;
         var _loc4_:Object = null;
         var _loc2_:Array = new Array();
         for each(_loc4_ in param1)
         {
            if(_loc4_ is String)
            {
               _loc3_ = _loc4_ as String;
            }
            else if(_loc4_ is Array)
            {
               _loc3_ = _loc4_[0];
            }
            else
            {
               _loc3_ = _loc4_.param;
            }
            if(_loc3_ != "-inputparameters")
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      private function onFocusIn(param1:FocusEvent) : void
      {
         if(this.m_txtInput.text == "请输入参数" || this.m_txtInput.text == "参数格式错误，请重新输入")
         {
            this.m_txtInput.text = "";
         }
         if(Boolean(this.container) && Boolean(this.container.stage))
         {
            this.container.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         this.m_ctlDropDownList.hide();
      }
      
      private function onFocusOut(param1:FocusEvent) : void
      {
         if(this.m_txtInput.text == "")
         {
            this.m_txtInput.text = "请输入参数";
         }
         if(Boolean(this.container) && Boolean(this.container.stage))
         {
            this.container.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
      }
      
      private function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.onConfrim(null);
         }
      }
      
      private function onConfrim(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = this.m_txtInput.text.split(",");
         if(_loc2_.length == this.m_data.callbackParamCount)
         {
            _loc3_ = this.m_data.lstPath.slice(0,-1).join(" ");
            _loc3_ += " (" + this.m_txtInput.text + ")";
            CmdBase.outputCmd(_loc3_);
            this.m_data.invokeCallback(_loc2_);
            if(-1 == this.m_ctlDropDownList.data.indexOf(this.m_txtInput.text))
            {
               this.m_ctlDropDownList.data.push(this.m_txtInput.text);
               this.m_ctlDropDownList.update();
            }
         }
         else
         {
            this.m_txtInput.text = "参数格式错误，请重新输入";
            trace("参数格式错误，请重新输入");
         }
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function onDropDown(param1:MouseEvent) : void
      {
         if(this.m_ctlDropDownList.visible)
         {
            this.m_ctlDropDownList.hide();
         }
         else
         {
            this.m_ctlDropDownList.show();
         }
      }
      
      public function onDropDownItemClick(param1:String) : void
      {
         this.m_txtInput.text = param1;
         this.m_ctlDropDownList.hide();
      }
      
      private function onBgMouseDown(param1:MouseEvent) : void
      {
         if(Boolean(this.container) && Boolean(this.container.stage))
         {
            this.container.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         this.m_ui.startDrag();
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         if(Boolean(this.container) && Boolean(this.container.stage))
         {
            this.container.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
         this.m_ui.stopDrag();
      }
      
      private function updateView() : void
      {
         var _loc1_:String = this.m_data.lstPath[this.m_data.lstPath.length - 2];
         this.m_txtTitle.htmlText = "<font size=\'14\' color=\'#0033FF\'><font color=\'#FF0000\'>[<b>" + _loc1_ + "</b>]</font> 请输入<font color=\'#FF0000\'>" + this.m_data.callbackParamCount + "</font>个参数(用逗号隔开)</font>";
         this.m_txtTitle.mouseEnabled = false;
         this.m_txtExample.text = "(格式:" + this.m_data.example + ")";
      }
      
      private function createUI() : void
      {
         this.m_ui = new Sprite();
         this.resetPos();
         this.createBackGround();
         this.createTitleText();
         this.createExampleText();
         this.createInputText();
         this.createConfirmButton();
         this.createCloseButton();
         this.createDropDownButton();
         this.createDropDownList();
      }
      
      private function resetPos() : void
      {
         this.m_ui.x = 375;
         this.m_ui.y = 225;
      }
      
      private function createBackGround() : void
      {
         this.m_ctlBg = new Sprite();
         var _loc1_:DisplayObject = this.createRect(7829367,new Rectangle(0,0,400,150));
         var _loc2_:DisplayObject = this.createRect(13421772,new Rectangle(2,2,396,146));
         this.m_ctlBg.addChild(_loc1_);
         this.m_ctlBg.addChild(_loc2_);
         this.m_ui.addChild(this.m_ctlBg);
      }
      
      private function createTitleText() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_txtTitle = new TextField();
         this.m_txtTitle.width = 400;
         this.m_txtTitle.autoSize = TextFieldAutoSize.CENTER;
         this.m_txtTitle.htmlText = "<font size=\'14\' color=\'#0033FF\'>请输入<font color=\'#FF0000\'>?</font>个参数(用空格分隔)</font>";
         this.m_txtTitle.mouseEnabled = this.m_txtTitle.selectable = false;
         _loc1_.addChild(this.m_txtTitle);
         _loc1_.mouseEnabled = false;
         this.m_ui.addChild(_loc1_);
         _loc1_.y = 5;
         _loc1_.x = 25;
      }
      
      private function createExampleText() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_txtExample = new TextField();
         var _loc2_:TextFormat = new TextFormat("宋体",14,5592405);
         this.m_txtExample.defaultTextFormat = _loc2_;
         this.m_txtExample.width = 350;
         this.m_txtExample.autoSize = TextFieldAutoSize.LEFT;
         this.m_txtExample.mouseEnabled = this.m_txtTitle.selectable = false;
         _loc1_.addChild(this.m_txtExample);
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 25;
         _loc1_.y = 70;
      }
      
      private function createInputText() : void
      {
         var _loc1_:Sprite = new Sprite();
         var _loc2_:DisplayObject = this.createRect(0,new Rectangle(0,0,350,28));
         var _loc3_:DisplayObject = this.createRect(10066329,new Rectangle(2,2,346,24));
         this.m_txtInput = new TextField();
         var _loc4_:TextFormat = new TextFormat("宋体",14,16777215);
         this.m_txtInput.defaultTextFormat = _loc4_;
         this.m_txtInput.width = 340;
         this.m_txtInput.height = 25;
         this.m_txtInput.x = 3;
         this.m_txtInput.y = 4;
         this.m_txtTitle.autoSize = TextFieldAutoSize.LEFT;
         this.m_txtInput.type = TextFieldType.INPUT;
         this.m_txtInput.text = "请输入参数";
         _loc1_.addChild(_loc2_);
         _loc1_.addChild(_loc3_);
         _loc1_.addChild(this.m_txtInput);
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 25;
         _loc1_.y = 40;
      }
      
      private function createConfirmButton() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_btnConfirm = this.createRectButton(100,30,13421772,8454143);
         var _loc2_:TextField = new TextField();
         var _loc3_:TextFormat = new TextFormat("宋体",20,0,true);
         _loc2_.defaultTextFormat = _loc3_;
         _loc2_.width = 100;
         _loc2_.mouseEnabled = this.m_txtTitle.selectable = false;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.text = "确定";
         _loc1_.addChild(this.m_btnConfirm);
         _loc1_.addChild(_loc2_);
         _loc2_.y = 2;
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 280;
         _loc1_.y = 110;
      }
      
      private function createCloseButton() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_btnClose = this.createRectButton(20,20,8388608,11534336);
         var _loc2_:TextField = new TextField();
         var _loc3_:TextFormat = new TextFormat("宋体",16,16777215,true);
         _loc2_.defaultTextFormat = _loc3_;
         _loc2_.width = 20;
         _loc2_.mouseEnabled = this.m_txtTitle.selectable = false;
         _loc2_.autoSize = TextFieldAutoSize.CENTER;
         _loc2_.text = "×";
         _loc2_.y = -2;
         _loc1_.addChild(this.m_btnClose);
         _loc1_.addChild(_loc2_);
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 375;
         _loc1_.y = 5;
      }
      
      private function createDropDownButton() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_btnDropDown = this.createTriangleButton();
         _loc1_.addChild(this.m_btnDropDown);
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 360;
         _loc1_.y = 50;
      }
      
      private function createDropDownList() : void
      {
         var _loc1_:Sprite = new Sprite();
         this.m_ctlDropDownList = new CtlDropDownList();
         _loc1_.addChild(this.m_ctlDropDownList);
         this.m_ui.addChild(_loc1_);
         _loc1_.x = 26;
         _loc1_.y = 70;
      }
      
      private function createRect(param1:uint, param2:Rectangle, param3:Number = 0) : DisplayObject
      {
         var _loc4_:Shape;
         (_loc4_ = new Shape()).cacheAsBitmap = true;
         _loc4_.graphics.beginFill(param1);
         _loc4_.graphics.drawRoundRect(param2.left,param2.top,param2.width,param2.height,param3);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      private function createRectButton(param1:Number, param2:Number, param3:uint, param4:uint) : SimpleButton
      {
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).addChild(this.createRect(16777215,new Rectangle(-1,-1,param1 + 1,param2 + 1)));
         _loc5_.addChild(this.createRect(0,new Rectangle(1,1,param1,param2)));
         _loc5_.addChild(this.createRect(param3,new Rectangle(0,0,param1,param2)));
         var _loc6_:Sprite;
         (_loc6_ = new Sprite()).addChild(this.createRect(16777215,new Rectangle(-1,-1,param1 + 1,param2 + 1)));
         _loc6_.addChild(this.createRect(0,new Rectangle(1,1,param1,param2)));
         _loc6_.addChild(this.createRect(param4,new Rectangle(0,0,param1,param2)));
         return new SimpleButton(_loc5_,_loc6_,this.createRect(7829367,new Rectangle(1,1,param1,param2)),this.createRect(7829367,new Rectangle(1,1,param1,param2)));
      }
      
      private function createTriangle(param1:uint, param2:uint) : DisplayObject
      {
         var _loc3_:Shape = new Shape();
         _loc3_.cacheAsBitmap = true;
         _loc3_.graphics.beginFill(param1);
         _loc3_.graphics.lineStyle(1,param1);
         _loc3_.graphics.moveTo(0,0);
         _loc3_.graphics.lineTo(5,7);
         _loc3_.graphics.lineTo(10,0);
         _loc3_.graphics.endFill();
         var _loc4_:DisplayObject = this.createRect(param2,new Rectangle(-3,-8,16,24));
         var _loc5_:Sprite;
         (_loc5_ = new Sprite()).addChild(_loc4_);
         _loc5_.addChild(_loc3_);
         return _loc5_;
      }
      
      private function createTriangleButton() : SimpleButton
      {
         return new SimpleButton(this.createTriangle(0,10066329),this.createTriangle(0,13421772),this.createTriangle(10066227,1193046),this.createTriangle(10066227,0));
      }
   }
}
