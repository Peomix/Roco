package com.QQ.angel.world.scene
{
   import flash.events.IEventDispatcher;
   
   public interface IDCreateView extends IEventDispatcher
   {
       
      
      function setLazyLoad(param1:Boolean) : void;
      
      function setPath(param1:String) : void;
      
      function load(param1:String = "") : void;
   }
}
