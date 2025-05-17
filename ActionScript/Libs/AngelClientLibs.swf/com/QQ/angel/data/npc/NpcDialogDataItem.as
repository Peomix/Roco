package com.QQ.angel.data.npc
{
   import com.QQ.angel.api.utils.CFunction;
   
   public class NpcDialogDataItem
   {
      
      public var label:String;
      
      public var icon:int = -1;
      
      public var close:Boolean;
      
      public var isFromXml:Boolean;
      
      public var nextID:int = -1;
      
      public var handler:CFunction;
      
      public var isHide:Boolean;
      
      public function NpcDialogDataItem()
      {
         super();
      }
   }
}

