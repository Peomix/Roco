package com.QQ.angel.res
{
   import com.QQ.angel.api.res.IResAdapter;
   import com.QQ.angel.data.entity.combatsys.pool.BuffCombatResPool;
   import com.QQ.angel.data.entity.combatsys.pool.CommonCombatResPool;
   import com.QQ.angel.data.entity.combatsys.pool.IconCombatResPool;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   
   public interface ICombatResAdapter extends IResAdapter
   {
       
      
      function getSpiritIdleMC(param1:uint, param2:Function) : MovieClip;
      
      function returnSpiritIdleMC(param1:String) : void;
      
      function getSpiritImage(param1:uint, param2:Function) : BitmapDataAsset;
      
      function returnSpiritImage(param1:String) : void;
      
      function getSuperSkillBgImage(param1:uint, param2:Function) : BitmapDataAsset;
      
      function returnSuperSkillBgImage(param1:String) : void;
      
      function getSpiritSkillImage(param1:int) : BitmapData;
      
      function getSpiritGroupImage(param1:int) : BitmapData;
      
      function get commonCombatResPool() : CommonCombatResPool;
      
      function get iconCombatResPool() : IconCombatResPool;
      
      function get buffCombatResPool() : BuffCombatResPool;
   }
}
