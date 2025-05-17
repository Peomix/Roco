package com.QQ.angel.data.entity
{
   public class OpenInviteFriendDes extends NPCCDConvert
   {
      
      public var viewType:int = 1;
      
      public function OpenInviteFriendDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.viewType = int(param1.@params);
      }
   }
}

