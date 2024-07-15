package com.QQ.angel.ui.core
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class UIBase extends Sprite
   {
       
      
      protected var _width:Number = 0;
      
      protected var _heigth:Number = 0;
      
      protected var _dobj:DisplayObject;
      
      protected var _inputParamIndex:int;
      
      private var _delayUpdater:DelayUpdateHelper;
      
      private var _cursorType:String = null;
      
      private var _isInit:Boolean = false;
      
      public function UIBase()
      {
         this._delayUpdater = new DelayUpdateHelper(this.onDrawUI);
         super();
      }
      
      protected function initUI() : void
      {
      }
      
      public function setObj(param1:DisplayObject) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(Boolean(this._dobj) && Boolean(this._dobj.parent))
         {
            this._dobj.parent.removeChild(this._dobj);
         }
         this._dobj = param1;
         addChild(this._dobj);
         if(!this._isInit)
         {
            this.initSelf();
         }
      }
      
      private function initSelf() : void
      {
         this._isInit = true;
         this.initUI();
      }
      
      public function replayceObj(param1:DisplayObject) : void
      {
         var _loc2_:int = 0;
         if(param1 == null)
         {
            return;
         }
         this._dobj = param1;
         if(this._dobj.parent != null)
         {
            _loc2_ = this._dobj.parent.getChildIndex(this._dobj);
            this._dobj.parent.addChildAt(this,_loc2_);
         }
         addChild(this._dobj);
         transform.matrix = this._dobj.transform.matrix;
         this._dobj.transform.matrix = new Matrix();
         this.initSelf();
      }
      
      public function get dobj() : DisplayObject
      {
         return this._dobj;
      }
      
      public function get mc() : MovieClip
      {
         return MovieClip(this._dobj);
      }
      
      public function get contentWidth() : Number
      {
         return super.width;
      }
      
      public function get contentHeight() : Number
      {
         return super.height;
      }
      
      override public function set width(param1:Number) : void
      {
         this._width = param1;
         this.commitChange();
      }
      
      override public function set height(param1:Number) : void
      {
         this._heigth = param1;
         this.commitChange();
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function get height() : Number
      {
         return this._heigth;
      }
      
      protected function onDrawUI() : void
      {
      }
      
      final public function drawUI() : void
      {
         this._delayUpdater.validate();
         this.onDrawUI();
      }
      
      public function commitChange() : void
      {
         this._delayUpdater.invalidate();
      }
      
      public function show() : void
      {
      }
      
      public function hide() : void
      {
      }
      
      public function get cursorType() : String
      {
         return this._cursorType;
      }
      
      public function reSize(param1:int, param2:int) : void
      {
      }
      
      public function get isInit() : Boolean
      {
         return this._isInit;
      }
   }
}
