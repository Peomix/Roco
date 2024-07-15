package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.utils.AString;
   import com.QQ.angel.world.script.ScriptTypes;
   
   public class AlertScript extends BaseSwitchScript
   {
       
      
      public function AlertScript()
      {
         super(ScriptTypes.ALERT);
      }
      
      override public function execute(param1:XML) : void
      {
         super.execute(param1);
         var _loc2_:String = param1.@title;
         var _loc3_:int = int(param1.@mode);
         var _loc4_:String = param1.@text;
         _loc4_ = AString.TranArgs(_loc4_,global);
         __global.UI.alert(_loc2_,_loc4_,_loc3_,new CFunction(onReturnCase,this));
      }
   }
}
