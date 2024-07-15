package com.QQ.angel.api.events
{
   public class ResAdapterEvent extends BaseEvent
   {
      
      public static const RES_LOAD:String = "resLoad";
      
      public static const RES_CANCEL:String = "resCancel";
      
      public static const RES_OK:String = "resOk";
       
      
      public function ResAdapterEvent(param1:String, param2:Boolean = false, param3:Boolean = false)
      {
         super(param1,param2,param3);
      }
   }
}
