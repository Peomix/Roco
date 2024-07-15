package com.QQ.angel.msg
{
   import com.QQ.angel.api.IMsgAPI;
   import com.QQ.angel.api.IUISysAPI;
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.IEffectManager;
   import com.QQ.angel.data.entity.msg.IMsgController;
   import com.QQ.angel.data.entity.msg.SysMsgDes;
   import flash.utils.Dictionary;
   
   public class AngelMSGSys implements IMsgAPI
   {
       
      
      protected var msgList:Array;
      
      protected var isRuning:Boolean;
      
      protected var isRending:Boolean;
      
      protected var isAuto:Boolean = true;
      
      protected var uisys:IUISysAPI;
      
      protected var controllers:Dictionary;
      
      protected var currController:IMsgController;
      
      protected var currMsgDes:SysMsgDes;
      
      public function AngelMSGSys(param1:IUISysAPI)
      {
         super();
         this.msgList = [];
         this.uisys = param1;
         this.isRuning = false;
         this.isRending = true;
         this.controllers = new Dictionary();
         var _loc2_:ICommUIManager = param1.commUIManager;
         var _loc3_:IEffectManager = param1.effectManager;
         this.controllers[SysMsgDes.ALERT] = new AlertController(_loc2_);
         this.controllers[SysMsgDes.GOT_ITEMS] = new ManagedWinController(_loc2_,8);
         this.controllers[SysMsgDes.GOT_VALUES] = new ManagedWinController(_loc2_,7);
         this.controllers[SysMsgDes.H_EFFECT] = new EffectMsgController(_loc3_,0);
         this.controllers[SysMsgDes.V_EFFECT] = new EffectMsgController(_loc3_,1);
         this.controllers[SysMsgDes.COMM_EFFECT] = new CommEffectController(_loc3_);
      }
      
      protected function controlEnd() : void
      {
         this.currController = null;
         this.currMsgDes = null;
         this.isRuning = false;
         this.run();
      }
      
      protected function run() : void
      {
         if(this.isRuning || this.msgList.length == 0 || !this.isRending)
         {
            return;
         }
         this.isRuning = true;
         this.currMsgDes = this.msgList.shift() as SysMsgDes;
         if(this.currMsgDes.type == SysMsgDes.CUSTOM)
         {
            this.currController = this.currMsgDes.data as IMsgController;
            if(this.currController != null)
            {
               this.currController.startMSG(this.controlEnd);
            }
            else
            {
               this.controlEnd();
            }
            return;
         }
         this.currController = this.controllers[this.currMsgDes.type];
         if(this.currController == null)
         {
         }
         this.currController.startMSG(this.controlEnd,this.currMsgDes.data);
      }
      
      public function onRenderChange(param1:Boolean) : void
      {
         this.isRending = param1;
         if(!this.isRending && this.isRuning && Boolean(this.currMsgDes))
         {
            this.currController.cancel();
         }
         if(this.isRending && this.isAuto)
         {
            this.run();
         }
      }
      
      public function chunnelPush(param1:Object) : void
      {
         this.msgList.push(param1);
         if(this.isAuto && this.isRending)
         {
            this.run();
         }
      }
      
      public function chunnelPop(param1:Object = null) : Object
      {
         var _loc2_:int = this.msgList.indexOf(param1);
         if(_loc2_ == -1)
         {
            return null;
         }
         return this.msgList.splice(_loc2_,1);
      }
      
      public function setAutoRun(param1:Boolean = true) : void
      {
         this.isAuto = param1;
      }
      
      public function manualRun(param1:Boolean = true) : void
      {
         this.isAuto = param1;
         this.run();
      }
   }
}
