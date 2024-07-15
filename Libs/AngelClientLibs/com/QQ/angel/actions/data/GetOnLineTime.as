package com.QQ.angel.actions.data
{
   import com.QQ.angel.actions.ui.net.ReqOnLineTime;
   import com.QQ.angel.apps.utils.CommFunction;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   
   public class GetOnLineTime
   {
       
      
      private var curHandler:Function;
      
      public function GetOnLineTime(param1:Function)
      {
         super();
         this.curHandler = param1;
         var _loc2_:ReqOnLineTime = new ReqOnLineTime();
         var _loc3_:P_FreeRequest = new P_FreeRequest(196659,_loc2_,ReqOnLineTime,this.onDataReceive);
         _loc3_.send();
      }
      
      protected function onDataReceive(param1:ReqOnLineTime) : void
      {
         if(param1.code.isError())
         {
            CommFunction.alert(param1.code.message);
            return;
         }
         if(this.curHandler != null)
         {
            this.curHandler(param1.time);
         }
      }
   }
}
