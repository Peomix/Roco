package com.QQ.angel.world.vo
{
   import com.QQ.angel.data.entity.NPCCDConvert;
   
   public class ACTIVENPCVo extends NPCCDConvert
   {
       
      
      public var funName:String;
      
      public function ACTIVENPCVo()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.funName = param1.params == undefined ? "setActiveNPC" : param1.params;
      }
   }
}
