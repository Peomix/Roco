package com.QQ.angel.api.ui
{
   import com.QQ.angel.api.utils.CFunction;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   
   public interface ICommUIManager
   {
      
      function createLoadingView(param1:int = 0, param2:Boolean = false) : ILoadingView;
      
      function alert(param1:String, param2:String, param3:int = 1, param4:CFunction = null) : int;
      
      function mAlert(param1:MovieClip, param2:String = "", param3:String = "", param4:Function = null, param5:Function = null) : IWindow;
      
      function createWindow(param1:*, param2:Boolean = false, param3:DisplayObjectContainer = null) : IWindow;
      
      function createScaleWinow(param1:*, param2:Boolean = false) : IWindow;
      
      function closeWindow(param1:IWindow) : void;
      
      function closeWindowByID(param1:int) : void;
      
      function createBubble(param1:int) : IBubble;
      
      function createMiniLoading() : ILoadingView;
      
      function closeMiniLoading() : void;
      
      function closeAllWindows() : void;
      
      function showManagedWin(param1:int, param2:Object = null, param3:CFunction = null) : IWindow;
      
      function showFurnitureRewardArray(param1:Array, param2:Function = null) : void;
      
      function showRewardArray(param1:Array, param2:Function = null) : void;
   }
}

