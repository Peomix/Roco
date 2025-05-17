package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.api.ui.IWindow;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.world.script.ScriptTypes;
   import com.QQ.angel.world.vo.DialogItemXML;
   import com.QQ.angel.world.vo.DialogPageXML;
   
   public class DialogScript extends AbstractScript
   {
      
      protected var dialogWin:IWindow;
      
      public function DialogScript()
      {
         super(ScriptTypes.DIALOG);
      }
      
      public function everyItem(param1:DialogItemXML) : void
      {
         param1.handler = new CFunction(noticeComplete,this,[param1.child]);
      }
      
      public function everyDialog(param1:Object) : void
      {
         if(param1.hasOwnProperty("npcID"))
         {
            param1.npcURL = __global.getNPCPreview(param1["npcID"]);
         }
         param1.text = __global.escDialogText(param1.text);
      }
      
      override public function execute(param1:XML) : void
      {
         var _loc2_:XMLList = param1.Page;
         var _loc3_:Array = [];
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_.length())
         {
            _loc3_.push(new DialogPageXML(_loc2_[_loc4_],this));
            _loc4_++;
         }
         __global.UI.showManagedWin(9,_loc3_,new CFunction(noticeComplete,this));
      }
   }
}

