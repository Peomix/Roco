package com.QQ.angel.world.magic
{
   import flash.events.IEventDispatcher;
   
   public interface IAcceptMagicView extends IEventDispatcher
   {
       
      
      function onAcceptedMagic(param1:int, param2:Number = 0, param3:Number = 0) : Boolean;
   }
}
