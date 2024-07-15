package com.QQ.angel.debug.menu
{
   import com.tencent.fge.utils.SWFUtil;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class CmdMenuList extends Sprite
   {
      
      private static var ms_mapMenuList:Dictionary = new Dictionary();
       
      
      private var m_cmd:String;
      
      private var m_lstItem:Array;
      
      private var m_lstItemData:Array;
      
      private var m_bg:Shape;
      
      public function CmdMenuList(param1:String)
      {
         this.m_lstItem = new Array();
         this.m_lstItemData = new Array();
         super();
         this.m_cmd = param1;
         this.update();
      }
      
      private function update() : void
      {
         this.m_lstItemData = CmdMenuUtil.getItemDataListByCmd(this.m_cmd);
         if(this.m_lstItemData.length != this.m_lstItem.length)
         {
            this.removeAllItem();
            this.addAllItem();
         }
         this.updateBackGround();
      }
      
      private function removeAllItem() : void
      {
         var _loc1_:CmdMenuItem = null;
         for each(_loc1_ in this.m_lstItem)
         {
            SWFUtil.safeRemoveChild(this,_loc1_);
         }
         this.m_lstItem.splice(0,this.m_lstItem.length);
      }
      
      private function addAllItem() : void
      {
         var _loc2_:CmdItemData = null;
         var _loc3_:CmdMenuItem = null;
         var _loc1_:Number = 0;
         for each(_loc2_ in this.m_lstItemData)
         {
            _loc3_ = new CmdMenuItem();
            this.m_lstItem.push(_loc3_);
            _loc3_.data = _loc2_;
            this.addChild(_loc3_);
            _loc3_.y = _loc1_;
            _loc1_ += _loc3_.height;
         }
      }
      
      public function show() : void
      {
         var _loc1_:CmdMenuItem = null;
         this.update();
         for each(_loc1_ in this.m_lstItem)
         {
            _loc1_.addEventListener(MouseEvent.CLICK,this.onMouseEvent);
            _loc1_.addEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
            _loc1_.addEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         }
      }
      
      public function hide() : void
      {
         var _loc1_:CmdMenuItem = null;
         for each(_loc1_ in this.m_lstItem)
         {
            _loc1_.removeEventListener(MouseEvent.CLICK,this.onMouseEvent);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseEvent);
            _loc1_.removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseEvent);
         }
      }
      
      public function getIndexByParam(param1:String) : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(this.m_lstItemData)
         {
            _loc3_ = 0;
            while(_loc3_ < this.m_lstItemData.length)
            {
               if(this.m_lstItemData[_loc3_].param == param1)
               {
                  _loc2_ = _loc3_;
               }
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      private function onMouseEvent(param1:MouseEvent) : void
      {
         var _loc3_:CmdMenuEvent = null;
         var _loc2_:CmdMenuItem = param1.currentTarget as CmdMenuItem;
         if(_loc2_)
         {
            switch(param1.type)
            {
               case MouseEvent.CLICK:
                  _loc3_ = new CmdMenuEvent(CmdMenuEvent.CLICK_ITEM);
                  break;
               case MouseEvent.MOUSE_OVER:
                  this.setChildIndex(_loc2_,_loc2_.parent.numChildren - 1);
                  _loc3_ = new CmdMenuEvent(CmdMenuEvent.FOCUS_ITEM);
                  break;
               case MouseEvent.MOUSE_OUT:
            }
         }
         if(_loc3_)
         {
            _loc3_.item = _loc2_;
            this.dispatchEvent(_loc3_);
         }
      }
      
      private function updateBackGround() : void
      {
         if(null == this.m_bg)
         {
            this.m_bg = new Shape();
            this.m_bg.cacheAsBitmap = true;
         }
         this.m_bg.graphics.beginFill(3355443);
         this.m_bg.graphics.drawRect(0,0,CmdMenuItem.ITEM_WIDTH,this.m_lstItem.length * (CmdMenuItem.ITEM_HEIGHT - 2));
         this.m_bg.graphics.endFill();
         this.addChildAt(this.m_bg,0);
      }
   }
}
