package com.QQ.angel.ui.core
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.NPCDialogData;
   import com.QQ.angel.newbieGuide.GuideModuleName;
   import com.QQ.angel.newbieGuide.GuideTargetName;
   import com.QQ.angel.newbieGuide.INewbieGuide;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class NPCDialogPanel extends Window implements IManagedWin, INewbieGuide
   {
      
      private var _dialogs:Array;
      
      private var _currentDialogData:NPCDialogData;
      
      private var _items:Array;
      
      private var _buttons:Array;
      
      private var _children:Sprite;
      
      private var _initOpen:Boolean = true;
      
      private var _viewHeight:Number = 560;
      
      private var _viewWidth:Number = 960;
      
      private var _handler:CFunction;
      
      private var _curentPage:uint = 0;
      
      private var _maxPage:uint = 0;
      
      private var _topPage:uint = 6;
      
      private var _hash:String;
      
      public function NPCDialogPanel(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         this._init(param1,param2);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_NEWBIE_GUIDE_ON_REGISTER,[GuideModuleName.DIALOG,this]);
      }
      
      public function get hash() : String
      {
         return this._hash;
      }
      
      public function setData(param1:Object) : void
      {
         if(_state == WindowState.CLOSED)
         {
            return;
         }
         this._hash = param1.hash;
         if(!param1)
         {
            return;
         }
         this._dialogs = param1 is NPCDialogData ? [param1] : (param1 is Array ? param1 as Array : []);
         if(this._dialogs.length < 1)
         {
            return;
         }
         this._show(0);
      }
      
      public function bindHandler(param1:CFunction) : void
      {
         this._handler = param1;
      }
      
      override public function show() : void
      {
         y = this._viewHeight - 155;
         x = int((this._viewWidth - this.content.width) / 2);
         super.show();
      }
      
      private function _show(param1:int) : void
      {
         param1 = Math.max(0,Math.min(this._dialogs.length - 1,param1));
         this._currentDialogData = this._dialogs[param1];
         this._hideChildren();
         this.content.fill(this._currentDialogData.dialogs);
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_OPEND,this);
         __global.SysAPI.getGDataAPI().addGlobalVal(Constants.CUR_NPC_DIALOG,this._hash);
      }
      
      override public function hide() : void
      {
         super.hide();
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_OPEND,this);
         var _loc1_:String = __global.SysAPI.getGDataAPI().getDataProxy(Constants.CUR_NPC_DIALOG) as String;
         if(_loc1_ == this._hash)
         {
            __global.SysAPI.getGDataAPI().addGlobalVal(Constants.CUR_NPC_DIALOG,null);
         }
      }
      
      override public function close() : void
      {
         if(_state == WindowState.CLOSED)
         {
            return;
         }
         CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_CLOSED,this);
         var _loc1_:String = __global.SysAPI.getGDataAPI().getDataProxy(Constants.CUR_NPC_DIALOG) as String;
         if(_loc1_ == this._hash)
         {
            __global.SysAPI.getGDataAPI().addGlobalVal(Constants.CUR_NPC_DIALOG,null);
         }
         this._dialogs = [];
         this._currentDialogData = null;
         this._hideChildren();
         this._hash = null;
         this.content.clear();
         super.close();
         if(this._handler)
         {
            this._handler.invoke();
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:NPCDialogItem = null;
         this.content.removeEventListener(NPCDialogContent.SHOW_CHILDREN,this._swapChildren);
         this.content.removeEventListener(NPCDialogContent.HIDE_CHILDREN,this._swapChildren);
         this.content.clear();
         this.content.dispose();
         this._hideChildren();
         _loc1_ = 0;
         while(_loc1_ < this._items.length)
         {
            _loc2_ = this._items[_loc1_];
            _loc2_.removeEventListener(Event.SELECT,this._itemClick);
            _loc2_.dispose();
            _loc1_++;
         }
         this._items = [];
         _loc1_ = 0;
         while(_loc1_ < this._buttons.length)
         {
            _loc2_ = this._buttons[_loc1_];
            _loc2_.removeEventListener(Event.SELECT,this._itemClick);
            _loc2_.dispose();
            _loc1_++;
         }
         this._buttons = [];
      }
      
      private function _init(param1:DisplayObjectContainer, param2:Boolean = false) : void
      {
         _content = new NPCDialogContent();
         this._children = new Sprite();
         this.content.addChild(this._children);
         this._items = [];
         this._buttons = [];
         this._dialogs = [];
         this.content.addEventListener(NPCDialogContent.SHOW_CHILDREN,this._swapChildren);
         this.content.addEventListener(NPCDialogContent.HIDE_CHILDREN,this._swapChildren);
         initialize(param1,null,null,_content as Sprite,param2);
      }
      
      private function _swapChildren(param1:Event) : void
      {
         if(param1.type == NPCDialogContent.SHOW_CHILDREN)
         {
            this._showChildren();
         }
         else
         {
            this._hideChildren();
         }
      }
      
      private function get content() : NPCDialogContent
      {
         return _content as NPCDialogContent;
      }
      
      private function _showChildren(param1:uint = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:NPCDialogItem = null;
         var _loc6_:Array = null;
         var _loc8_:Object = null;
         this._hideChildren();
         if(!this._currentDialogData)
         {
            return;
         }
         var _loc4_:Number = 220;
         var _loc5_:Number = 0;
         this._curentPage = param1;
         if(this._currentDialogData.items != null)
         {
            this._maxPage = Math.ceil(this._currentDialogData.items.length / this._topPage);
            _loc6_ = this.getArr(this._currentDialogData.items,this._curentPage,this._topPage);
         }
         _loc2_ = 0;
         while(Boolean(_loc6_) && _loc2_ < _loc6_.length)
         {
            this._items[_loc2_] = this._items[_loc2_] || new NPCDialogItem();
            _loc3_ = this._items[_loc2_];
            _loc3_.addEventListener(Event.SELECT,this._itemClick);
            _loc3_.data = _loc6_[_loc2_];
            _loc3_.x = _loc4_;
            _loc3_.y = 83 + _loc2_ % 2 * 33;
            _loc5_ = Math.max(_loc5_,_loc3_.width + 10);
            if(_loc2_ % 2 == 1)
            {
               _loc4_ += _loc5_;
               _loc5_ = 0;
            }
            this._children.addChild(_loc3_);
            _loc2_++;
         }
         var _loc7_:Array = [];
         if(this._currentDialogData.items != null)
         {
            if(this._curentPage == 0 && this._maxPage > 1)
            {
               _loc8_ = {};
               _loc8_.label = "下一页";
               _loc8_.close = false;
               _loc8_.handler = new CFunction(this.nextPageClick);
               _loc7_.push(_loc8_);
            }
            else if(this._curentPage < this._maxPage - 1)
            {
               _loc8_ = {};
               _loc8_.label = "上一页";
               _loc8_.close = false;
               _loc8_.handler = new CFunction(this.previousPageClick);
               _loc7_.push(_loc8_);
               _loc8_ = {};
               _loc8_.label = "下一页";
               _loc8_.close = false;
               _loc8_.handler = new CFunction(this.nextPageClick);
               _loc7_.push(_loc8_);
            }
            else if(this._curentPage == this._maxPage - 1 && this._maxPage != 1)
            {
               _loc8_ = {};
               _loc8_.label = "上一页";
               _loc8_.close = false;
               _loc8_.handler = new CFunction(this.previousPageClick);
               _loc7_.push(_loc8_);
            }
         }
         _loc7_ = _loc7_.concat(this._currentDialogData.buttons);
         _loc4_ = 910 - 60;
         _loc2_ = _loc7_ ? int(_loc7_.length - 1) : -1;
         while(_loc2_ >= 0)
         {
            this._buttons[_loc2_] = this._buttons[_loc2_] || new NPCDialogButton();
            _loc3_ = this._buttons[_loc2_];
            _loc3_.addEventListener(Event.SELECT,this._itemClick);
            _loc3_.data = _loc7_[_loc2_];
            _loc4_ -= _loc3_.width;
            _loc3_.x = _loc4_;
            _loc3_.y = 115;
            _loc4_ -= 10;
            this._children.addChild(_loc3_);
            _loc2_--;
         }
      }
      
      private function getArr(param1:Array, param2:uint = 0, param3:uint = 6) : Array
      {
         return param1.slice(param2 * param3,param2 * param3 + param3);
      }
      
      private function previousPageClick() : void
      {
         --this._curentPage;
         this._showChildren(this._curentPage);
      }
      
      private function nextPageClick() : void
      {
         ++this._curentPage;
         this._showChildren(this._curentPage);
      }
      
      private function _hideChildren() : void
      {
         while(this._children.numChildren > 0)
         {
            this._children.removeChildAt(0);
         }
      }
      
      private function _itemClick(param1:Event) : void
      {
         var _loc5_:CFunction = null;
         var _loc6_:uint = 0;
         var _loc2_:NPCDialogItem = param1.target as NPCDialogItem;
         var _loc3_:Object = _loc2_.data;
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:String = this._hash;
         if(_loc3_.handler)
         {
            _loc5_ = _loc3_.handler;
            _loc5_.invoke();
         }
         if(_loc4_ != this._hash)
         {
            if(_loc3_.close)
            {
               trace("!!对话框改变 所以不关闭");
            }
            if(_loc3_.nextID != -1)
            {
               trace("!!对话框改变 所以不切页");
            }
            return;
         }
         if(_loc3_.nextID != -1 && !_loc3_.close)
         {
            _loc6_ = 0;
            while(_loc6_ < this._dialogs.length)
            {
               if(NPCDialogData(this._dialogs[_loc6_]).id == _loc3_.nextID)
               {
                  this._show(_loc6_);
                  break;
               }
               _loc6_++;
            }
         }
         if(_loc3_.close)
         {
            this.close();
            this._curentPage = 0;
         }
      }
      
      public function getGuideTarget(param1:String) : DisplayObject
      {
         var _loc2_:NPCDialogItem = null;
         var _loc3_:Object = null;
         switch(param1)
         {
            case GuideTargetName.PREV:
               for each(_loc2_ in this._buttons)
               {
                  _loc3_ = _loc2_.data;
                  if(_loc3_)
                  {
                     if(_loc3_.label == "上一页")
                     {
                        return _loc2_;
                     }
                  }
               }
               break;
            case GuideTargetName.NEXT:
               for each(_loc2_ in this._buttons)
               {
                  _loc3_ = _loc2_.data;
                  if(_loc3_)
                  {
                     if(_loc3_.label == "下一页")
                     {
                        return _loc2_;
                     }
                  }
               }
               break;
            case GuideTargetName.CLOSE:
               for each(_loc2_ in this._buttons)
               {
                  _loc3_ = _loc2_.data;
                  if(_loc3_)
                  {
                     if(_loc3_.close)
                     {
                        return _loc2_;
                     }
                  }
               }
         }
         return null;
      }
   }
}

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.ColorMatrixFilter;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormat;

class NPCDialogItem extends Sprite
{
   
   private var _content:Sprite;
   
   private var _data:Object;
   
   public function NPCDialogItem()
   {
      super();
      this.__init(new NPCDialogItemUI(),new TextFormat("宋体",14,16115026,false,false,true));
   }
   
   public function get data() : Object
   {
      return this._data;
   }
   
   public function set data(param1:Object) : void
   {
      this._data = param1 || {};
      this._data.label = this._data.label || "";
      this._data.icon = this._data.icon is Number ? int(this._data.icon) : -1;
      this._data.icon = Math.max(-1,this._data.icon);
      this._data.nextID = this._data.nextID is Number ? int(this._data.nextID) : -1;
      this._data.nextID = Math.max(-1,this._data.nextID);
      this._data.close = this._data.close;
      this._update();
   }
   
   protected function __init(param1:Sprite, param2:TextFormat) : void
   {
      buttonMode = true;
      mouseChildren = false;
      this._content = param1;
      addChild(this._content);
      this._icon.gotoAndStop(1);
      this._text.defaultTextFormat = param2;
      this._text.autoSize = "left";
      this._text.text = "";
      addEventListener(MouseEvent.ROLL_OVER,this.__mouseHandler);
      addEventListener(MouseEvent.ROLL_OUT,this.__mouseHandler);
      addEventListener(MouseEvent.CLICK,this.__mouseHandler);
   }
   
   protected function __mouseHandler(param1:MouseEvent) : void
   {
      switch(param1.type)
      {
         case MouseEvent.ROLL_OVER:
            this._text.textColor = 16777215;
            break;
         case MouseEvent.ROLL_OUT:
            this._text.textColor = 16115026;
            break;
         case MouseEvent.CLICK:
            dispatchEvent(new Event(Event.SELECT));
      }
   }
   
   private function _update() : void
   {
      this._icon.gotoAndStop(this.data.icon + 2);
      this._text.x = this._icon.width;
      this._text.text = this.data.label;
      this._line.x = this._text.x + 2;
      this._line.width = this._text.width - 4;
      this.__mouseHandler(new MouseEvent(MouseEvent.ROLL_OUT));
      this._drawBackground();
   }
   
   private function _drawBackground() : void
   {
      this._content.graphics.clear();
      this._content.graphics.beginFill(0,0);
      this._content.graphics.drawRect(0,0,this._text.x + this._text.width,30);
      this._content.graphics.endFill();
   }
   
   override public function get width() : Number
   {
      return this._text.x + this._text.width;
   }
   
   private function get _line() : MovieClip
   {
      return this._content["line"];
   }
   
   private function get _icon() : MovieClip
   {
      return this._content["icon"];
   }
   
   private function get _text() : TextField
   {
      return this._content["text"];
   }
   
   public function dispose() : void
   {
      removeEventListener(MouseEvent.ROLL_OVER,this.__mouseHandler);
      removeEventListener(MouseEvent.ROLL_OUT,this.__mouseHandler);
      removeEventListener(MouseEvent.CLICK,this.__mouseHandler);
      this.data = {};
      this._content.graphics.clear();
      while(this._content.numChildren > 0)
      {
         this._content.removeChildAt(0);
      }
      removeChild(this._content);
      this._content = null;
   }
}

class NPCDialogButton extends NPCDialogItem
{
   
   public function NPCDialogButton()
   {
      super();
      __init(new NPCDialogButtonUI(),new TextFormat("宋体",15,16115026,true,false,false));
   }
   
   override protected function __mouseHandler(param1:MouseEvent) : void
   {
      switch(param1.type)
      {
         case MouseEvent.ROLL_OVER:
            filters = [new ColorMatrixFilter([1,0,0,0,100,0,1,0,0,100,0,0,1,0,100,0,0,0,1,0]),new GlowFilter(5447538,1,4,4,10,1)];
            break;
         case MouseEvent.ROLL_OUT:
            filters = [new GlowFilter(5447538,1,4,4,10,1)];
            break;
         case MouseEvent.CLICK:
            dispatchEvent(new Event(Event.SELECT));
      }
   }
}
