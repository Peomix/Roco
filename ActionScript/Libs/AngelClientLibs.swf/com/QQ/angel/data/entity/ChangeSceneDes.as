package com.QQ.angel.data.entity
{
   public class ChangeSceneDes extends NPCCDConvert
   {
      
      public var sceneID:int;
      
      public var randomIDs:Array;
      
      public var verList:Array;
      
      public var dialogTxt:String;
      
      public var uin:uint = 0;
      
      public var name:String = "";
      
      public var ver:int = 1;
      
      public function ChangeSceneDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         var _loc3_:String = null;
         super.tranNPCClickDes(param1);
         var _loc2_:String = String(param1.@params);
         if(_loc2_.indexOf(",") == -1)
         {
            this.sceneID = int(_loc2_);
         }
         else
         {
            this.randomIDs = _loc2_.split(",");
         }
         if(param1.@ver != undefined)
         {
            _loc3_ = param1.@ver;
            if(_loc3_.indexOf(",") == -1)
            {
               this.ver = int(_loc3_);
            }
            else
            {
               this.verList = _loc3_.split(",");
            }
         }
         this.dialogTxt = words;
         this.uin = uint(param1.@uin);
         this.name = String(param1.@name);
      }
   }
}

