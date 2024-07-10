package com.QQ.angel.plugs.Login.ui2.views
{
   public interface IView
   {
       
      
      function enter() : void;
      
      function exit() : void;
      
      function setNextView(param1:IView) : void;
      
      function setData(param1:Array, param2:int) : void;
   }
}
