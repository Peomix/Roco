package com.QQ.angel.msg
{
   import com.QQ.angel.api.ui.IEffectManager;
   
   public class CommEffectController extends EffectMsgController
   {
       
      
      public function CommEffectController(param1:IEffectManager)
      {
         super(param1,0);
      }
      
      override public function startMSG(param1:Function, param2:Object = null) : void
      {
         if(this.endHandler != null)
         {
            throw new Error("xxx");
         }
         eType = param2.eType;
         super.startMSG(param1,param2.data);
      }
   }
}
