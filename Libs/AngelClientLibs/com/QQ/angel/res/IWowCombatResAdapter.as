package com.QQ.angel.res
{
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.data.entity.combatsys.pool.WowEffectPool;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   
   public interface IWowCombatResAdapter extends IResAdapter
   {
       
      
      function getWowEffectMC(param1:uint, param2:Function) : MovieClip;
      
      function returnWowEffectMC(param1:String) : void;
      
      function get commonCombatResPool() : WowEffectPool;
      
      function getCurrentDomain() : ApplicationDomain;
   }
}
