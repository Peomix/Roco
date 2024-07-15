package com.QQ.angel.data.entity
{
   public class PluginCallDes extends NPCCDConvert
   {
       
      
      public var cmdType:String;
      
      public function PluginCallDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.cmdType = param1.@params;
      }
   }
}
