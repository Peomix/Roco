package com.QQ.angel.api.world.action
{
   public interface ITick
   {
       
      
      function onTick(... rest) : void;
      
      function getID() : uint;
   }
}
