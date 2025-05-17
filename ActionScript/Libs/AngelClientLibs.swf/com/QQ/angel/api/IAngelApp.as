package com.QQ.angel.api
{
   public interface IAngelApp extends IAngelSysAPIAware
   {
      
      function setup() : void;
      
      function activate() : void;
      
      function inactivate() : void;
   }
}

