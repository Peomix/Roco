package com.QQ.angel.data.npc
{
   import com.QQ.angel.api.utils.CFunction;
   
   public class NpcDialogDataButton
   {
       
      
      public var label:String;
      
      public var handler:CFunction;
      
      public var icon:int = -1;
      
      public var isFromXml:Boolean;
      
      public var isHide:Boolean;
      
      public var close:Boolean;
      
      public var nextID:int = -1;
      
      public function NpcDialogDataButton()
      {
         super();
      }
   }
}
