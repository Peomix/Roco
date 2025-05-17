package com.QQ.angel.api.world.role
{
   import com.QQ.angel.api.world.action.IAction;
   import com.QQ.angel.api.world.action.IActor;
   import com.QQ.angel.api.world.scene.IMotionItem;
   import com.QQ.angel.api.world.scene.ISPlace;
   
   public interface IRole extends IMotionItem
   {
      
      function getRoleView() : IRoleView;
      
      function canExecAction(param1:int) : Boolean;
      
      function act(param1:IAction) : Boolean;
      
      function setSPlace(param1:ISPlace) : void;
      
      function getSPlace() : ISPlace;
      
      function getActor() : IActor;
      
      function fly() : void;
      
      function swim() : void;
      
      function magicOffset(param1:uint = 0) : void;
      
      function showCombatResultEffect(param1:uint) : Object;
      
      function pkState(param1:int) : void;
      
      function fishingState(param1:int) : void;
   }
}

