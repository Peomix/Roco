package com.QQ.angel.msg
{
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.msg.IMsgController;
   
   public class AlertController implements IMsgController
   {
       
      
      protected var commUI:ICommUIManager;
      
      protected var endHandler:Function;
      
      protected var clickHandler:CFunction;
      
      public function AlertController(param1:ICommUIManager)
      {
         super();
         this.commUI = param1;
         this.clickHandler = new CFunction(this.onClicked,this);
      }
      
      protected function onClicked(param1:int) : void
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
         this.commUI.alert("",param2 + "",1,this.clickHandler);
      }
      
      public function cancel() : void
      {
      }
   }
}
