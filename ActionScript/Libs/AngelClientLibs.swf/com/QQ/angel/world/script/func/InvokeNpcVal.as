package com.QQ.angel.world.script.func
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.net.protocol.P_LoadNpcVal;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeNpcVal implements IInvokeFunc
   {
      
      protected var handler:Function;
      
      public function InvokeNpcVal()
      {
         super();
      }
      
      public function onNpcValLoaded(param1:P_LoadNpcVal) : void
      {
         __global.UI.closeMiniLoading();
         if(param1.code.isError())
         {
            this.handler(0);
         }
         else
         {
            this.handler(param1.value);
         }
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         this.handler = param2;
         var _loc3_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_LOAD_NPCVAL,new P_LoadNpcVal(uint(param1)),P_LoadNpcVal,this.onNpcValLoaded);
         _loc3_.send();
         __global.UI.createMiniLoading();
      }
      
      public function dispose() : void
      {
         this.handler = null;
      }
   }
}

