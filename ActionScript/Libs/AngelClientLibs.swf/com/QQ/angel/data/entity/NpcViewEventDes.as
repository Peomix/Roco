package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.utils.CFunction;
   
   public class NpcViewEventDes
   {
      
      public var eType:String;
      
      public var handler:CFunction;
      
      public var clickDes:NPCCDConvert;
      
      public function NpcViewEventDes(param1:XML = null, param2:int = 0, param3:String = "")
      {
         super();
         this.analyse(param1,param2,param3);
      }
      
      public function analyse(param1:XML, param2:int = 0, param3:String = "") : void
      {
         if(param1 == null)
         {
            return;
         }
         this.eType = param1.@type;
         this.clickDes = NpcFuncDes.ProcessClickXML(param1.Click[0],param2,param3);
      }
   }
}

