package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.vo.WowEffectCombatResVO;
   
   public interface IWowCombatResPool
   {
      
      function onCompleteHandler(param1:ResData = null) : void;
      
      function splicePath(param1:WowEffectCombatResVO) : Boolean;
   }
}

