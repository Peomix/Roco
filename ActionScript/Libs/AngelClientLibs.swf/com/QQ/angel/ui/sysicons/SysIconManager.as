package com.QQ.angel.ui.sysicons
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.data.CALLBACK;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   
   public class SysIconManager implements ISysIconManager
   {
      
      private static var __iconManager:SysIconManager;
      
      private var _container:DisplayObjectContainer;
      
      private var _topLeftIcons:TopLeftIconGroup;
      
      private var _topRightIcons:TopRightIconGroup;
      
      private var _topLeftSubIcons:TopLeftSubIconGroup;
      
      private var _giftPacksIcons:GiftPacksIconGroup;
      
      private var _absoluteContainer:Sprite;
      
      private var _newWorldIcons:TopLeftIconGroup;
      
      public function SysIconManager(param1:DisplayObjectContainer)
      {
         super();
         this._container = param1;
         this._absoluteContainer = new Sprite();
         this._newWorldIcons = new TopLeftIconGroup();
         this._topLeftIcons = new TopLeftIconGroup();
         this._topRightIcons = new TopRightIconGroup();
         this._topLeftSubIcons = new TopLeftSubIconGroup();
         this._giftPacksIcons = new GiftPacksIconGroup();
         this._container.addChild(this._absoluteContainer);
         this.showAllIcons();
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_TOP_LEFT_SUB_ICON_GROUP_ON_CLOSE,onLeftSubIconGroupClose,this);
      }
      
      public static function getInstance(param1:DisplayObjectContainer = null) : SysIconManager
      {
         if(__iconManager == null)
         {
            __iconManager = new SysIconManager(param1);
         }
         return __iconManager;
      }
      
      private static function onLeftSubIconGroupClose(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         if((SysIconManager.getInstance().topLeftSubIcons as TopLeftSubIconGroup).hasOwnProperty("LockIconExpand"))
         {
            (SysIconManager.getInstance().topLeftSubIcons as TopLeftSubIconGroup).LockIconExpand = true;
         }
         (SysIconManager.getInstance().topLeftSubIcons as TopLeftSubIconGroup).expand = false;
         return CallbackCenter.EVENT_OK;
      }
      
      public function dispose() : void
      {
         this._newWorldIcons.clearIcons();
         this._topLeftIcons.clearIcons();
         this._topRightIcons.clearIcons();
         this._topLeftSubIcons.clearIcons();
         this._giftPacksIcons.clearIcons();
         this.hideAllIcons();
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_TOP_LEFT_SUB_ICON_GROUP_ON_CLOSE,onLeftSubIconGroupClose,this);
      }
      
      public function get topLeftIcons() : ISysIconGroup
      {
         return this._topLeftIcons;
      }
      
      public function get topLeftSubIcons() : ISysIconGroup
      {
         return this._topLeftSubIcons;
      }
      
      public function get topRightIcons() : ISysIconGroup
      {
         return this._topRightIcons;
      }
      
      public function get absoluteContainer() : DisplayObjectContainer
      {
         return this._absoluteContainer;
      }
      
      public function get giftPacksIcons() : ISysIconGroup
      {
         return this._giftPacksIcons;
      }
      
      public function get newWorldIcons() : ISysIconGroup
      {
         return this._newWorldIcons;
      }
      
      public function showAllIcons() : void
      {
         if(this._container != null)
         {
            this._container.addChild(this._absoluteContainer);
            if(!this._container.contains(this._topLeftIcons))
            {
               this._container.addChild(this._topLeftIcons);
            }
            this._topLeftIcons.visible = true;
            if(!this._container.contains(this._topLeftSubIcons))
            {
               this._container.addChildAt(this._topLeftSubIcons,0);
            }
            this._topLeftSubIcons.visible = true;
            if(!this._container.contains(this._giftPacksIcons))
            {
               this._container.addChild(this._giftPacksIcons);
            }
            this._giftPacksIcons.visible = true;
            if(!this._container.contains(this._topRightIcons))
            {
               this._container.addChild(this._topRightIcons);
            }
            this._topRightIcons.visible = true;
         }
      }
      
      public function hideAllIcons() : void
      {
         if(this._container != null)
         {
            this._absoluteContainer.parent && this._absoluteContainer.parent.removeChild(this._absoluteContainer);
            if(this._container.contains(this._topLeftIcons))
            {
               this._container.removeChild(this._topLeftIcons);
            }
            this._topLeftIcons.visible = false;
            if(this._container.contains(this._giftPacksIcons))
            {
               this._container.removeChild(this._giftPacksIcons);
            }
            this._giftPacksIcons.visible = false;
            if(this._container.contains(this._topLeftSubIcons))
            {
               this._container.removeChild(this._topLeftSubIcons);
            }
            this._topLeftSubIcons.visible = false;
            if(this._container.contains(this._topRightIcons))
            {
               this._container.removeChild(this._topRightIcons);
            }
            this._topRightIcons.visible = false;
         }
      }
      
      public function updateIconsBetweenNewAndOldWorld() : void
      {
      }
   }
}

