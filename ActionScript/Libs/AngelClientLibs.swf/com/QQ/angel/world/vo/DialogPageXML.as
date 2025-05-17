package com.QQ.angel.world.vo
{
   import com.QQ.angel.data.entity.NPCDialogData;
   
   public class DialogPageXML extends NPCDialogData
   {
      
      public function DialogPageXML(param1:XML = null, param2:Object = null)
      {
         super();
         if(param1 != null)
         {
            this.paseXML(param1,param2);
         }
      }
      
      protected function paseDialog(param1:XML, param2:Object = null) : Object
      {
         var _loc3_:Object = {"text":param1.toString()};
         if(param1.@npcID != undefined)
         {
            _loc3_.npcID = String(param1.@npcID);
         }
         if(param1.@npcName != undefined)
         {
            _loc3_.npcName = String(param1.@npcName);
         }
         if(param2 != null)
         {
            param2.everyDialog(_loc3_);
         }
         return _loc3_;
      }
      
      public function paseXML(param1:XML, param2:Object = null) : void
      {
         var _loc5_:DialogItemXML = null;
         id = int(param1.@id);
         dialogs = [];
         var _loc3_:XMLList = param1.Dialog;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length())
         {
            dialogs.push(this.paseDialog(_loc3_[_loc4_],param2));
            _loc4_++;
         }
         _loc3_ = param1.NPCFun;
         if(_loc3_.length() > 0)
         {
            items = [];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc5_ = new DialogItemXML(_loc3_[_loc4_]);
               if(param2 != null)
               {
                  param2.everyItem(_loc5_);
               }
               items.push(_loc5_);
               _loc4_++;
            }
         }
         _loc3_ = param1.Button;
         if(_loc3_.length() > 0)
         {
            buttons = [];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length())
            {
               _loc5_ = new DialogItemXML(_loc3_[_loc4_]);
               if(param2 != null)
               {
                  param2.everyItem(_loc5_);
               }
               buttons.push(_loc5_);
               _loc4_++;
            }
         }
      }
   }
}

