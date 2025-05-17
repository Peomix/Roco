package com.QQ.angel.debug.menu
{
   public class CmdItemData
   {
      
      public var name:String = "";
      
      public var param:String = "";
      
      public var parent:CmdItemData = null;
      
      public var children:Array = new Array();
      
      public var callback:Function = null;
      
      public var callbackParamCount:uint = 0;
      
      public var example:String = "";
      
      public var defaultParams:Array = new Array();
      
      public var lstDefaultParams:Array = new Array();
      
      private var m_path:Array = null;
      
      public function CmdItemData()
      {
         super();
      }
      
      public function get lstPath() : Array
      {
         if(null == this.m_path)
         {
            this.createPath();
         }
         return this.m_path;
      }
      
      private function createPath() : void
      {
         this.m_path = new Array();
         var _loc1_:CmdItemData = this;
         do
         {
            this.m_path.unshift(_loc1_.param);
            _loc1_ = _loc1_.parent;
         }
         while(_loc1_);
         
      }
      
      public function invokeCallback(param1:Array) : void
      {
         var _loc2_:Function = this.callback;
         if(param1 == null)
         {
            _loc2_();
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            switch(param1[_loc3_])
            {
               case "true":
                  param1[_loc3_] = true;
                  break;
               case "false":
                  param1[_loc3_] = false;
                  break;
            }
            _loc3_++;
         }
         switch(param1.length)
         {
            case 0:
               _loc2_();
               break;
            case 1:
               _loc2_(param1[0]);
               break;
            case 2:
               _loc2_(param1[0],param1[1]);
               break;
            case 3:
               _loc2_(param1[0],param1[1],param1[2]);
               break;
            case 4:
               _loc2_(param1[0],param1[1],param1[2],param1[3]);
               break;
            case 5:
               _loc2_(param1[0],param1[1],param1[2],param1[3],param1[4]);
               break;
            case 6:
               _loc2_(param1[0],param1[1],param1[2],param1[3],param1[4],param1[5]);
               break;
            case 7:
               _loc2_(param1[0],param1[1],param1[2],param1[3],param1[4],param1[5],param1[6]);
               break;
            case 8:
               _loc2_(param1[0],param1[1],param1[2],param1[3],param1[4],param1[5],param1[6],param1[7]);
         }
      }
   }
}

