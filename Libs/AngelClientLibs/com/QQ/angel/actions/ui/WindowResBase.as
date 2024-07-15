package com.QQ.angel.actions.ui
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.ui.core.Window;
   import com.QQ.angel.ui.core.WindowCloseAction;
   import flash.display.SimpleButton;
   
   public class WindowResBase extends Window
   {
       
      
      public var closeButton:SimpleButton;
      
      public function WindowResBase()
      {
         super();
         closeAction = WindowCloseAction.HIDE;
      }
      
      public function showPanel() : void
      {
         if(!initialized)
         {
            initialize(__global.SysAPI.getUISysAPI().getWindowContainer(),null,this.closeButton);
         }
         else
         {
            show();
         }
      }
   }
}
