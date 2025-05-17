package com.QQ.angel.debug.menu
{
   import com.QQ.angel.debug.CmdBase;
   import com.QQ.angel.debug.Debugger;
   import com.QQ.angel.debug.menu.input.CmdInputPanel;
   import com.tencent.fge.utils.SWFUtil;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   
   public class CmdMenu extends Sprite
   {
      
      public static const MENU_LEFT:Number = 0;
      
      public static const MENU_TOP:Number = 100;
      
      private var m_mapCmdMenuList:Dictionary = new Dictionary();
      
      private var m_lstCmd:Array = new Array();
      
      private var m_lstCmdMenuList:Array = new Array();
      
      private var m_rootCmdMenuList:CmdMenuList;
      
      private var m_bActive:Boolean = false;
      
      private var m_lable:String = "";
      
      private var m_bg:Sprite = null;
      
      public function CmdMenu(param1:String)
      {
         this.m_lable = param1;
         super();
      }
      
      public function get label() : String
      {
         return this.m_lable;
      }
      
      public function initialize() : void
      {
         this.m_rootCmdMenuList = new CmdMenuList(this.m_lable);
         this.m_rootCmdMenuList.x = MENU_LEFT;
         this.m_rootCmdMenuList.y = MENU_TOP;
      }
      
      private function get container() : DisplayObjectContainer
      {
         return Debugger.container;
      }
      
      public function activiate() : void
      {
         if(!this.m_bActive)
         {
            this.m_bActive = true;
            SWFUtil.safeAddChild(this.container,this.bg);
            SWFUtil.safeAddChild(this.container,this);
            if(Boolean(this.container) && Boolean(this.container.stage))
            {
               this.container.stage.addEventListener(MouseEvent.CLICK,this.onClick);
            }
         }
      }
      
      public function deactiviate() : void
      {
         if(this.m_bActive)
         {
            this.m_bActive = false;
            this.removeAllMenuList();
            SWFUtil.safeRemoveChild(this.container,this.bg);
            SWFUtil.safeRemoveChild(this.container,this);
            if(Boolean(this.container) && Boolean(this.container.stage))
            {
               this.container.stage.removeEventListener(MouseEvent.CLICK,this.onClick);
            }
         }
      }
      
      public function get bg() : Sprite
      {
         if(null == this.m_bg)
         {
            this.m_bg = new Sprite();
            this.m_bg.cacheAsBitmap;
            this.m_bg.graphics.beginFill(0,0.5);
            this.m_bg.graphics.drawRect(0,0,1000,600);
            this.m_bg.graphics.endFill();
         }
         return this.m_bg;
      }
      
      public function execute(param1:Array) : String
      {
         this.activiate();
         this.removeAllMenuList();
         this.addAllMenuList(param1);
         return "显示菜单";
      }
      
      private function removeAllMenuList() : void
      {
         var _loc1_:CmdMenuList = null;
         this.m_rootCmdMenuList.hide();
         this.m_rootCmdMenuList.addEventListener(CmdMenuEvent.CLICK_ITEM,this.onMenuEvent);
         this.m_rootCmdMenuList.addEventListener(CmdMenuEvent.FOCUS_ITEM,this.onMenuEvent);
         SWFUtil.safeRemoveChild(this,this.m_rootCmdMenuList);
         for each(_loc1_ in this.m_lstCmdMenuList)
         {
            _loc1_.removeEventListener(CmdMenuEvent.CLICK_ITEM,this.onMenuEvent);
            _loc1_.removeEventListener(CmdMenuEvent.FOCUS_ITEM,this.onMenuEvent);
            _loc1_.hide();
            SWFUtil.safeRemoveChild(this,_loc1_);
         }
         this.m_lstCmdMenuList.splice(0,this.m_lstCmdMenuList.length);
      }
      
      private function addAllMenuList(param1:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:CmdMenuList = null;
         var _loc6_:int = 0;
         this.m_rootCmdMenuList.show();
         this.m_rootCmdMenuList.addEventListener(CmdMenuEvent.CLICK_ITEM,this.onMenuEvent);
         this.m_rootCmdMenuList.addEventListener(CmdMenuEvent.FOCUS_ITEM,this.onMenuEvent);
         SWFUtil.safeAddChild(this,this.m_rootCmdMenuList);
         var _loc2_:CmdMenuList = this.m_rootCmdMenuList;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = CmdMenuUtil.getCmdByParams(this.m_lable,param1.slice(0,_loc3_ + 1));
            _loc5_ = this.m_mapCmdMenuList[_loc4_];
            if(null == _loc5_)
            {
               _loc5_ = new CmdMenuList(_loc4_);
               this.m_mapCmdMenuList[_loc4_] = _loc5_;
            }
            this.m_lstCmdMenuList.push(_loc5_);
            _loc5_.addEventListener(CmdMenuEvent.CLICK_ITEM,this.onMenuEvent);
            _loc5_.addEventListener(CmdMenuEvent.FOCUS_ITEM,this.onMenuEvent);
            _loc5_.show();
            SWFUtil.safeAddChild(this,_loc5_);
            _loc6_ = _loc2_.getIndexByParam(param1[_loc3_]);
            _loc5_.x = _loc2_.x + CmdMenuItem.ITEM_WIDTH - 5;
            _loc5_.y = _loc2_.y + _loc6_ * CmdMenuItem.ITEM_HEIGHT;
            if(_loc5_.y + _loc5_.height > 600)
            {
               _loc5_.y = 600 - _loc5_.height;
            }
            _loc2_ = _loc5_;
            _loc3_++;
         }
      }
      
      private function addOneMenuList(param1:String) : void
      {
         var _loc2_:CmdMenuList = new CmdMenuList(param1);
         this.m_mapCmdMenuList[param1] = _loc2_;
      }
      
      private function onMenuEvent(param1:CmdMenuEvent) : void
      {
         switch(param1.type)
         {
            case CmdMenuEvent.CLICK_ITEM:
               this.onClickItem(param1.item);
               break;
            case CmdMenuEvent.FOCUS_ITEM:
               this.onFocusItem(param1.item);
         }
      }
      
      private function onClickItem(param1:CmdMenuItem) : void
      {
         var _loc2_:String = null;
         if(Boolean(param1) && null != param1.data.callback)
         {
            if(0 == param1.data.callbackParamCount)
            {
               CmdBase.outputCmd(param1.data.lstPath);
               param1.data.invokeCallback(null);
               this.deactiviate();
            }
            else if(param1.data.defaultParams && param1.data.defaultParams.length == param1.data.callbackParamCount && "-inputparameters" != param1.data.defaultParams[0])
            {
               CmdBase.outputCmd(param1.data.lstPath);
               param1.data.invokeCallback(param1.data.defaultParams);
               this.deactiviate();
            }
            else
            {
               CmdInputPanel.instance.open(param1.data);
            }
         }
      }
      
      private function onFocusItem(param1:CmdMenuItem) : void
      {
         if(Boolean(param1) && Boolean(param1.data))
         {
            this.execute(param1.data.lstPath);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         if(!this.hitTestPoint(param1.stageX,param1.stageY))
         {
            this.deactiviate();
         }
      }
   }
}

