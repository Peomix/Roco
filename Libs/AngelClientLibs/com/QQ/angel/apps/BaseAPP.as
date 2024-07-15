package com.QQ.angel.apps
{
   import com.QQ.angel.api.IAngelApp;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IParamsAware;
   import com.QQ.angel.api.IXMLScriptParamsAware;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.net.INetSystem;
   import com.QQ.angel.ui.core.IScaleWindowContent;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.net.URLLoader;
   
   public class BaseAPP extends Sprite implements IScaleWindowContent, IParamsAware, IAngelApp, IXMLScriptParamsAware
   {
       
      
      protected var m_handle:Function;
      
      protected var m_param:Object;
      
      protected var m_scriptParam:Object;
      
      protected var m_sysAPI:IAngelSysAPI;
      
      public function BaseAPP()
      {
         super();
      }
      
      public function getDisplay() : DisplayObject
      {
         return this;
      }
      
      public function getBGRect() : Point
      {
         return null;
      }
      
      public function getCloseBtnPos() : Point
      {
         return null;
      }
      
      public function close() : void
      {
         if(this.m_handle != null)
         {
            this.m_handle();
         }
      }
      
      public function addCloseHandler(param1:Function) : void
      {
         this.m_handle = param1;
      }
      
      public function getDragArea() : InteractiveObject
      {
         return null;
      }
      
      public function dispose() : void
      {
      }
      
      public function setParams(param1:*) : void
      {
         this.m_param = param1;
         this.onParams();
      }
      
      protected function onParams() : void
      {
      }
      
      public function setScriptParams(param1:*) : void
      {
         this.m_scriptParam = param1;
         this.onScriptParams();
      }
      
      protected function onScriptParams() : void
      {
      }
      
      public function setup() : void
      {
      }
      
      public function activate() : void
      {
      }
      
      public function inactivate() : void
      {
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.m_sysAPI = param1;
         this.initialize();
      }
      
      protected function initialize() : void
      {
      }
      
      protected function getLoader() : URLLoader
      {
         return (__global.SysAPI.getNetSysAPI() as INetSystem).createURLLoader(true);
      }
   }
}
