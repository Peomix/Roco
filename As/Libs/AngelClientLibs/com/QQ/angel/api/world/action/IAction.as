package com.QQ.angel.api.world.action
{
   public interface IAction
   {
       
      
      function start(param1:Object) : void;
      
      function isLockedType(param1:int) : Boolean;
      
      function replace(param1:IAction) : Boolean;
      
      function getType() : int;
      
      function giveUp() : Boolean;
      
      function isFinished() : Boolean;
      
      function onAct(param1:Object) : void;
   }
}
