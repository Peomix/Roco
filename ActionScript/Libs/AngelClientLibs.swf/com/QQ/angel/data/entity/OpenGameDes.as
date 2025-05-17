package com.QQ.angel.data.entity
{
   import com.QQ.angel.api.utils.CFunction;
   
   public class OpenGameDes extends NPCCDConvert
   {
      
      public var gameType:int;
      
      public var gameID:int;
      
      public var cGameID:int;
      
      public var gameName:String;
      
      public var gameURL:String;
      
      public var gameParms:String;
      
      public var dialogTxt:String;
      
      public var localGame:Boolean;
      
      public var handler:CFunction;
      
      public var resultHandler:CFunction;
      
      public function OpenGameDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         var _loc3_:Array = null;
         super.tranNPCClickDes(param1);
         this.dialogTxt = words;
         words = "";
         var _loc2_:String = param1.@params;
         if(param1.@type == undefined)
         {
            _loc3_ = _loc2_.split("|");
            this.gameType = int(_loc3_[0]);
            this.gameName = _loc3_[1];
            this.gameURL = _loc3_[2];
            this.gameID = _loc3_[3];
         }
         else
         {
            this.gameType = int(param1.@type);
            this.gameName = param1.@name;
            this.gameURL = param1.@src;
            this.gameID = int(param1.@id);
            this.cGameID = int(param1.@cid);
            this.gameParms = _loc2_;
         }
      }
   }
}

