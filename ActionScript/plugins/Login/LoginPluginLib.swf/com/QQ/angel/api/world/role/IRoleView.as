package com.QQ.angel.api.world.role
{
   import com.QQ.angel.api.world.scene.IActivityView;
   
   public interface IRoleView extends IActivityView
   {
      
      function playMotion(param1:int, param2:int) : void;
      
      function setName(param1:String) : void;
      
      function wearAvatar(param1:uint, param2:String, param3:int, param4:int) : void;
      
      function wearAvatarTransform(param1:int) : void;
      
      function setAvatarEffect(param1:int) : void;
      
      function getDirection() : int;
      
      function getMotionType() : int;
      
      function setBodyVisible(param1:Boolean) : void;
      
      function setCursedDis(param1:ICursedDisplay) : void;
      
      function addEffect(param1:Object) : void;
      
      function delEffect(param1:Object) : void;
      
      function addLabelEvent(param1:Function) : void;
      
      function addEndFrameEvent(param1:Function) : void;
      
      function removeEndFrameEvent(param1:Function) : void;
      
      function removeLabelEvent(param1:Function) : void;
      
      function setTrainerLevel(param1:int) : void;
      
      function setAchieve(param1:String) : void;
      
      function setMount(param1:uint) : void;
      
      function setMagicArea(param1:uint) : void;
      
      function setIsDazzleAvatar(param1:Boolean) : void;
      
      function setSelectedMedal(param1:Object) : void;
      
      function setFootPrintEffect(param1:int, param2:Boolean) : void;
      
      function setNameBgid(param1:int, param2:Boolean) : void;
      
      function setPaopaoId(param1:int, param2:Boolean) : void;
   }
}

