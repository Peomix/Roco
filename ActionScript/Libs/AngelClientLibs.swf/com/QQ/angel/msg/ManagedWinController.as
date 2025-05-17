package com.QQ.angel.msg
{
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.msg.IMsgController;
   
   public class ManagedWinController implements IMsgController
   {
      
      protected var commUI:ICommUIManager;
      
      protected var endHandler:Function;
      
      protected var closeHandler:CFunction;
      
      protected var winType:int = 8;
      
      public function ManagedWinController(param1:ICommUIManager, param2:int)
      {
         super();
         this.commUI = param1;
         this.winType = param2;
         this.closeHandler = new CFunction(this.onClosed,this);
      }
      
      protected function onClosed() : void
      {
         if(this.endHandler != null)
         {
            this.endHandler();
         }
         this.endHandler = null;
      }
      
      public function startMSG(param1:Function, param2:Object = null) : void
      {
         if(this.commUI == null)
         {
            param1();
            return;
         }
         this.endHandler = param1;
         this.commUI.showManagedWin(this.winType,param2,this.closeHandler);
      }
      
      public function cancel() : void
      {
      }
   }
}

