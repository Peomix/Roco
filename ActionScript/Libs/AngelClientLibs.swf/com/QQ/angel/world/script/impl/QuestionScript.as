package com.QQ.angel.world.script.impl
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.QQ.angel.utils.AString;
   import com.QQ.angel.world.net.protocol.P_ReqQuestion;
   import com.QQ.angel.world.script.ScriptTypes;
   import com.QQ.angel.world.vo.DialogItemXML;
   
   public class QuestionScript extends VarDialogScript
   {
      
      protected var currXML:XML;
      
      public function QuestionScript()
      {
         super();
         this.type = ScriptTypes.QUESTION;
      }
      
      protected function onGotRuestion(param1:P_ReqQuestion) : void
      {
         __global.UI.closeMiniLoading();
         if(param1.code.isError())
         {
            noticeComplete(null);
            return;
         }
         var _loc2_:String = param1.question.replace(/\\n/g,"\n");
         global["question"] = _loc2_;
         global["answer"] = param1.answer;
         super.execute(this.currXML);
      }
      
      override public function everyItem(param1:DialogItemXML) : void
      {
         var _loc2_:String = null;
         if(param1.child != null)
         {
            _loc2_ = param1.child.toXMLString();
            param1.child = new XML(AString.TranArgs(_loc2_,global));
         }
         super.everyItem(param1);
      }
      
      override public function execute(param1:XML) : void
      {
         __global.UI.createMiniLoading();
         this.currXML = param1;
         var _loc2_:P_FreeRequest = new P_FreeRequest(ADFCmdsType.T_SCENE_QUESTION,null,P_ReqQuestion,this.onGotRuestion);
         _loc2_.send();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.currXML = null;
      }
   }
}

