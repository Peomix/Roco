package com.QQ.angel.world.script
{
   import com.QQ.angel.api.events.AngelDataEvent;
   import com.QQ.angel.api.events.BaseEvent;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.NPCCDConvert;
   import com.QQ.angel.data.entity.WorldScriptDes;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class RunScriptThread implements IScriptRunnable
   {
      
      protected var scripts:Dictionary;
      
      protected var currScript:IScript;
      
      protected var source:NPCCDConvert;
      
      protected var vars:Object;
      
      protected var factory:IScriptFactory;
      
      public function RunScriptThread(param1:IScriptFactory)
      {
         super();
         this.factory = param1;
      }
      
      protected function removeCurrScript() : void
      {
         if(this.currScript == null)
         {
            return;
         }
         this.currScript.removeEventListener(Event.COMPLETE,this.onScriptComplete);
         this.currScript.dispose();
         this.currScript = null;
      }
      
      protected function addCurrScript(param1:IScript, param2:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.currScript = param1;
         this.currScript.setSource(this.source);
         this.currScript.setGlobalVars(this.vars);
         this.currScript.addEventListener(Event.COMPLETE,this.onScriptComplete);
         this.currScript.execute(param2);
      }
      
      protected function onScriptComplete(param1:BaseEvent) : void
      {
         var _loc3_:AngelDataEvent = null;
         var _loc2_:XML = param1.data as XML;
         this.removeCurrScript();
         if(_loc2_ != null)
         {
            this.execute(_loc2_);
         }
         if(this.currScript == null)
         {
            trace("[RunScriptThread] 所有脚本执行完毕!!");
            _loc3_ = new AngelDataEvent("executeClickCallBack");
            _loc3_.data = this.source;
            __global.DataAPI.dispatchEvent(_loc3_);
         }
      }
      
      public function execute(param1:XML) : void
      {
         var _loc3_:IScript = null;
         this.removeCurrScript();
         var _loc2_:String = param1.name().toString();
         switch(_loc2_)
         {
            case "Script":
               _loc3_ = this.factory.createScript(param1.@type);
               break;
            case "Goto":
               this.execute(this.scripts[String(param1.@value)]);
               return;
            case "End":
               break;
            default:
               FuncManager.getInstance().funcCallVoid(param1,this.source,this.vars,_loc2_,this);
         }
         this.addCurrScript(_loc3_,param1);
      }
      
      public function start(param1:WorldScriptDes) : void
      {
         var _loc3_:AngelDataEvent = null;
         if(this.isRuning())
         {
            this.removeCurrScript();
            trace("###############一个脚本正在执行...##########");
         }
         this.source = param1;
         this.vars = {};
         this.scripts = param1.scripts;
         var _loc2_:XML = this.scripts["default"];
         if(_loc2_ == null)
         {
            _loc2_ = this.scripts["0"];
         }
         this.execute(_loc2_);
         if(this.currScript == null)
         {
            trace("[RunScriptThread] 所有脚本执行完毕!!");
            _loc3_ = new AngelDataEvent("executeClickCallBack");
            _loc3_.data = this.source;
            __global.GEventAPI.angelEventDispatcher.dispatchEvent(_loc3_);
            this.dispose();
         }
      }
      
      public function stop() : void
      {
      }
      
      public function isRuning() : Boolean
      {
         return this.currScript != null;
      }
      
      public function getCurrent() : IScript
      {
         return this.currScript;
      }
      
      public function dispose() : void
      {
         this.removeCurrScript();
         this.scripts = null;
         this.source = null;
         this.vars = null;
         this.factory = null;
      }
   }
}

