package com.QQ.angel.world.script.autoexec.trigger
{
   import com.QQ.angel.data.entity.SceneDes;
   
   public class EnterRoomTrigger
   {
      
      public var once:Boolean;
      
      public var ids:String;
      
      public var script:XML;
      
      public function EnterRoomTrigger()
      {
         super();
      }
      
      public function parse(xml:XML) : void
      {
         ids = "," + String(xml.@ids) + ",";
         once = String(xml.@once) == "true";
         script = xml.children()[0];
      }
      
      public function willTrigger(des:SceneDes) : Boolean
      {
         if(ids != null && ids.indexOf("," + des.sceneID + ",") != -1)
         {
            return true;
         }
         return false;
      }
   }
}

