package com.QQ.angel.data.entity
{
   public class OpenNPCDialog extends NPCCDConvert
   {
      
      public var npcName:String;
      
      public var dialogs:Array;
      
      public var buttons:Array;
      
      public var npcURL:String;
      
      public function OpenNPCDialog()
      {
         super();
      }
      
      public function setDialogTxt(param1:String) : void
      {
         var txt:String = param1;
         var temp:String = txt;
         try
         {
            npcID = int(temp.split("$i$")[0]);
            temp = temp.split("$i$")[1];
            this.npcName = temp.split("$n$")[0];
            this.dialogs = temp.split("$n$")[1].split("$#$");
         }
         catch(err:Error)
         {
            trace("文本协议不正确,内容为:" + String(txt));
         }
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         super.tranNPCClickDes(param1);
         this.setDialogTxt(words);
         words = "";
      }
   }
}

