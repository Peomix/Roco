package com.QQ.angel.api.ui
{
   import flash.events.IEventDispatcher;
   
   public interface IWindow extends IEventDispatcher
   {
      
      function close() : void;
      
      function center() : void;
      
      function show() : void;
      
      function hide() : void;
      
      function moveTo(param1:Number, param2:Number) : void;
      
      function setSize(param1:int, param2:int) : void;
      
      function bind(param1:IWindow) : Boolean;
      
      function unbind(param1:IWindow) : Boolean;
      
      function bringToFront() : void;
      
      function bringWToFront() : void;
      
      function backToBottom() : void;
      
      function get initialized() : Boolean;
      
      function get isModal() : Boolean;
      
      function get id() : int;
      
      function get closeAction() : String;
      
      function set closeAction(param1:String) : void;
      
      function getContent() : *;
   }
}

