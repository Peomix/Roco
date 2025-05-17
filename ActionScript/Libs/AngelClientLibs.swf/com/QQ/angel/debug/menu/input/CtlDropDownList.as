package com.QQ.angel.debug.menu.input
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class CtlDropDownList extends Sprite
   {
      
      private var MAX_LIST_COUNT:uint = 20;
      
      private var m_lstItem:Array;
      
      private var m_lstData:Array;
      
      public function CtlDropDownList()
      {
         var _loc3_:CtlDropDownItem = null;
         this.m_lstItem = new Array();
         super();
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.MAX_LIST_COUNT)
         {
            _loc3_ = new CtlDropDownItem();
            this.addChild(_loc3_);
            _loc3_.y = _loc1_;
            _loc1_ += _loc3_.height;
            this.m_lstItem.push(_loc3_);
            _loc2_++;
         }
         this.hide();
      }
      
      public function set data(param1:Array) : void
      {
         this.m_lstData = param1;
         this.update();
      }
      
      public function get data() : Array
      {
         return this.m_lstData;
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.MAX_LIST_COUNT)
         {
            if(_loc1_ < this.m_lstData.length)
            {
               this.m_lstItem[_loc1_].name = this.m_lstData[_loc1_];
               this.m_lstItem[_loc1_].visible = true;
            }
            else
            {
               this.m_lstItem[_loc1_].visible = false;
            }
            _loc1_++;
         }
      }
      
      public function show() : void
      {
         var _loc1_:CtlDropDownItem = null;
         this.visible = true;
         for each(_loc1_ in this.m_lstItem)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onItemClick);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         }
      }
      
      public function hide() : void
      {
         var _loc1_:CtlDropDownItem = null;
         this.visible = false;
         for each(_loc1_ in this.m_lstItem)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onItemClick);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOver);
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         var _loc2_:String = (param1.currentTarget as CtlDropDownItem).name;
         CmdInputPanel.instance.onDropDownItemClick(_loc2_);
      }
      
      private function onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:CtlDropDownItem = param1.currentTarget as CtlDropDownItem;
         this.setChildIndex(_loc2_,this.numChildren - 1);
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
   }
}

import com.QQ.angel.debug.menu.CmdMenuItem;
import com.tencent.fge.utils.SWFUtil;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.geom.Rectangle;

class CtlDropDownItem extends CmdMenuItem
{
   
   public static const ITEM_HEIGHT:Number = 24;
   
   public static const ITEM_WIDTH:Number = 198 + 150;
   
   private var m_data:String = "";
   
   public function CtlDropDownItem()
   {
      super();
      m_hItem = ITEM_HEIGHT;
      m_wItem = ITEM_WIDTH;
      this.create();
   }
   
   override public function set name(param1:String) : void
   {
      this.m_data = param1;
      this.updateView();
   }
   
   override public function get name() : String
   {
      return this.m_data;
   }
   
   override protected function updateView() : void
   {
      m_txt.htmlText = "<font size=\'14\'>" + this.m_data + "</font>";
   }
   
   override protected function create() : void
   {
      m_btn = this.createButton();
      m_txt = createTextField();
      SWFUtil.safeAddChild(this,m_btn);
      SWFUtil.safeAddChild(this,m_txt);
   }
   
   override protected function createButton() : SimpleButton
   {
      var _loc1_:Rectangle = new Rectangle(0,0,ITEM_WIDTH,ITEM_HEIGHT);
      var _loc2_:DisplayObject = this.createShape(_loc1_,10066329,0);
      var _loc3_:DisplayObject = this.createShape(_loc1_,11184810,16777088);
      var _loc4_:DisplayObject = this.createShape(_loc1_,14540253,10066329);
      var _loc5_:DisplayObject = this.createShape(_loc1_,14540253,14540253);
      return new SimpleButton(_loc2_,_loc3_,_loc4_,_loc5_);
   }
   
   override protected function createShape(param1:Rectangle, param2:uint, param3:uint) : DisplayObject
   {
      var _loc4_:Shape = new Shape();
      _loc4_.cacheAsBitmap = true;
      _loc4_.graphics.beginFill(param2,1);
      _loc4_.graphics.lineStyle(2,param3);
      _loc4_.graphics.moveTo(param1.left,param1.top);
      _loc4_.graphics.lineTo(param1.right,param1.top);
      _loc4_.graphics.lineTo(param1.right,param1.bottom);
      _loc4_.graphics.lineTo(param1.left,param1.bottom);
      _loc4_.graphics.endFill();
      return _loc4_;
   }
}
