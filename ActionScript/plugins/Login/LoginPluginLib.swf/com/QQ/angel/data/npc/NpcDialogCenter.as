package com.QQ.angel.data.npc
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.NPCDialogData;
   import com.QQ.angel.data.entity.OpenNPCTaskDes;
   import com.QQ.angel.data.entity.SceneDes;
   import flash.utils.Dictionary;
   
   public class NpcDialogCenter
   {
      
      private static var sm_singleton:NpcDialogCenter;
      
      private var m_dict:Dictionary;
      
      public function NpcDialogCenter()
      {
         super();
         sm_singleton = this;
         this.init();
      }
      
      public static function getSingleton() : NpcDialogCenter
      {
         return sm_singleton;
      }
      
      public function dispose() : void
      {
         if(sm_singleton == this)
         {
            sm_singleton = null;
         }
         if(this.m_dict)
         {
            this.m_dict = null;
         }
      }
      
      private function init() : void
      {
         if(!this.m_dict)
         {
            this.m_dict = new Dictionary();
         }
      }
      
      public function removeHideObject(param1:NPCDialogData) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < param1.items.length)
         {
            if(param1.items[_loc2_].isHide)
            {
               param1.items.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
         _loc2_ = 0;
         while(_loc2_ < param1.buttons.length)
         {
            if(param1.buttons[_loc2_].isHide)
            {
               param1.buttons.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
      
      public function getNPCDialogDataByHashClone(param1:String) : NPCDialogData
      {
         var _loc2_:NPCDialogData = this.getNPCDialogDataByHash(param1);
         var _loc3_:NPCDialogData = new NPCDialogData();
         _loc3_.dialogs = _loc2_.dialogs.slice();
         _loc3_.items = _loc2_.items.slice();
         _loc3_.buttons = _loc2_.buttons.slice();
         _loc3_.hash = _loc2_.hash;
         this.removeHideObject(_loc3_);
         return _loc3_;
      }
      
      public function getNPCDialogDataByHash(param1:String) : NPCDialogData
      {
         var _loc2_:NPCDialogData = null;
         if(!this.m_dict[param1])
         {
            this.m_dict[param1] = new NPCDialogData();
            NPCDialogData(this.m_dict[param1]).hash = param1;
         }
         _loc2_ = NPCDialogData(this.m_dict[param1]);
         if(!_loc2_.dialogs)
         {
            _loc2_.dialogs = [];
         }
         if(!_loc2_.items)
         {
            _loc2_.items = [];
         }
         if(!_loc2_.buttons)
         {
            _loc2_.buttons = [];
         }
         return _loc2_;
      }
      
      public function getNPCDialogData(param1:int, param2:SceneDes) : NPCDialogData
      {
         var _loc3_:* = "" + param2.sceneID + "_" + param2.ver + "_" + param1 + "_0";
         return this.getNPCDialogDataByHash(_loc3_);
      }
      
      public function mergeData(param1:OpenNPCTaskDes, param2:SceneDes) : NPCDialogData
      {
         var _loc6_:int = 0;
         var _loc7_:NpcDialogDataItem = null;
         var _loc9_:NpcDialogDataButton = null;
         var _loc11_:Array = null;
         var _loc12_:Object = null;
         var _loc3_:* = "" + param2.sceneID + "_" + param2.ver + "_" + param1.npcID + "_0";
         var _loc4_:NPCDialogData = this.getNPCDialogDataByHash(_loc3_);
         if(_loc4_.dialogs.length == 0)
         {
            _loc4_.dialogs.push(new NpcDialogDataContent());
         }
         var _loc5_:NpcDialogDataContent = NpcDialogDataContent(_loc4_.dialogs[0]);
         _loc5_.npcURL = __global.getNPCPreview(param1.npcID);
         _loc5_.npcName = param1.npcname;
         _loc5_.text = param1.dialog;
         _loc6_ = 0;
         while(_loc6_ < _loc4_.items.length)
         {
            _loc7_ = NpcDialogDataItem(_loc4_.items[_loc6_]);
            if(_loc7_.isFromXml)
            {
               _loc4_.items.splice(_loc6_,1);
            }
            else
            {
               _loc6_++;
            }
         }
         var _loc8_:Array = param1.npcFuns;
         if(_loc8_ != null && _loc8_.length > 0)
         {
            _loc11_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc8_.length)
            {
               _loc12_ = _loc8_[_loc6_];
               _loc7_ = new NpcDialogDataItem();
               _loc7_.label = _loc12_.label;
               _loc7_.handler = _loc12_.fun;
               _loc7_.icon = _loc12_.icon + 2;
               _loc7_.close = _loc12_.close != "false";
               _loc7_.isFromXml = true;
               _loc11_.unshift(_loc7_);
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc11_.length)
            {
               _loc4_.items.unshift(_loc11_[_loc6_]);
               _loc6_++;
            }
         }
         _loc6_ = 0;
         while(_loc6_ < _loc4_.buttons.length)
         {
            _loc9_ = NpcDialogDataButton(_loc4_.buttons[_loc6_]);
            if(_loc9_.isFromXml)
            {
               _loc4_.buttons.splice(_loc6_,1);
            }
            else
            {
               _loc6_++;
            }
         }
         _loc9_ = new NpcDialogDataButton();
         _loc9_.label = "离开";
         _loc9_.close = true;
         _loc9_.isFromXml = true;
         _loc4_.buttons.push(_loc9_);
         var _loc10_:NPCDialogData = new NPCDialogData();
         _loc10_.dialogs = _loc4_.dialogs.slice();
         _loc10_.items = _loc4_.items.slice();
         _loc10_.buttons = _loc4_.buttons.slice();
         _loc10_.hash = _loc4_.hash;
         this.removeHideObject(_loc10_);
         return _loc10_;
      }
   }
}

