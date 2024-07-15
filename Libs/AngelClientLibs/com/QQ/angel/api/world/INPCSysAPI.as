package com.QQ.angel.api.world
{
   import com.QQ.angel.api.world.npc.INPC;
   
   public interface INPCSysAPI
   {
       
      
      function getNPCByName(param1:String) : INPC;
      
      function getNPCList() : Array;
      
      function getNPCCls(param1:int = 0) : Class;
      
      function getNPCViewCls(param1:int = 0) : Class;
      
      function getNPCModel(param1:int = -1) : Object;
   }
}
