package com.QQ.angel.world.vo
{
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.world.VisibleXML;
   
   public class DialogItemXML
   {
      
      public var child:XML;
      
      public var label:String;
      
      public var icon:int;
      
      public var nextID:int;
      
      public var close:Boolean;
      
      public var handler:CFunction;
      
      public var visibleXML:VisibleXML;
      
      public function DialogItemXML(param1:XML = null)
      {
         super();
         if(param1 != null)
         {
            this.paseXML(param1);
         }
      }
      
      public function paseXML(param1:XML) : void
      {
         this.label = param1.@label;
         this.label = __global.escDialogText(this.label);
         if(param1.@icon != undefined)
         {
            this.icon = int(param1.@icon);
         }
         else
         {
            this.icon = -1;
         }
         if(param1.@nextID != undefined)
         {
            this.nextID = int(param1.@nextID);
         }
         this.close = String(param1.@close) == "true";
         this.child = param1.children()[0];
      }
   }
}

