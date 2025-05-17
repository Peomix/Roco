package com.QQ.angel.api.command
{
   import com.QQ.angel.api.events.AngelSysEvent;
   
   public interface IAngelCommand
   {
      
      function execute(param1:AngelSysEvent) : void;
   }
}

