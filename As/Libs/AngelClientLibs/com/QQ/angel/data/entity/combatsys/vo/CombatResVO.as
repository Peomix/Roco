package com.QQ.angel.data.entity.combatsys.vo
{
   public class CombatResVO
   {
       
      
      public var id:int;
      
      public var type:String;
      
      public var url:String;
      
      public var Cls:Class;
      
      public var display:*;
      
      public var policy:int = 0;
      
      public var useCount:int = 0;
      
      public var iscopy:Boolean = false;
      
      public function CombatResVO()
      {
         super();
      }
      
      public function copy(param1:CombatResVO) : void
      {
         this.id = param1.id;
         this.type = param1.type;
         this.url = param1.url;
         this.Cls = param1.Cls;
         this.display = param1.display;
         this.policy = param1.policy;
         this.useCount = param1.useCount;
         this.iscopy = param1.iscopy;
      }
   }
}
