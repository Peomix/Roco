package com.QQ.angel.world.npc
{
   import com.QQ.angel.api.world.npc.INPC;
   import com.QQ.angel.api.world.scene.ILayer;
   
   public interface INPCElement extends INPC
   {
       
      
      function get npclistener() : INPCListener;
      
      function set npclistener(param1:INPCListener) : void;
      
      function getNpcType() : int;
      
      function setAtLayer(param1:ILayer) : void;
   }
}
