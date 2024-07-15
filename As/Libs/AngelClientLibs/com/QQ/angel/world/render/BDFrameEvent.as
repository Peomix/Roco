package com.QQ.angel.world.render
{
   import flash.events.Event;
   
   public class BDFrameEvent extends Event
   {
      
      public static const ON_ENTERLABEL:String = "onEnterLabel";
      
      public static const ON_ENDFRAME:String = "onEndFrame";
       
      
      public var label:String = "";
      
      public function BDFrameEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         var _loc1_:BDFrameEvent = new BDFrameEvent(this.type);
         _loc1_.label = this.label;
         return _loc1_;
      }
   }
}
