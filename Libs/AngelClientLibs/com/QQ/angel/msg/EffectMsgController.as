package com.QQ.angel.msg
{
   import com.QQ.angel.api.ui.IEffectManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.msg.IMsgController;
   
   public class EffectMsgController implements IMsgController
   {
       
      
      protected var effectM:IEffectManager;
      
      protected var endHandler:Function;
      
      protected var finishedHandler:CFunction;
      
      protected var eType:int = 0;
      
      public function EffectMsgController(param1:IEffectManager, param2:int)
      {
         super();
         this.effectM = param1;
         this.finishedHandler = new CFunction(this.onFinished,this);
         this.eType = param2;
      }
      
      protected function onFinished() : void
      {
         var _loc1_:Function = null;
         if(this.endHandler != null)
         {
            _loc1_ = this.endHandler;
            this.endHandler = null;
            _loc1_();
         }
      }
      
      public function startMSG(param1:Function, param2:Object = null) : void
      {
         if(this.effectM == null)
         {
            param1();
            return;
         }
         this.endHandler = param1;
         this.effectM.playEffect(this.eType,param2,this.finishedHandler);
      }
      
      public function cancel() : void
      {
      }
   }
}
