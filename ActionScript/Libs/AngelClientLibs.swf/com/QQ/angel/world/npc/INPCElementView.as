package com.QQ.angel.world.npc
{
   import com.QQ.angel.api.world.npc.INPCView;
   import com.QQ.angel.data.entity.NpcViewDes;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public interface INPCElementView extends INPCView
   {
      
      function onReady() : void;
      
      function setNameTxt(param1:TextField) : void;
      
      function setNpcName(param1:String) : void;
      
      function addSign(param1:MovieClip) : void;
      
      function signTO(param1:String) : void;
      
      function setOverFilter(param1:Array) : void;
      
      function setViewDes(param1:NpcViewDes) : void;
      
      function setSceneStage(param1:Sprite) : void;
   }
}

