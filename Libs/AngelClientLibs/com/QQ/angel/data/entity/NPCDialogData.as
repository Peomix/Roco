package com.QQ.angel.data.entity
{
   public class NPCDialogData
   {
      
      public static const ITEM_ICON_STAR:uint = 0;
      
      public static const ITEM_ICON_EXCALMATORY:uint = 1;
      
      public static const ITEM_ICON_QUESTION:uint = 2;
      
      public static const ITEM_ICON_DIALOGUE:uint = 3;
      
      public static const ITEM_ICON_MONEY:uint = 4;
      
      public static const ITEM_ICON_FUNCTION:uint = 5;
      
      public static const ITEM_ICON_TIME:uint = 6;
      
      public static const BUTTON_ICON_ACCEPT:uint = 0;
      
      public static const BUTTON_ICON_REJECT:uint = 1;
       
      
      public var hash:String;
      
      public var id:int;
      
      public var dialogs:Array;
      
      public var buttons:Array;
      
      public var items:Array;
      
      public function NPCDialogData()
      {
         super();
      }
   }
}
