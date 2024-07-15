package com.QQ.angel.debug
{
   import com.tencent.fge.engine.ui.keyboard.KeyCode;
   
   public class UnitTester
   {
      
      private static var ms_cmd:CmdBase = null;
       
      
      public function UnitTester()
      {
         super();
      }
      
      internal static function initialize() : void
      {
         ms_cmd = CmdBase.getCmdBase("UnitTester");
         ms_cmd.setSystemMenuItem("单元测试",KeyCode.U);
      }
      
      public static function addTestItem(param1:Function, param2:*, param3:uint = 0, param4:String = "", param5:Array = null) : void
      {
         if(ms_cmd)
         {
            ms_cmd.reg(param1,param2,param3,param4,param5);
         }
      }
      
      public static function openTestMenu() : void
      {
         if(ms_cmd)
         {
            ms_cmd.openMenu(null);
         }
      }
   }
}
