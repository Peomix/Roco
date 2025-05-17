package com.QQ.angel.ui.core
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.events.WindowEvent;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.ui.IBubble;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.ILoadingView;
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.DazzleDressDataDes;
   import com.QQ.angel.data.entity.DressUpItemDes;
   import com.QQ.angel.data.entity.FurnitureDes;
   import com.QQ.angel.data.entity.ItemRewardData;
   import com.QQ.angel.data.entity.NPCDialogData;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.data.entity.combatsys.SpiritEquipmentDes;
   import com.QQ.angel.data.npc.NpcDialogCenter;
   import com.QQ.angel.ui.core.bubbles.WorldMapBubbleSkin;
   import com.QQ.angel.ui.core.paopao.PaoPaoView;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.utils.Dictionary;
   
   public class WindowManager implements ICommUIManager
   {
      
      public static const BASE_WINDOW:int = 1;
      
      public static const ALERT:int = 2;
      
      public static const DIALOG:int = 3;
      
      public static const LOADING_PANEL:int = 4;
      
      public static const ITEM_LOADING_PANEL:int = 5;
      
      public static const SIMPLE_LOADING:int = 6;
      
      public static const STAGE_WIDTH:int = 960;
      
      public static const STAGE_HEIGHT:int = 560;
      
      private var _container:DisplayObjectContainer;
      
      private var _windows:Array;
      
      private var _modalBlocker:ModalBlocker;
      
      private var _winCache:Dictionary;
      
      private var _winClsMap:Dictionary;
      
      private var _bubbleSkinCls:Dictionary;
      
      public function WindowManager(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         this._windows = [];
         this._modalBlocker = null;
         this._winCache = new Dictionary();
         this._winClsMap = new Dictionary();
         this._winClsMap[LOADING_PANEL] = LoadingPanel;
         this._winClsMap[ITEM_LOADING_PANEL] = ItemLoadingPanel;
         this._winClsMap[SIMPLE_LOADING] = SimpleLoading;
         this._winClsMap[7] = NumericPanel;
         this._winClsMap[8] = ItemRewardPanel;
         this._winClsMap[9] = NPCDialogPanel;
         this._bubbleSkinCls = new Dictionary();
         this._bubbleSkinCls[BubbleSkinType.RECT] = BubbleRectSkin;
         this._bubbleSkinCls[BubbleSkinType.ROUND_RECT] = BubbleRoundRectSkin;
         this._bubbleSkinCls[BubbleSkinType.ROUND_RECT_WITH_ARROW] = BubbleRoundRectWithArrowSkin;
         this._bubbleSkinCls[BubbleSkinType.GAME_RECT] = BubbleGameRectSkin;
         this._bubbleSkinCls[BubbleSkinType.COMBAT_ITEMS] = BubbleCombatTooltipSkin;
         this._bubbleSkinCls[BubbleSkinType.COMBAT_BUFF] = BubbleCombatBuffTooltipSkin;
         this._bubbleSkinCls[BubbleSkinType.WORLD_MAP] = WorldMapBubbleSkin;
         this._bubbleSkinCls[BubbleSkinType.ROLE_TALK] = PaoPaoView;
         this._bubbleSkinCls[BubbleSkinType.ROLE_COMMON_TALK] = BubbleRoundRectWithArrowSkin;
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_ITEM_UPDATE,WindowManager.onNpcDialogUpdate,this);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_BUTTON_UPDATE,WindowManager.onNpcDialogUpdate,this);
      }
      
      private static function onNpcDialogUpdate(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc8_:NPCDialogData = null;
         var _loc5_:Array = param2 as Array;
         var _loc6_:WindowManager = WindowManager(param4);
         var _loc7_:String = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_NPC_DIALOG) as String;
         if(_loc5_[0] == _loc7_)
         {
            _loc8_ = NpcDialogCenter.getSingleton().getNPCDialogDataByHashClone(_loc7_);
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_WORLD_ON_A_NPC_DIALOG_PREPARED_TO_OPEN,[null,_loc8_]);
            _loc6_.showManagedWin(9,_loc8_);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public function showFurnitureRewardArray(param1:Array, param2:Function = null) : void
      {
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         var _loc3_:ItemRewardData = new ItemRewardData();
         _loc3_.items = [];
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         for(; _loc5_ < _loc4_; _loc5_++)
         {
            _loc6_ = param1[_loc5_];
            if(!(_loc6_ == null || _loc6_.count <= 0))
            {
               if(_loc6_.name == null || _loc6_.name == "")
               {
                  _loc7_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.FURNITURE_LIST_DATA).select(_loc6_.id);
                  if(!((Boolean(_loc7_)) && _loc7_.name != null))
                  {
                     this.alert("Error","家具配置有误 id:" + _loc6_.id);
                     continue;
                  }
                  _loc6_.name = _loc7_.name;
               }
               _loc3_.items.push({
                  "num":_loc6_.count,
                  "src":DEFINE.PLUGIN_ROOT + "/Home/furniture/" + _loc6_.id + "/" + _loc6_.id + "_icon.png",
                  "tooltip":_loc6_.name,
                  "name":_loc6_.name,
                  "infoTxt":"<b><font color=\"#ff0000\">" + _loc6_.name + "</font>x" + _loc6_.count + "已放入你的家居仓库</b>"
               });
            }
         }
         if(_loc3_.items.length)
         {
            this.showManagedWin(8,_loc3_,param2 == null ? null : new CFunction(param2));
         }
      }
      
      public function showRewardArray(param1:Array, param2:Function = null) : void
      {
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:Object = null;
         var _loc12_:DressUpItemDes = null;
         var _loc13_:SpiritDes = null;
         var _loc14_:FurnitureDes = null;
         var _loc15_:SpiritEquipmentDes = null;
         var _loc3_:ItemRewardData = new ItemRewardData();
         _loc3_.items = [];
         var _loc4_:int = int(param1.length);
         var _loc9_:int = -1;
         var _loc10_:int = 0;
         for(; _loc10_ < _loc4_; _loc10_++)
         {
            _loc11_ = param1[_loc10_];
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = 0;
            _loc9_ = -1;
            if(_loc11_ != null)
            {
               if(_loc11_.hasOwnProperty("count"))
               {
                  _loc7_ = int(_loc11_.count);
               }
               else if(_loc11_.hasOwnProperty("itemCount"))
               {
                  _loc7_ = int(_loc11_.itemCount);
               }
               else if(_loc11_.hasOwnProperty("num"))
               {
                  _loc7_ = int(_loc11_.num);
               }
               if(_loc11_.hasOwnProperty("type"))
               {
                  _loc9_ = int(_loc11_.type);
               }
               if(!(Boolean(_loc11_.hasOwnProperty("itemType")) && _loc11_.itemType == 6 || _loc9_ == 7))
               {
                  if(_loc7_ <= 0)
                  {
                     continue;
                  }
               }
               if(_loc11_.hasOwnProperty("id"))
               {
                  _loc6_ = int(_loc11_.id);
               }
               else if(_loc11_.hasOwnProperty("itemId"))
               {
                  _loc6_ = int(_loc11_.itemId);
               }
               else if(_loc11_.hasOwnProperty("equipItemId"))
               {
                  _loc8_ = int(_loc11_.equipItemId);
               }
               if(Boolean(_loc11_.hasOwnProperty("itemType")) && _loc11_.itemType == 6)
               {
                  _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.DAZZLE_DRESS_DATA).select(_loc6_);
                  if(_loc5_ != null)
                  {
                     _loc3_.items.push({
                        "num":1,
                        "src":DEFINE.DAZZLE_DRESS_RES_ROOT + _loc5_.type + "/" + _loc5_.id + "_bag.png",
                        "tooltip":_loc5_.name,
                        "name":_loc5_.name + "(" + DazzleDressDataDes.timeLimitString[_loc7_] + ")"
                     });
                  }
               }
               else if(_loc9_ == -1)
               {
                  _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA).select(_loc6_);
                  if(_loc5_ != null)
                  {
                     _loc3_.items.push({
                        "num":_loc7_,
                        "src":_loc5_.url,
                        "tooltip":_loc5_.name,
                        "name":_loc5_.name
                     });
                  }
                  else
                  {
                     _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA).select(_loc6_);
                     if(_loc5_ != null)
                     {
                        _loc13_ = _loc5_ as SpiritDes;
                        _loc3_.items.push({
                           "level":_loc7_,
                           "src":_loc13_.iconSrc,
                           "tooltip":_loc13_.name,
                           "name":_loc13_.name,
                           "infoTxt":"<b>恭喜你获得<font color=\"#ff0000\">" + _loc13_.name + "</font>(" + _loc7_ + "级)</b>"
                        });
                     }
                     else
                     {
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.FURNITURE_LIST_DATA).select(_loc6_);
                        if(_loc5_ != null)
                        {
                           _loc14_ = _loc5_ as FurnitureDes;
                           _loc3_.items.push({
                              "num":_loc7_,
                              "src":DEFINE.PLUGIN_ROOT + "/Home/furniture/" + _loc6_ + "/" + _loc6_ + "_icon.png",
                              "tooltip":_loc14_.name,
                              "name":_loc14_.name,
                              "infoTxt":"<b><font color=\"#ff0000\">" + _loc14_.name + "</font>x" + _loc7_ + "已放入你的家居仓库</b>"
                           });
                        }
                        else
                        {
                           _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.DRESSUP_LIST_DATA).select(_loc6_);
                           if(_loc5_ != null)
                           {
                              _loc12_ = _loc5_ as DressUpItemDes;
                              _loc3_.items.push({
                                 "num":_loc7_,
                                 "src":DEFINE.COMM_ROOT + "res/ext/dressup/icon/" + _loc6_.toString(16) + ".png",
                                 "tooltip":_loc12_.name,
                                 "name":_loc12_.name,
                                 "infoTxt":"<b><font color=\"#ff0000\">" + _loc12_.name + "</font>x" + _loc7_ + "已放入你的超级星工场</b>"
                              });
                           }
                           else
                           {
                              _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SEQUIP_DES_DATA).select(_loc8_);
                              if(_loc5_ != null)
                              {
                                 _loc15_ = _loc5_ as SpiritEquipmentDes;
                                 _loc3_.items.push({
                                    "num":_loc7_,
                                    "src":_loc15_.src,
                                    "tooltip":_loc15_.name,
                                    "name":_loc15_.name,
                                    "infoTxt":"<b><font color=\"#ff0000\">" + _loc15_.name + "</font>x" + _loc7_ + "已放入你的宠物背包</b>"
                                 });
                              }
                              else
                              {
                                 this.alert("Error",_loc6_ + "未找到该物品配置");
                              }
                           }
                        }
                     }
                  }
               }
               else
               {
                  switch(_loc9_)
                  {
                     case 0:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":_loc5_.url,
                           "tooltip":_loc5_.name,
                           "name":_loc5_.name
                        });
                        continue;
                     case 1:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":_loc5_.url,
                           "tooltip":_loc5_.name,
                           "name":_loc5_.name
                        });
                        continue;
                     case 2:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":_loc5_.url,
                           "tooltip":_loc5_.name,
                           "name":_loc5_.name
                        });
                        continue;
                     case 3:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.FURNITURE_LIST_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc14_ = _loc5_ as FurnitureDes;
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":DEFINE.PLUGIN_ROOT + "/Home/furniture/" + _loc6_ + "/" + _loc6_ + "_icon.png",
                           "tooltip":_loc14_.name,
                           "name":_loc14_.name,
                           "infoTxt":"<b><font color=\"#ff0000\">" + _loc14_.name + "</font>x" + _loc7_ + "已放入你的家居仓库</b>"
                        });
                        continue;
                     case 4:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SPIRIT_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc13_ = _loc5_ as SpiritDes;
                        _loc3_.items.push({
                           "level":_loc7_,
                           "src":_loc13_.iconSrc,
                           "tooltip":_loc13_.name,
                           "name":_loc13_.name,
                           "infoTxt":"<b>恭喜你获得<font color=\"#ff0000\">" + _loc13_.name + "</font>(" + _loc7_ + "级)</b>"
                        });
                        continue;
                     case 5:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ITEM_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":_loc5_.url,
                           "tooltip":_loc5_.name,
                           "name":_loc5_.name
                        });
                        continue;
                     case 6:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.SEQUIP_DES_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc15_ = _loc5_ as SpiritEquipmentDes;
                        _loc3_.items.push({
                           "num":_loc7_,
                           "src":_loc15_.src,
                           "tooltip":_loc15_.name,
                           "name":_loc15_.name,
                           "infoTxt":"<b><font color=\"#ff0000\">" + _loc15_.name + "</font>x" + _loc7_ + "已放入你的宠物背包</b>"
                        });
                        continue;
                     case 7:
                        _loc5_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.DAZZLE_DRESS_DATA).select(_loc6_);
                        if(_loc5_ == null)
                        {
                           break;
                        }
                        _loc3_.items.push({
                           "num":1,
                           "src":DEFINE.DAZZLE_DRESS_RES_ROOT + _loc5_.type + "/" + _loc5_.id + "_bag.png",
                           "tooltip":_loc5_.name,
                           "name":_loc5_.name + "(" + DazzleDressDataDes.timeLimitString[_loc7_] + ")"
                        });
                        continue;
                  }
                  this.alert("Error",_loc6_ + "未找到该物品配置");
               }
            }
         }
         if(_loc3_.items.length)
         {
            this.showManagedWin(8,_loc3_,param2 == null ? null : new CFunction(param2));
         }
      }
      
      public function createLoadingView(param1:int = 0, param2:Boolean = false) : ILoadingView
      {
         return this.showManagedWin(param1,null,null) as ILoadingView;
      }
      
      public function showManagedWin(param1:int, param2:Object = null, param3:CFunction = null) : IWindow
      {
         var _loc5_:Class = null;
         var _loc6_:IManagedWin = null;
         var _loc4_:IWindow = this._winCache[param1] as IWindow;
         if(_loc4_ == null)
         {
            _loc5_ = this._winClsMap[param1] as Class;
            if(_loc5_ == null)
            {
               return null;
            }
            if(param1 == 8 || param1 == 2)
            {
               _loc4_ = this.createWindow(_loc5_,true,this._sysWinContainer);
            }
            else
            {
               _loc4_ = this.createWindow(_loc5_,true);
            }
            _loc4_.closeAction = WindowCloseAction.HIDE;
            this._winCache[param1] = _loc4_;
         }
         else
         {
            _loc4_.show();
            _loc4_.bringToFront();
         }
         if(_loc4_ is IManagedWin)
         {
            _loc6_ = _loc4_ as IManagedWin;
            _loc6_.bindHandler(param3);
            _loc6_.setData(param2);
         }
         return _loc4_;
      }
      
      public function alert(param1:String, param2:String, param3:int = 1, param4:CFunction = null) : int
      {
         var _loc5_:IWindow = this.createAlert(param1,param2,param3,param4);
         return _loc5_.id;
      }
      
      public function mAlert(param1:MovieClip, param2:String = "", param3:String = "", param4:Function = null, param5:Function = null) : IWindow
      {
         var _loc6_:MAlert = this.createWindow(MAlert) as MAlert;
         _loc6_.init(param1,param2,param3,param4,param5);
         _loc6_.show();
         return _loc6_;
      }
      
      public function createWindow(param1:*, param2:Boolean = false, param3:DisplayObjectContainer = null) : IWindow
      {
         var _loc4_:IWindow = null;
         if(param3 == null)
         {
            param3 = this._container;
         }
         if(param1 != null)
         {
            if(param2)
            {
               _loc4_ = new param1(param3,true) as IWindow;
            }
            else
            {
               _loc4_ = new param1(param3) as IWindow;
            }
         }
         else
         {
            _loc4_ = new Window();
         }
         this.registerWindow(_loc4_ as Window,param3);
         return _loc4_;
      }
      
      public function createScaleWinow(param1:*, param2:Boolean = false) : IWindow
      {
         var _loc3_:ScaleWindow = null;
         if(param1 is IScaleWindowContent)
         {
            _loc3_ = this.createWindow(ScaleWindow,param2) as ScaleWindow;
            _loc3_.addContent(param1 as IScaleWindowContent);
            return _loc3_;
         }
         return null;
      }
      
      public function closeWindow(param1:IWindow) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.close();
      }
      
      public function closeWindowByID(param1:int) : void
      {
         var _loc2_:Window = null;
         var _loc3_:int = int(this._windows.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._windows[_loc4_].id == param1)
            {
               _loc2_ = this._windows[_loc4_];
               break;
            }
            _loc4_++;
         }
         if(_loc2_ is IWindow)
         {
            this.closeWindow(_loc2_);
         }
      }
      
      public function createBubble(param1:int) : IBubble
      {
         var _loc2_:IBubble = null;
         if(param1 == BubbleSkinType.ROLE_COMMON_TALK)
         {
            _loc2_ = new TalkBubble();
         }
         else
         {
            _loc2_ = new Bubble();
         }
         var _loc3_:Class = this._bubbleSkinCls[param1];
         if(_loc3_ == null)
         {
            return _loc2_;
         }
         _loc2_.setSkin(new _loc3_() as IBubbleSkin);
         return _loc2_;
      }
      
      public function createMiniLoading() : ILoadingView
      {
         return this.createLoadingView(SIMPLE_LOADING,true);
      }
      
      public function closeMiniLoading() : void
      {
         var _loc1_:IWindow = this._winCache[SIMPLE_LOADING];
         if(_loc1_ != null)
         {
            this.closeWindow(_loc1_);
         }
      }
      
      public function closeAllWindows() : void
      {
         var _loc1_:Window = null;
         var _loc2_:Array = this._windows.concat();
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc1_ = _loc2_[_loc4_];
            this.closeWindow(_loc1_);
            _loc4_++;
         }
         _loc2_ = null;
      }
      
      public function createBaseWindow() : IWindow
      {
         if(this._container == null)
         {
            return null;
         }
         var _loc1_:IWindow = new BaseWindow(this._container);
         this.registerWindow(_loc1_ as Window);
         return _loc1_;
      }
      
      public function createAlert(param1:String = "", param2:String = "", param3:int = 1, param4:CFunction = null) : IWindow
      {
         if(this._sysWinContainer == null)
         {
            return null;
         }
         var _loc5_:IWindow = new Alert(this._sysWinContainer,param1,param2,param3,param4);
         this.registerWindow(_loc5_ as Window,this._sysWinContainer);
         return _loc5_;
      }
      
      public function createDialog(param1:Boolean = false, param2:String = "") : IWindow
      {
         if(this._container == null)
         {
            return null;
         }
         var _loc3_:IWindow = new Dialog(this._container,param1,param2);
         this.registerWindow(_loc3_ as Window);
         return _loc3_;
      }
      
      public function clear() : void
      {
         var _loc2_:IWindow = null;
         var _loc1_:int = int(this._windows.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._windows[_loc3_];
            this.unregisterWindow(_loc2_ as Window);
            _loc2_.close();
            _loc2_ = null;
            _loc3_++;
         }
         this._windows = [];
      }
      
      private function registerWindow(param1:Window, param2:DisplayObjectContainer = null) : void
      {
         var _loc3_:ModalBlocker = null;
         var _loc4_:int = 0;
         var _loc5_:IWindow = null;
         var _loc6_:int = 0;
         if(param1 == null)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = this._container;
         }
         param1.addEventListener(WindowEvent.CLOSED,this.onCloseWindow);
         this._windows.push(param1);
         if(param1.isModal)
         {
            _loc3_ = new ModalBlocker(param2);
            param2.addChild(_loc3_);
            param1.modalBlocker = _loc3_;
            param2.addChild(param1);
         }
         else
         {
            param2.addChildAt(param1,0);
            _loc4_ = param2.numChildren;
            _loc6_ = _loc4_ - 1;
            while(_loc6_ >= 0)
            {
               _loc5_ = param2.getChildAt(_loc6_) as IWindow;
               if(_loc5_ is Window && _loc5_ != param1 && !_loc5_.isModal)
               {
                  param2.removeChild(param1);
                  param2.addChildAt(param1,_loc6_);
                  break;
               }
               _loc6_--;
            }
         }
      }
      
      private function unregisterWindow(param1:Window) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.removeEventListener(WindowEvent.CLOSED,this.onCloseWindow);
         var _loc2_:int = int(this._windows.length);
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if(this._windows[_loc4_] == param1)
            {
               this._windows.splice(_loc4_,1);
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(this._container != null)
         {
            if(this._container.contains(param1))
            {
               this._container.removeChild(param1);
            }
            else
            {
               trace("[WindowManager] Warning: This window is not found in the container !!!");
            }
            if(param1.isModal && param1.modalBlocker != null && this._container.contains(param1.modalBlocker))
            {
               this._container.removeChild(param1.modalBlocker);
            }
            else
            {
               trace("[WindowManager] Warning: Modal blocker of this window is not found in the container !!!");
            }
         }
         if(this._sysWinContainer != null)
         {
            if(this._sysWinContainer.contains(param1))
            {
               this._sysWinContainer.removeChild(param1);
            }
            else
            {
               trace("[WindowManager] Warning: This window is not found in the container !!!");
            }
            if(param1.isModal && param1.modalBlocker != null && this._sysWinContainer.contains(param1.modalBlocker))
            {
               this._sysWinContainer.removeChild(param1.modalBlocker);
            }
            else
            {
               trace("[WindowManager] Warning: Modal blocker of this window is not found in the container !!!");
            }
         }
      }
      
      private function onCloseWindow(param1:WindowEvent) : void
      {
         var _loc2_:Window = param1.target as Window;
         if(_loc2_ != null && _loc2_.closeAction == WindowCloseAction.CLOSE)
         {
            this.unregisterWindow(_loc2_);
         }
      }
      
      private function get _sysWinContainer() : DisplayObjectContainer
      {
         return __global.SysAPI.getUISysAPI().getEffectContainer(1);
      }
   }
}

