package com.QQ.angel.data.entity
{
   public class OpenTimesPaper extends NPCCDConvert
   {
       
      
      public var pageIndex:int = 0;
      
      public var tagIndex:Number = 0;
      
      public var itemIndex:Number = 0;
      
      public var itemName:String = "";
      
      public function OpenTimesPaper()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         var _loc4_:Object = null;
         super.tranNPCClickDes(param1);
         var _loc2_:String = String(param1.@params);
         var _loc3_:Array = _loc2_.split(",");
         if(_loc3_.length == 2)
         {
            this.tagIndex = parseInt(_loc3_[0]);
            if((_loc4_ = _loc3_[1]) is String)
            {
               this.itemName = String(_loc4_);
            }
            if(_loc4_ is int)
            {
               this.itemIndex = int(_loc4_);
            }
         }
      }
   }
}
