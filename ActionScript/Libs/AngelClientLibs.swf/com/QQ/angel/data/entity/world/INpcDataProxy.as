package com.QQ.angel.data.entity.world
{
   import com.QQ.angel.data.entity.NPCCDConvert;
   import com.QQ.angel.data.entity.NpcDes;
   import com.QQ.angel.data.entity.NpcFuncDes;
   import flash.display.DisplayObject;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public interface INpcDataProxy extends IEventDispatcher
   {
      
      function getNpcDes() : NpcDes;
      
      function getTargetPos() : Point;
      
      function getTarget() : DisplayObject;
      
      function getClick() : NPCCDConvert;
      
      function getViewEvents() : Array;
      
      function dispose() : void;
      
      function setGeneralDialog(param1:String) : void;
      
      function addNpcFunc(param1:NpcFuncDes) : void;
      
      function removeNpcFunc(param1:NpcFuncDes) : void;
      
      function getHeadIcon() : int;
   }
}

