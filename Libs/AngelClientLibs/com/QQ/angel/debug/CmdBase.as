package com.QQ.angel.debug
{
   import com.QQ.angel.debug.menu.CmdItemData;
   import com.QQ.angel.debug.menu.CmdMenu;
   import com.QQ.angel.debug.menu.CmdMenuUtil;
   import com.QQ.angel.debug.menu.input.CmdInputPanel;
   import com.tencent.fge.utils.ArrayUtil;
   import flash.display.DisplayObjectContainer;
   import flash.events.ContextMenuEvent;
   import flash.events.KeyboardEvent;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import flash.utils.Dictionary;
   
   public class CmdBase
   {
      
      private static var ms_mapCmdBase:Dictionary = new Dictionary();
       
      
      protected var m_lstCmdItemData:Array;
      
      protected var m_cmdMenu:CmdMenu;
      
      protected var m_hasBindToContainer:Boolean = false;
      
      private var m_shortcut:uint;
      
      public function CmdBase(param1:String)
      {
         this.m_lstCmdItemData = new Array();
         super();
         ms_mapCmdBase[param1] = this;
         this.m_cmdMenu = new CmdMenu(param1);
         this.m_cmdMenu.initialize();
      }
      
      public static function getCmdBase(param1:String) : CmdBase
      {
         var _loc2_:CmdBase = ms_mapCmdBase[param1];
         if(!_loc2_)
         {
            _loc2_ = new CmdBase(param1);
         }
         return _loc2_;
      }
      
      public static function outputErrorInfo(param1:Array = null) : String
      {
         Debugger.showTips("命令不存在");
         return "命令不存在";
      }
      
      public static function outputCmd(param1:*) : void
      {
         var _loc2_:String = "执行: ";
         if(param1 is String)
         {
            _loc2_ += "$cmd " + param1;
         }
         else if(param1 is Array)
         {
            _loc2_ += "$cmd " + ArrayUtil.array2String(param1);
         }
         Debugger.showLog(_loc2_);
      }
      
      public static function outputReturn(param1:*) : void
      {
         var _loc2_:String = "返回: ";
         if(param1 is String)
         {
            _loc2_ += param1;
         }
         Debugger.showLog(_loc2_);
      }
      
      public function get hasBindToContainer() : Boolean
      {
         return this.m_hasBindToContainer;
      }
      
      private function get container() : DisplayObjectContainer
      {
         return Debugger.container;
      }
      
      public function setSystemMenuItem(param1:String, param2:uint) : void
      {
         var _loc4_:ContextMenuItem = null;
         this.m_shortcut = param2;
         var _loc3_:ContextMenu = null;
         if(this.container)
         {
            _loc3_ = this.container.contextMenu;
            this.container.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         }
         if(!_loc3_)
         {
            _loc3_ = new ContextMenu();
         }
         if(_loc3_)
         {
            _loc4_ = new ContextMenuItem(param1,true);
            _loc3_.customItems.push(_loc4_);
            _loc4_.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,this.openMenu);
            if(this.container)
            {
               this.container.contextMenu = _loc3_;
               this.m_hasBindToContainer = true;
            }
         }
      }
      
      protected function onKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == this.m_shortcut && param1.ctrlKey == true && param1.shiftKey == true)
         {
            this.openMenu(null);
         }
      }
      
      public function reg(param1:Function, param2:*, param3:uint = 0, param4:String = "", param5:Array = null) : void
      {
         var _loc6_:Object = null;
         if(0 == param3)
         {
            this._reg(param1,param2,param3,param4,null,null);
         }
         else
         {
            if(null == param5)
            {
               param5 = new Array();
            }
            param5.unshift({
               "param":["-inputparameters"],
               "name":"输入参数"
            });
            for each(_loc6_ in param5)
            {
               this._reg(param1,param2,param3,param4,_loc6_,param5);
            }
         }
      }
      
      protected function _reg(param1:Function, param2:*, param3:uint = 0, param4:String = "", param5:Object = null, param6:Array = null) : void
      {
         var _loc11_:Object = null;
         var _loc7_:CmdItemData = null;
         var _loc8_:int = 0;
         var _loc9_:Array = this.analyse(param2);
         var _loc10_:Array = null;
         if(null != param5)
         {
            if(param5 is String)
            {
               _loc10_ = (param5 as String).split(",");
               _loc11_ = {
                  "param":"(" + param5 + ")",
                  "name":"(" + param5 + ")"
               };
            }
            else if(param5 is Array)
            {
               _loc10_ = (param5[0] as String).split(",");
               _loc11_ = {
                  "param":"(" + (param5[0] as String).replace(" ","#") + ")",
                  "name":param5[1]
               };
            }
            else
            {
               _loc10_ = param5.param;
               _loc11_ = {
                  "param":this.getNodeParamName(param5),
                  "name":param5.name
               };
            }
            _loc9_.push(_loc11_);
         }
         while(_loc8_ < _loc9_.length)
         {
            if(_loc8_ + 1 == _loc9_.length)
            {
               this.fillItem(_loc7_,_loc9_[_loc8_].param,_loc9_[_loc8_].name,param1,param3,param4,_loc10_,param6);
            }
            else
            {
               _loc7_ = this.fillItem(_loc7_,_loc9_[_loc8_].param,_loc9_[_loc8_].name);
            }
            _loc8_++;
         }
      }
      
      protected function getNodeParamName(param1:Object) : String
      {
         var _loc2_:Array = param1.param;
         var _loc3_:* = "(";
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc3_ += _loc2_[_loc4_];
            if(_loc4_ + 1 < _loc2_.length)
            {
               _loc3_ += ",";
            }
            _loc4_++;
         }
         return _loc3_ + ")";
      }
      
      protected function analyse(param1:*) : Array
      {
         var _loc3_:Array = null;
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc2_:Array = new Array();
         if(param1 is String)
         {
            _loc3_ = (param1 as String).split("/");
            for each(_loc4_ in _loc3_)
            {
               _loc2_.push({
                  "param":_loc4_,
                  "name":_loc4_
               });
            }
         }
         else if(param1 is Array)
         {
            for each(_loc5_ in param1)
            {
               if(_loc5_ is Array)
               {
                  _loc2_.push({
                     "param":_loc5_[0],
                     "name":_loc5_[1]
                  });
               }
               else if(_loc5_ is Object)
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         return _loc2_;
      }
      
      protected function fillItem(param1:CmdItemData, param2:String, param3:String, param4:Function = null, param5:uint = 0, param6:String = "", param7:Array = null, param8:Array = null) : CmdItemData
      {
         var _loc9_:Array = null;
         if(null == param1)
         {
            _loc9_ = this.m_lstCmdItemData;
         }
         else
         {
            _loc9_ = param1.children;
         }
         var _loc10_:CmdItemData = CmdMenuUtil.getCmdItemDataByParam(_loc9_,param2);
         if(null == _loc10_)
         {
            (_loc10_ = new CmdItemData()).name = param3;
            _loc10_.param = param2;
            _loc10_.parent = param1;
            _loc10_.callback = param4;
            _loc10_.callbackParamCount = param5;
            _loc10_.example = param6;
            _loc10_.defaultParams = param7;
            _loc10_.lstDefaultParams = param8;
            _loc9_.splice(0,0,_loc10_);
         }
         else
         {
            _loc10_.callback = param4;
         }
         return _loc10_;
      }
      
      public function execute(param1:Array) : String
      {
         var _loc3_:Function = null;
         var _loc2_:Object = this.getExecuter(param1);
         if(null != _loc2_.callback)
         {
            outputCmd(param1);
            _loc3_ = _loc2_.callback;
            if(_loc3_ != null)
            {
               _loc3_.apply(null,_loc2_.params);
               return "命令执行完成";
            }
            return "命令不存在";
         }
         return this.m_cmdMenu.execute(param1);
      }
      
      protected function getExecuter(param1:Array) : Object
      {
         var _loc4_:CmdItemData = null;
         var _loc2_:Array = this.m_lstCmdItemData;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            if(!(_loc4_ = CmdMenuUtil.getCmdItemDataByParam(_loc2_,param1[_loc3_])))
            {
               if(_loc4_ = CmdMenuUtil.getCmdItemDataByParam(_loc2_,"(-inputparameters)"))
               {
                  return {
                     "callback":_loc4_.callback,
                     "params":param1.slice(param1.length - _loc4_.callbackParamCount,param1.length)
                  };
               }
               return {
                  "callback":outputErrorInfo,
                  "params":[]
               };
            }
            if(_loc3_ + 1 == param1.length - _loc4_.callbackParamCount)
            {
               return {
                  "callback":_loc4_.callback,
                  "params":param1.slice(param1.length - _loc4_.callbackParamCount,param1.length)
               };
            }
            _loc2_ = _loc4_.children;
            _loc3_++;
         }
         if(Boolean(_loc4_) && null != _loc4_.callback)
         {
            CmdInputPanel.instance.open(_loc4_);
         }
         return {
            "callback":null,
            "params":[]
         };
      }
      
      public function openMenu(param1:ContextMenuEvent) : void
      {
         this.m_cmdMenu.execute([]);
      }
      
      public function get lstCmdItemData() : Array
      {
         return this.m_lstCmdItemData;
      }
   }
}
