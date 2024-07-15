package com.QQ.angel.data.entity.combatsys.vo
{
   import com.QQ.angel.data.entity.combatsys.pool.IWowCombatResPool;
   
   public class WowEffectCombatResVO
   {
       
      
      public var id:int;
      
      public var type:String;
      
      public var url:String;
      
      public var Cls0:Class;
      
      public var Cls1:Class;
      
      public var Cls2:Class;
      
      public var display:*;
      
      public var policy:int = 0;
      
      public var useCount:int = 0;
      
      public var iscopy:Boolean = false;
      
      public var resPool:IWowCombatResPool;
      
      public var callBack:Function;
      
      public function WowEffectCombatResVO()
      {
         super();
      }
      
      public function copy(param1:WowEffectCombatResVO) : void
      {
         this.id = param1.id;
         this.type = param1.type;
         this.url = param1.url;
         this.Cls0 = param1.Cls0;
         this.Cls1 = param1.Cls1;
         this.Cls2 = param1.Cls2;
         this.display = param1.display;
         this.policy = param1.policy;
         this.useCount = param1.useCount;
         this.iscopy = param1.iscopy;
         this.resPool = param1.resPool;
         this.callBack = param1.callBack;
      }
   }
}
