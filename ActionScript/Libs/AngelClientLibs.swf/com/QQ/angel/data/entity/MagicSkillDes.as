package com.QQ.angel.data.entity
{
   import flash.events.EventDispatcher;
   
   public class MagicSkillDes extends EventDispatcher
   {
      
      public static const READY:String = "ready";
      
      public var id:int;
      
      public var name:String;
      
      public var magicType:int;
      
      public var actionType:int;
      
      public var target:int;
      
      public var tips:String;
      
      public var dur:int;
      
      public var iconSrc:String;
      
      public var resSrc:String;
      
      public var isReady:Boolean = false;
      
      public var app:String;
      
      public var isClient:Boolean = false;
      
      public function MagicSkillDes()
      {
         super();
      }
   }
}

