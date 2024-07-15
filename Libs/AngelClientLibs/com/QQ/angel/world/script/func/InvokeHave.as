package com.QQ.angel.world.script.func
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.net.protocol.P_Query;
   import com.QQ.angel.world.script.IInvokeFunc;
   
   public class InvokeHave implements IInvokeFunc
   {
       
      
      protected var handler:Function;
      
      public function InvokeHave()
      {
         super();
      }
      
      public function onQueryResult(param1:P_Query) : void
      {
         __global.UI.closeMiniLoading();
         if(param1.code.isError())
         {
            this.handler(0);
         }
         else
         {
            this.handler(param1.results);
         }
      }
      
      public function setGlobal(param1:Object) : void
      {
      }
      
      public function invoke(param1:String, param2:Function) : void
      {
         this.handler = param2;
         var _loc3_:Array = param1.split(",");
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc3_[_loc4_] = String(_loc3_[_loc4_]).split("|");
            _loc4_++;
         }
         __global.DataAPI.checkHaveItem(null,_loc3_,this.onQueryResult);
         __global.UI.createMiniLoading();
      }
      
      public function dispose() : void
      {
         this.handler = null;
      }
   }
}
