package com.QQ.angel.debug.menu
{
   import com.tencent.fge.utils.SWFUtil;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class CmdMenuItem extends Sprite
   {
      
      public static const ITEM_HEIGHT:Number = 24;
      
      public static const ITEM_WIDTH:Number = 160;
       
      
      protected var m_btn:SimpleButton;
      
      protected var m_txt:TextField;
      
      protected var m_arrow:DisplayObject;
      
      private var m_data:CmdItemData;
      
      protected var m_hItem:Number;
      
      protected var m_wItem:Number;
      
      public function CmdMenuItem()
      {
         super();
         this.m_hItem = ITEM_HEIGHT;
         this.m_wItem = ITEM_WIDTH;
         this.create();
      }
      
      public function set data(param1:CmdItemData) : void
      {
         this.m_data = param1;
         this.updateView();
      }
      
      public function get data() : CmdItemData
      {
         return this.m_data;
      }
      
      protected function updateView() : void
      {
         this.m_txt.htmlText = "<font size=\'14\'>" + this.m_data.name + "</font>";
         if(this.m_data.children.length > 0)
         {
            this.m_arrow.visible = true;
         }
         else
         {
            this.m_arrow.visible = false;
         }
      }
      
      protected function create() : void
      {
         this.m_btn = this.createButton();
         this.m_txt = this.createTextField();
         this.m_arrow = this.createArrow();
         SWFUtil.safeAddChild(this,this.m_btn);
         SWFUtil.safeAddChild(this,this.m_arrow);
         SWFUtil.safeAddChild(this,this.m_txt);
      }
      
      protected function createButton() : SimpleButton
      {
         var _loc1_:Rectangle = new Rectangle(0,0,ITEM_WIDTH,ITEM_HEIGHT);
         var _loc2_:DisplayObject = this.createShape(_loc1_,14540253,14540253);
         var _loc3_:DisplayObject = this.createShape(_loc1_,15658734,6750207);
         var _loc4_:DisplayObject = this.createShape(_loc1_,10066329,10066329);
         var _loc5_:DisplayObject = this.createShape(_loc1_,14540253,14540253);
         return new SimpleButton(_loc2_,_loc3_,_loc4_,_loc5_);
      }
      
      protected function createShape(param1:Rectangle, param2:uint, param3:uint) : DisplayObject
      {
         var _loc4_:Shape;
         (_loc4_ = new Shape()).cacheAsBitmap = true;
         _loc4_.graphics.beginFill(param2,0.6);
         _loc4_.graphics.lineStyle(2,param3);
         _loc4_.graphics.moveTo(param1.left,param1.top);
         _loc4_.graphics.lineTo(param1.right,param1.top);
         _loc4_.graphics.lineTo(param1.right,param1.bottom);
         _loc4_.graphics.lineTo(param1.left,param1.bottom);
         _loc4_.graphics.endFill();
         return _loc4_;
      }
      
      protected function createTextField() : TextField
      {
         var _loc1_:TextField = new TextField();
         _loc1_.autoSize = TextFieldAutoSize.LEFT;
         _loc1_.multiline = false;
         _loc1_.mouseEnabled = _loc1_.selectable = false;
         _loc1_.x = 2;
         _loc1_.y = 3;
         return _loc1_;
      }
      
      protected function createArrow() : DisplayObject
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0);
         _loc1_.graphics.lineStyle(1,0);
         _loc1_.graphics.moveTo(0,0);
         _loc1_.graphics.lineTo(3,3);
         _loc1_.graphics.lineTo(0,6);
         _loc1_.graphics.endFill();
         _loc1_.x = 150;
         _loc1_.y = 9;
         return _loc1_;
      }
      
      override public function get height() : Number
      {
         return super.height - 2;
      }
   }
}
