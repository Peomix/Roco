package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.script.ScriptTypes;
   import flash.geom.Point;
   
   public class AsWindowScript extends BaseSwitchScript
   {
      
      public function AsWindowScript()
      {
         super(ScriptTypes.ASWINDOW);
      }
      
      protected function onWinCreated(param1:IWindow) : void
      {
         if(param1 == null)
         {
            onReturnCase(0);
         }
      }
      
      override public function execute(param1:XML) : void
      {
         var _loc3_:Point = null;
         var _loc6_:Array = null;
         super.execute(param1);
         var _loc2_:String = param1.@src;
         var _loc4_:String = param1.@scriptParams;
         if(param1.@winPos != undefined)
         {
            _loc6_ = String(param1.@winPos).split("|");
            _loc3_ = new Point(int(_loc6_[0]),int(_loc6_[1]));
         }
         var _loc5_:String = param1.@name;
         __global.SysAPI.getExternalAPI().openASWindow(_loc2_,_loc5_,true,_loc3_,this.onWinCreated,onReturnCase,true,String(param1.@cache) == "true",_loc4_);
      }
   }
}

