package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.utils.AString;
   import com.QQ.angel.world.script.ScriptTypes;
   
   public class VarDialogScript extends DialogScript
   {
       
      
      public function VarDialogScript()
      {
         super();
         this.type = ScriptTypes.VARDIALOG;
      }
      
      override public function everyDialog(param1:Object) : void
      {
         super.everyDialog(param1);
         param1.text = AString.TranArgs(param1.text,global);
      }
   }
}
