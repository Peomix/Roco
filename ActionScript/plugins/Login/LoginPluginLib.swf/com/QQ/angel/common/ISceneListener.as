package com.QQ.angel.common
{
   import com.QQ.angel.data.entity.SceneDes;
   
   public interface ISceneListener
   {
      
      function enterScene(param1:SceneDes) : void;
      
      function leaveScene(param1:SceneDes) : void;
   }
}

