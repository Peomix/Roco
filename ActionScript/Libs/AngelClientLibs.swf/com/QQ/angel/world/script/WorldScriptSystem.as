package com.QQ.angel.world.script
{
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IAngelSysAPIAware;
   import com.QQ.angel.api.command.ICmdListener;
   import com.QQ.angel.api.error.AngelError;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.api.plug.extension.IExtensionRegistry;
   import com.QQ.angel.data.entity.WorldScriptDes;
   import com.QQ.angel.world.script.impl.AlertScript;
   import com.QQ.angel.world.script.impl.AsWindowScript;
   import com.QQ.angel.world.script.impl.DialogScript;
   import com.QQ.angel.world.script.impl.QuestionScript;
   import com.QQ.angel.world.script.impl.SwitchScript;
   import com.QQ.angel.world.script.impl.VarDialogScript;
   import com.QQ.angel.world.script.syscmd.SystemCommandListener;
   import flash.utils.Dictionary;
   
   public class WorldScriptSystem implements IAngelSysAPIAware, ICmdListener, IScriptFactory
   {
      
      protected var sysApi:IAngelSysAPI;
      
      protected var scriptClsMap:Dictionary;
      
      public function WorldScriptSystem()
      {
         super();
      }
      
      public function initialize() : void
      {
         this.scriptClsMap = new Dictionary();
         this.scriptClsMap[ScriptTypes.SWITCH] = SwitchScript;
         this.scriptClsMap[ScriptTypes.DIALOG] = DialogScript;
         this.scriptClsMap[ScriptTypes.VARDIALOG] = VarDialogScript;
         this.scriptClsMap[ScriptTypes.QUESTION] = QuestionScript;
         this.scriptClsMap[ScriptTypes.ALERT] = AlertScript;
         this.scriptClsMap[ScriptTypes.ASWINDOW] = AsWindowScript;
         this.sysApi.getGEventAPI().addCmdListener(AngelSysEvent.ON_RUN_SCRIPT,this);
         var _loc1_:IExtensionRegistry = this.sysApi.getPlugSysAPI().getExtensionRegistry();
         _loc1_.addExtension("com.QQ.angel.plugs.chat.extensions",new SystemCommandListener());
      }
      
      public function finalize() : void
      {
      }
      
      public function setAngelSysAPI(param1:IAngelSysAPI) : void
      {
         this.sysApi = param1;
      }
      
      public function call(param1:Object) : *
      {
         var _loc2_:RunScriptThread = null;
         if(param1 is WorldScriptDes)
         {
            _loc2_ = new RunScriptThread(this);
            _loc2_.start(param1 as WorldScriptDes);
         }
      }
      
      public function createScript(param1:String) : IScript
      {
         var _loc2_:Class = this.scriptClsMap[param1];
         if(_loc2_ == null)
         {
            throw new AngelError(param1 + "没有找到相应的脚本执行器",this);
         }
         return new _loc2_() as IScript;
      }
   }
}

