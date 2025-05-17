package com.QQ.angel.api.ui
{
   public interface ILoadingView extends IWindow
   {
      
      function setProgress(param1:Number) : void;
      
      function setTipText(param1:String) : void;
      
      function setLabel(param1:String, param2:String = "") : void;
      
      function setBackGround(param1:*) : void;
      
      function setCancelEnabled(param1:Boolean = false, param2:Function = null) : void;
      
      function getType() : int;
   }
}

