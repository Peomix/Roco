package com.QQ.angel.data.entity.world
{
   public class CareTaskID
   {
       
      
      public var taskID:int;
      
      public var careState:String = "";
      
      public var sourceCare:String = "";
      
      public var careCondis:Array;
      
      public var param:Object;
      
      public function CareTaskID(param1:int, param2:String, param3:Object = null)
      {
         super();
         this.taskID = param1;
         this.paseCareStr(param2);
         this.param = param3;
      }
      
      protected function paseCareStr(param1:String) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this.sourceCare = param1;
         if(param1.indexOf("=") == -1)
         {
            this.careState = param1;
         }
         else
         {
            this.careState = "";
            this.careCondis = [];
            _loc2_ = param1.length;
            _loc3_ = 1;
            while(_loc3_ < _loc2_)
            {
               this.careCondis.push(int(param1.charAt(_loc3_)));
               _loc3_++;
            }
         }
      }
      
      public function isCareNow(param1:int) : Boolean
      {
         return this.careState.indexOf("" + param1) != -1;
      }
      
      public function isCareNow2(param1:Array) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         if(param1 == null || this.careCondis == null || param1.length == 0 || this.careCondis.length != param1.length)
         {
            return false;
         }
         var _loc2_:int = int(this.careCondis.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = int(this.careCondis[_loc3_])) != 2)
            {
               if((_loc5_ = param1[_loc3_]) == null || _loc4_ != _loc5_.state)
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return true;
      }
      
      public function isCareNow3(param1:Array) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         if(param1 == null || this.careCondis == null || param1.length == 0 || this.careCondis.length != param1.length)
         {
            return false;
         }
         var _loc2_:int = this.getCareIndex(this.careCondis);
         var _loc3_:int = int(this.careCondis.length);
         if(this.careCondis.length == 1)
         {
            return param1[0].state == this.careCondis[0];
         }
         if(_loc2_ == _loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               if((_loc6_ = param1[_loc5_]) == null || _loc6_.state == 0)
               {
                  return false;
               }
               _loc5_++;
            }
            return true;
         }
         if(param1[_loc2_].state == 1)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            if((_loc7_ = int(this.careCondis[_loc4_])) != 2)
            {
               if((_loc6_ = param1[_loc4_]) == null || _loc6_.state == 0)
               {
                  return false;
               }
            }
            _loc4_++;
         }
         return true;
      }
      
      private function getCareIndex(param1:Array) : int
      {
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            if(param1[_loc2_] == 0)
            {
               return _loc2_;
            }
            _loc2_++;
         }
         return param1.length;
      }
   }
}
