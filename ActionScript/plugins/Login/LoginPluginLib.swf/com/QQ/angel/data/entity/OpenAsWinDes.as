package com.QQ.angel.data.entity
{
   import flash.geom.Point;
   
   public class OpenAsWinDes extends NPCCDConvert
   {
      
      public var winPos:Point;
      
      public var src:String;
      
      public var name:String;
      
      public var isModal:Boolean;
      
      public var params:*;
      
      public var created:Function;
      
      public var cache:Boolean;
      
      public var xmlScriptParams:*;
      
      public function OpenAsWinDes()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.winPos = null;
         this.src = null;
         this.name = null;
         this.params = null;
         this.created = null;
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         var _loc3_:Array = null;
         super.tranNPCClickDes(param1);
         var _loc2_:String = String(param1.@winPos);
         if(_loc2_.indexOf("|") != -1)
         {
            _loc3_ = _loc2_.split("|");
            this.winPos = new Point(_loc3_[0],_loc3_[1]);
         }
         this.src = param1.@src;
         this.name = param1.@name;
         this.isModal = String(param1.@isModal) == "true";
         this.params = String(param1.@params);
         this.cache = String(param1.@cache) == "true";
         this.xmlScriptParams = String(param1.@scriptParams);
      }
   }
}

