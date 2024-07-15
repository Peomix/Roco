package com.QQ.angel.world.script.func
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeTaskIsComplete implements IInvokeFunc
   {
       
      
      protected var handler:Function;
      
      public function InvokeTaskIsComplete()
      {
         super();
      }
      
      public function isComplete(param1:Boolean) : void
      {
         __global.UI.closeMiniLoading();
         if(param1)
         {
            this.handler(1);
         }
         else
         {
            this.handler(0);
         }
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         this.handler = param2;
         __global.UI.createMiniLoading();
         __global.modelManager.taskIsComplete(int(param1),this.isComplete);
      }
      
      public function dispose() : void
      {
         this.handler = null;
      }
   }
}
