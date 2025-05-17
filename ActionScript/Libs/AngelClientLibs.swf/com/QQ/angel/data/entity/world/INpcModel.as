package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.NpcDes;
   import flash.events.IEventDispatcher;
   
   public interface INpcModel extends IEventDispatcher
   {
      
      function getXMLNpcDeses() : Array;
      
      function getNpcProxy(param1:int) : INpcDataProxy;
      
      function addNpc(param1:NpcDes, param2:Boolean = false) : void;
      
      function removeNpc(param1:NpcDes, param2:Boolean = false) : void;
      
      function getCurrNpcProxys() : Array;
      
      function update() : void;
   }
}

