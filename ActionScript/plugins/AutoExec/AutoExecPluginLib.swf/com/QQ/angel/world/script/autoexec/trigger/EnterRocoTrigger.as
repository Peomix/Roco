package com.QQ.angel.world.script.autoexec.trigger
{
   import com.QQ.angel.data.entity.SceneDes;
   
   public class EnterRocoTrigger
   {
      
      public var script:XML;
      
      public function EnterRocoTrigger()
      {
         super();
      }
      
      public function willTrigger(des:SceneDes) : Boolean
      {
         return true;
      }
      
      public function parse(xml:XML) : void
      {
         script = xml.children()[0];
      }
   }
}

