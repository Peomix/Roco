package com.QQ.angel.data.entity.combatsys.vo
{
   import com.QQ.angel.data.entity.combatsys.pool.ICombatResPool;
   
   public class CombatLoadResVO
   {
      
      public var id:int;
      
      public var type:String;
      
      public var key:String;
      
      public var resPool:ICombatResPool;
      
      public var policy:int = 0;
      
      public var url:String;
      
      public var linkName:String;
      
      public var callBack:Function = null;
      
      public function CombatLoadResVO()
      {
         super();
      }
      
      public function toString() : String
      {
         return this.url;
      }
   }
}

