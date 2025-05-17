package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.data.entity.NPCCDConvert;
   import com.QQ.angel.world.script.IScript;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class AbstractScript extends EventDispatcher implements IScript
   {
      
      protected var source:NPCCDConvert;
      
      protected var global:Object;
      
      protected var type:String;
      
      protected var completed:Boolean = false;
      
      public function AbstractScript(param1:String)
      {
         super();
         this.type = param1;
      }
      
      protected function noticeComplete(param1:Object = null) : void
      {
         if(this.completed)
         {
            return;
         }
         this.completed = true;
         var _loc2_:BaseEvent = new BaseEvent(Event.COMPLETE);
         _loc2_.data = param1;
         dispatchEvent(_loc2_);
      }
      
      public function setSource(param1:NPCCDConvert) : void
      {
         this.source = param1;
      }
      
      public function getSource() : NPCCDConvert
      {
         return this.source;
      }
      
      public function setGlobalVars(param1:Object) : void
      {
         this.global = param1;
      }
      
      public function execute(param1:XML) : void
      {
         throw new AngelError(AngelError.METHOD_NOT_IMPL,this);
      }
      
      public function getType() : String
      {
         return this.type;
      }
      
      public function dispose() : void
      {
         this.source = null;
         this.global = null;
      }
   }
}

