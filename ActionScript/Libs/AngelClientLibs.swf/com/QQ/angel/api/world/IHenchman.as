package com.QQ.angel.api.world
{
   import com.QQ.angel.api.world.action.ITick;
   
   public interface IHenchman extends ITick
   {
      
      function insertChip(param1:IAIChip) : void;
      
      function pullOutChip(param1:int) : void;
   }
}

