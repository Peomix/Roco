package com.QQ.angel.plugs.Login.ui2.components
{
   import com.QQ.angel.plugs.Login.ui2.AngelLoginUI2;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.external.ExternalInterface;
   import flash.utils.Dictionary;
   
   public class MsgBox
   {
      
      protected var mask:Sprite;
      
      protected var connectErrorMsg:Sprite;
      
      protected var tooManyMsg:Sprite;
      
      protected var waitingMsg:Sprite;
      
      protected var wrongRoomMsg:Sprite;
      
      protected var tooManyTimeMsg:Sprite;
      
      protected var getinRoomErroMsg:Sprite;
      
      protected var childWardErrorMsg:Sprite;
      
      protected var msgMap:Dictionary;
      
      protected var currMsg:Sprite;
      
      protected var loginUI:AngelLoginUI2;
      
      public function MsgBox(param1:AngelLoginUI2, param2:Sprite, param3:Sprite, param4:Sprite, param5:Sprite, param6:Sprite, param7:Sprite, param8:Sprite, param9:Sprite)
      {
         super();
         loginUI = param1;
         msgMap = new Dictionary();
         this.mask = param2;
         msgMap[0] = this.connectErrorMsg = param3;
         msgMap[1] = this.tooManyMsg = param4;
         msgMap[2] = this.waitingMsg = param5;
         msgMap[3] = this.wrongRoomMsg = param6;
         msgMap[4] = this.tooManyTimeMsg = param7;
         msgMap[5] = this.getinRoomErroMsg = param8;
         msgMap[6] = this.childWardErrorMsg = param9;
         this.waitingMsg.mouseChildren = false;
         this.waitingMsg["ok_btn"].stop();
         ready();
      }
      
      protected function ready() : void
      {
         this.mask.visible = false;
         this.connectErrorMsg.visible = false;
         this.tooManyMsg.visible = false;
         this.waitingMsg.visible = false;
         this.wrongRoomMsg.visible = false;
         this.tooManyTimeMsg.visible = false;
         this.getinRoomErroMsg.visible = false;
         this.childWardErrorMsg.visible = false;
      }
      
      public function hidden(param1:MouseEvent = null) : void
      {
         if(this.currMsg == null)
         {
            return;
         }
         this.currMsg.visible = false;
         this.mask.visible = false;
         if(this.waitingMsg["ok_btn"] is MovieClip)
         {
            this.waitingMsg["ok_btn"].stop();
         }
         currMsg.removeEventListener(MouseEvent.CLICK,__click);
         this.currMsg = null;
      }
      
      public function show(param1:int) : void
      {
         this.currMsg = msgMap[param1] as Sprite;
         this.currMsg.visible = true;
         this.mask.visible = true;
         if(currMsg == waitingMsg && this.waitingMsg["ok_btn"] is MovieClip)
         {
            this.waitingMsg["ok_btn"].play();
         }
         currMsg.addEventListener(MouseEvent.CLICK,__click);
      }
      
      private function __click(param1:MouseEvent) : void
      {
         switch(param1.target.name)
         {
            case "ok_btn":
               hidden(param1);
               break;
            case "fastGetIn_btn":
               hidden(param1);
               loginUI.onFastGetInClick(null);
               break;
            case "refresh_btn":
               hidden(param1);
               if(ExternalInterface.available)
               {
                  ExternalInterface.call("reflashHTML");
               }
         }
      }
   }
}

