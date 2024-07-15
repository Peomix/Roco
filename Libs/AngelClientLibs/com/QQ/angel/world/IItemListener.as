package com.QQ.angel.world
{
   public interface IItemListener
   {
       
      
      function onItemClick(param1:Object) : void;
      
      function onItemMagic(param1:Object, param2:int = 0) : void;
      
      function onItemLevelUp(param1:Object, param2:int) : void;
      
      function onItemSpirit(param1:Object, param2:Object) : void;
      
      function isFrequency(param1:int) : Boolean;
   }
}
