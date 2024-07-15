package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.utils.AString;
   import com.QQ.angel.world.script.FuncManager;
   import com.QQ.angel.world.script.IInvokeFunc;
   import com.QQ.angel.world.script.ScriptTypes;
   
   public class SwitchScript extends BaseSwitchScript
   {
       
      
      protected var func:IInvokeFunc;
      
      public function SwitchScript()
      {
         super(ScriptTypes.SWITCH);
      }
      
      override public function execute(param1:XML) : void
      {
         var _loc2_:XML = null;
         super.execute(param1);
         if(param1.@invoke == undefined)
         {
            _loc2_ = param1.Func[0];
         }
         else
         {
            _loc2_ = param1;
         }
         var _loc3_:String = _loc2_.@args;
         this.func = FuncManager.getInstance().createFunc(_loc2_);
         if(this.func != null)
         {
            this.func.setGlobal(global);
            _loc3_ = AString.TranArgs(_loc3_,global);
            this.func.invoke(_loc3_,this.onReturnCase);
         }
         else
         {
            this.onReturnCase(0);
         }
      }
      
      override public function dispose() : void
      {
         if(this.func != null)
         {
            throw new AngelError("此条件脚本不能被中止:" + xml,this);
         }
         super.dispose();
      }
      
      override public function onReturnCase(param1:int) : void
      {
         this.func.dispose();
         this.func = null;
         super.onReturnCase(param1);
      }
   }
}
