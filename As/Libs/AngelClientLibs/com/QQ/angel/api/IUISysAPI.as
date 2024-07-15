package com.QQ.angel.api
{
   import com.QQ.angel.api.ui.ICommUIManager;
   import com.QQ.angel.api.ui.IEffectManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Rectangle;
   
   public interface IUISysAPI
   {
       
      
      function get commUIManager() : ICommUIManager;
      
      function get effectManager() : IEffectManager;
      
      function getEffectContainer(param1:int = 0) : DisplayObjectContainer;
      
      function getPlugContainer() : DisplayObjectContainer;
      
      function getWorldContainer() : DisplayObjectContainer;
      
      function getWindowContainer() : DisplayObjectContainer;
      
      function setMouseEnabled(param1:Boolean) : void;
      
      function setCursor(param1:*) : void;
      
      function printScreen(param1:Rectangle, param2:int = 0) : BitmapData;
      
      function getScreenWidth() : Number;
      
      function getScreenHeight() : Number;
      
      function bindSystemResApi(param1:IResourceSysAPI) : void;
      
      function setUIEnabled(param1:Boolean) : void;
   }
}
