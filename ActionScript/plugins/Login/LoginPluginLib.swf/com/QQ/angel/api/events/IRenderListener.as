package com.QQ.angel.api.events
{
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   
   public interface IRenderListener extends IEventDispatcher
   {
      
      function hasRender() : Boolean;
      
      function onRender(param1:Event) : void;
   }
}

