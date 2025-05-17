package com.QQ.angel.data.entity
{
   import com.QQ.angel.utils.AString;
   import flash.geom.Point;
   
   public class NPCCDConvert
   {
      
      public var target:*;
      
      public var npcID:int;
      
      public var npcname:String;
      
      public var fire:Boolean;
      
      public var logArgs:Array;
      
      public var aimPos:Point;
      
      public var event:String;
      
      public var distance:int;
      
      public var words:String;
      
      public function NPCCDConvert()
      {
         super();
      }
      
      public function tranNPCClickDes(param1:XML) : void
      {
         var _loc2_:String = param1.@aimPos;
         if(_loc2_ != "")
         {
            this.aimPos = AString.TranPoint(_loc2_);
         }
         var _loc3_:String = param1.@log;
         if(_loc3_ != "")
         {
            this.logArgs = _loc3_.split("|");
         }
         var _loc4_:String = param1.@cdtn;
         if(_loc4_ == "")
         {
            this.distance = -1;
         }
         else
         {
            this.distance = int(_loc4_);
         }
         this.words = param1.Dialog[0];
         this.fire = String(param1.@fire) == "true";
         if(param1.@fireID != undefined)
         {
            this.npcID = int(param1.@fireID);
         }
      }
   }
}

