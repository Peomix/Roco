package com.QQ.angel.debug.menu
{
   import flash.events.Event;
   
   public class CmdMenuEvent extends Event
   {
      
      public static const FOCUS_ITEM:String = "focusItem";
      
      public static const CLICK_ITEM:String = "clickItem";
       
      
      public var item:CmdMenuItem;
      
      public function CmdMenuEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:CmdMenuEvent = new CmdMenuEvent(this.type,this.bubbles,this.cancelable);
         _loc1_.item = this.item;
         return _loc1_;
      }
   }
}
