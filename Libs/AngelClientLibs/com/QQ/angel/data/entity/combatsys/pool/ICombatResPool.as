package com.QQ.angel.data.entity.combatsys.pool
{
   import com.QQ.angel.api.res.ResData;
   import com.QQ.angel.data.entity.combatsys.vo.CombatLoadResVO;
   
   public interface ICombatResPool
   {
       
      
      function onCompleteHandler(param1:ResData = null) : void;
      
      function splicePath(param1:CombatLoadResVO) : Boolean;
   }
}
