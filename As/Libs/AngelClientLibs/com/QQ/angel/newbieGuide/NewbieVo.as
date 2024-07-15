package com.QQ.angel.newbieGuide
{
   public class NewbieVo
   {
       
      
      public var triggerMode:int;
      
      public var taskId:int;
      
      public var sceneId:int;
      
      public var stepId:int;
      
      public var stepVoArr:Array;
      
      public var havePlay:Boolean;
      
      public var curStep:int;
      
      public function NewbieVo()
      {
         this.stepVoArr = [];
         super();
      }
   }
}
