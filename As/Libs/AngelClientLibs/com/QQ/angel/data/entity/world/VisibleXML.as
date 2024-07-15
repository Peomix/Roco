package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.tasksys.TaskDataV2;
   import com.QQ.angel.data.entity.tasksys.model.IModelManager;
   import com.QQ.angel.data.entity.tasksys.model.ITaskModel;
   
   public class VisibleXML
   {
       
      
      protected var visible:Boolean;
      
      protected var careTaskIDs:Array;
      
      protected var curr:CareTaskID;
      
      public function VisibleXML(param1:XML)
      {
         var _loc5_:XML = null;
         super();
         this.visible = String(param1.@param) == "true";
         var _loc2_:XMLList = param1.Task;
         var _loc3_:int = _loc2_.length();
         if(_loc3_ != 0)
         {
            this.careTaskIDs = [];
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            this.careTaskIDs.push(new CareTaskID(_loc5_.@id,_loc5_.@care));
            _loc4_++;
         }
      }
      
      public function getTaskVisible(param1:IModelManager, param2:TaskDataV2 = null) : Boolean
      {
         var _loc4_:CareTaskID = null;
         var _loc5_:TaskDataV2 = null;
         var _loc6_:ITaskModel = null;
         this.curr = null;
         if(this.careTaskIDs == null || this.careTaskIDs.length == 0 || param1 == null)
         {
            return !this.visible;
         }
         var _loc3_:int = 0;
         while(_loc3_ < this.careTaskIDs.length)
         {
            _loc4_ = this.careTaskIDs[_loc3_];
            if((_loc5_ = param2) == null)
            {
               _loc5_ = (_loc6_ = param1.getTaskModelByID(_loc4_.taskID)) != null ? _loc6_.getValue() : null;
            }
            if(!(_loc5_ == null || _loc5_.taskID != _loc4_.taskID))
            {
               if(_loc4_.careState != "")
               {
                  if(_loc4_.isCareNow(_loc5_.state))
                  {
                     this.curr = _loc4_;
                     return this.visible;
                  }
               }
               else if(_loc5_.state == 2 && _loc4_.isCareNow2(_loc5_.cdtns))
               {
                  this.curr = _loc4_;
                  return this.visible;
               }
            }
            _loc3_++;
         }
         return !this.visible;
      }
      
      public function getCurrTrue() : CareTaskID
      {
         return this.curr;
      }
   }
}
