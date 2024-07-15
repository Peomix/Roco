package com.QQ.angel.world.npc
{
   import com.QQ.angel.api.world.npc.INPC;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public interface INPCListener
   {
       
      
      function isFrequency(param1:int) : Boolean;
      
      function getCommIcon(param1:String) : DisplayObject;
      
      function returnCommIcon(param1:String, param2:DisplayObject) : void;
      
      function createNameTxt() : TextField;
      
      function returnNameTxt(param1:TextField) : void;
      
      function getOverFilters(param1:int = 0) : Array;
      
      function getSceneStage() : Sprite;
      
      function getNpcPath(param1:int, param2:String) : String;
      
      function onNPCClick(param1:INPC) : void;
   }
}
