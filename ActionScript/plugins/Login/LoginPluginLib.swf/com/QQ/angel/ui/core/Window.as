package com.QQ.angel.ui.core
{
   import com.QQ.angel.api.events.WindowEvent;
   import com.QQ.angel.api.ui.IWindow;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Window extends Sprite implements IWindow
   {
      
      private static var currentID:int = 0;
      
      protected var _id:int;
      
      protected var _state:int;
      
      protected var _closeAction:String;
      
      protected var _container:DisplayObjectContainer;
      
      protected var _bg:Sprite;
      
      protected var _btnClose:SimpleButton;
      
      protected var _content:IWindowContent;
      
      protected var _isModal:Boolean;
      
      protected var _modalBlocker:ModalBlocker;
      
      protected var _dragAreaObject:Sprite;
      
      private var _btnCloseEdgeX:int;
      
      public function Window()
      {
         super();
         this._id = ++Window.currentID;
         this._state = WindowState.INITIALIZING;
         this._closeAction = WindowCloseAction.CLOSE;
      }
      
      public function initialize(param1:DisplayObjectContainer = null, param2:Sprite = null, param3:SimpleButton = null, param4:Sprite = null, param5:Boolean = false) : void
      {
         dispatchEvent(new WindowEvent(WindowEvent.INITIALIZING));
         this._container = param1;
         this._bg = param2;
         this._btnClose = param3;
         this._content = param4 as IWindowContent;
         this._isModal = param5;
         this._modalBlocker = null;
         this.dragAreaObject = this._bg;
         if(this._btnClose != null)
         {
            this._btnClose.addEventListener(MouseEvent.CLICK,this.onClose);
            if(this._bg != null)
            {
               this._btnCloseEdgeX = this._bg.x + this._bg.width - this._btnClose.x - this._btnClose.width;
            }
         }
         if(this._content != null)
         {
            if(this._bg != null)
            {
               addChildAt(this._content as Sprite,getChildIndex(this._bg) + 1);
            }
            else
            {
               addChild(this._content as Sprite);
            }
         }
         this.show();
         this._state = WindowState.INITIALIZED;
         dispatchEvent(new WindowEvent(WindowEvent.INITIALIZED));
      }
      
      public function close() : void
      {
         var _loc1_:IWindow = null;
         var _loc2_:int = 0;
         if(this._state == WindowState.CLOSED)
         {
            return;
         }
         dispatchEvent(new WindowEvent(WindowEvent.CLOSING));
         if(this._closeAction == WindowCloseAction.CLOSE)
         {
            if(this._btnClose != null)
            {
               this._btnClose.removeEventListener(MouseEvent.CLICK,this.onClose);
            }
            this.dragAreaObject = null;
            _loc2_ = 0;
            while(_loc2_ < numChildren)
            {
               _loc1_ = getChildAt(_loc2_) as IWindow;
               if(_loc1_ != null)
               {
                  removeChild(_loc1_ as DisplayObjectContainer);
                  _loc1_.close();
               }
               _loc2_++;
            }
            if(this._isModal && this._modalBlocker != null)
            {
               this._modalBlocker.dispose();
               this._modalBlocker = null;
            }
            if(this._content != null)
            {
               removeChild(this._content as Sprite);
               this._content.dispose();
               this._content = null;
            }
            this._state = WindowState.CLOSED;
         }
         else if(this._closeAction == WindowCloseAction.HIDE)
         {
            this.hide();
            _loc2_ = 0;
            while(_loc2_ < numChildren)
            {
               _loc1_ = getChildAt(_loc2_) as IWindow;
               if(_loc1_ != null)
               {
                  _loc1_.hide();
               }
               _loc2_++;
            }
         }
         dispatchEvent(new WindowEvent(WindowEvent.CLOSED));
      }
      
      public function show() : void
      {
         var _loc2_:IWindow = null;
         this.showToList(this);
         var _loc1_:int = 0;
         while(_loc1_ < numChildren)
         {
            _loc2_ = getChildAt(_loc1_) as IWindow;
            if(_loc2_ != null)
            {
               _loc2_.show();
            }
            _loc1_++;
         }
         dispatchEvent(new WindowEvent(WindowEvent.SHOW));
      }
      
      public function hide() : void
      {
         this.hideFromList(this);
         dispatchEvent(new WindowEvent(WindowEvent.HIDE));
      }
      
      public function moveTo(param1:Number, param2:Number) : void
      {
         this.x = param1;
         this.y = param2;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         if(this._content == null)
         {
            return;
         }
         this._bg.width = param1;
         this._bg.height = param2;
         if(this._btnClose != null)
         {
            this._btnClose.x = this._bg.x + this._bg.width - this._btnCloseEdgeX - this._btnClose.width;
         }
      }
      
      public function bind(param1:IWindow) : Boolean
      {
         var _loc2_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc2_ == null)
         {
            return false;
         }
         addChild(_loc2_);
         return true;
      }
      
      public function unbind(param1:IWindow) : Boolean
      {
         var _loc2_:DisplayObjectContainer = param1 as DisplayObjectContainer;
         if(_loc2_ == null || !contains(_loc2_) && parent != null)
         {
            return false;
         }
         var _loc3_:int = parent.getChildIndex(this) + (getChildIndex(_loc2_) > getChildIndex(this._bg) ? 1 : -1);
         parent.addChildAt(_loc2_,_loc3_);
         return true;
      }
      
      public function center() : void
      {
         var _loc1_:* = WindowManager.STAGE_WIDTH - this.width >> 1;
         var _loc2_:* = WindowManager.STAGE_HEIGHT - this.height >> 1;
         this.moveTo(_loc1_,_loc2_);
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function get initialized() : Boolean
      {
         return this._state == WindowState.INITIALIZED;
      }
      
      public function get isModal() : Boolean
      {
         return this._isModal;
      }
      
      public function get closeAction() : String
      {
         return this._closeAction;
      }
      
      public function set closeAction(param1:String) : void
      {
         this._closeAction = param1;
      }
      
      public function getContent() : *
      {
         return this._content;
      }
      
      override public function toString() : String
      {
         return "[Window: container = " + this._container + ", bg = " + this._bg + ", close button = " + this._btnClose + ", content = " + this._content + ", isModal = " + this._isModal + "]";
      }
      
      public function get modalBlocker() : ModalBlocker
      {
         return this._modalBlocker;
      }
      
      public function set modalBlocker(param1:ModalBlocker) : void
      {
         this._modalBlocker = param1;
      }
      
      public function bringToFront() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._isModal && this._modalBlocker != null)
         {
            parent.setChildIndex(this._modalBlocker,parent.numChildren - 1);
         }
         parent.setChildIndex(this,parent.numChildren - 1);
      }
      
      public function bringWToFront() : void
      {
         if(parent == null)
         {
            return;
         }
         if(this._modalBlocker != null)
         {
            parent.setChildIndex(this._modalBlocker,parent.numChildren - 1);
         }
         parent.setChildIndex(this,parent.numChildren - 1);
      }
      
      public function backToBottom() : void
      {
         if(parent == null)
         {
            return;
         }
         parent.setChildIndex(this,0);
         if(this._isModal && this._modalBlocker != null)
         {
            parent.setChildIndex(this._modalBlocker,0);
         }
      }
      
      public function set dragAreaObject(param1:Sprite) : void
      {
         if(param1 == null)
         {
            if(this._dragAreaObject != null)
            {
               this._dragAreaObject.removeEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
               this._dragAreaObject.removeEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
               this._dragAreaObject.removeEventListener(MouseEvent.MOUSE_OUT,this.onStopDrag);
               this._dragAreaObject = null;
            }
            return;
         }
         this._dragAreaObject = param1;
         this._dragAreaObject.addEventListener(MouseEvent.MOUSE_DOWN,this.onStartDrag);
         this._dragAreaObject.addEventListener(MouseEvent.MOUSE_UP,this.onStopDrag);
         this._dragAreaObject.addEventListener(MouseEvent.MOUSE_OUT,this.onStopDrag);
      }
      
      protected function onStartDrag(param1:MouseEvent) : void
      {
         this.startDrag(false);
         if(this._container != null && this._container == parent)
         {
            this._container.setChildIndex(this,this._container.numChildren - 1);
         }
      }
      
      protected function onStopDrag(param1:MouseEvent) : void
      {
         this.stopDrag();
      }
      
      private function onClose(param1:MouseEvent) : void
      {
         this.close();
      }
      
      private function showToList(param1:Window) : void
      {
         if(this._container == null || param1 == null)
         {
            return;
         }
         if(this._isModal && this._modalBlocker != null && !this._container.contains(this._modalBlocker))
         {
            this._container.addChild(this._modalBlocker);
         }
         if(!this._container.contains(param1))
         {
            this._container.addChild(param1);
         }
         param1.visible = true;
      }
      
      private function hideFromList(param1:Window) : void
      {
         if(this._container == null || param1 == null)
         {
            return;
         }
         if(this._container.contains(param1))
         {
            this._container.removeChild(param1);
         }
         if(this._isModal && this._modalBlocker != null && this._container.contains(this._modalBlocker))
         {
            this._container.removeChild(this._modalBlocker);
         }
         param1.visible = false;
      }
   }
}

