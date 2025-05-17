package com.QQ.angel.ui.core
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class ScaleWindow extends Window
   {
      
      protected var swc:IScaleWindowContent;
      
      protected var contentPos:Point = new Point(18,30);
      
      protected var borderSize:Point = new Point(50,49);
      
      public function ScaleWindow(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         initialize(param1,null,null,null,param2);
      }
      
      protected function onExtCallClose(... rest) : void
      {
         this.close();
      }
      
      public function addContent(param1:IScaleWindowContent) : void
      {
         if(this.swc != null || param1 == null)
         {
            throw new Error("[ScaleWindow] Error 添加内容为空或已经存在一个SCALEWINDOWCONTENT");
         }
         this.swc = param1;
         var _loc2_:Point = param1.getBGRect();
         addChild(param1.getDisplay());
         param1.addCloseHandler(this.onExtCallClose);
         var _loc3_:InteractiveObject = param1.getDragArea();
         if(_loc3_ != null)
         {
            _loc3_.addEventListener(MouseEvent.MOUSE_DOWN,onStartDrag);
            _loc3_.addEventListener(MouseEvent.MOUSE_UP,onStopDrag);
         }
         if(this.swc is IWindowAware)
         {
            (this.swc as IWindowAware).setWindow(this);
         }
      }
      
      public function setSizeWH(param1:Number, param2:Number) : void
      {
      }
      
      override public function show() : void
      {
         super.show();
         var _loc1_:Object = this.swc;
         if(_loc1_ != null && Boolean(_loc1_.hasOwnProperty("reflash")))
         {
            _loc1_["reflash"]();
         }
      }
      
      override public function close() : void
      {
         var _loc1_:Object = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:InteractiveObject = null;
         if(_closeAction != WindowCloseAction.CLOSE)
         {
            _loc1_ = this.swc;
            if(_loc1_ != null && Boolean(_loc1_.hasOwnProperty("onIdel")))
            {
               _loc1_["onIdel"]();
            }
         }
         else if(this.swc != null)
         {
            _loc2_ = this.swc.getDisplay();
            if(_loc2_ != null && contains(_loc2_))
            {
               removeChild(_loc2_);
            }
            _loc3_ = this.swc.getDragArea();
            if(_loc3_ != null)
            {
               _loc3_.removeEventListener(MouseEvent.MOUSE_DOWN,onStartDrag);
               _loc3_.removeEventListener(MouseEvent.MOUSE_UP,onStopDrag);
            }
            this.swc.dispose();
            this.swc = null;
         }
         super.close();
      }
      
      override public function getContent() : *
      {
         return this.swc;
      }
   }
}

