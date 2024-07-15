package com.QQ.angel.world.magic
{
   import com.QQ.angel.api.world.role.ICursedDisplay;
   
   public interface ICanBeCursed extends ICanAddedEffect
   {
       
      
      function setBodyVisible(param1:Boolean) : void;
      
      function setCursedDis(param1:ICursedDisplay) : void;
      
      function useTimerSelf() : Boolean;
   }
}
