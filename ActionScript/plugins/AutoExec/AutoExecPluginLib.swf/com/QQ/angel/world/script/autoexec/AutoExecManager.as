package com.QQ.angel.world.script.autoexec
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.IAngelSysAPI;
   import com.QQ.angel.api.IGlobalDataAPI;
   import com.QQ.angel.api.events.AngelSysEvent;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.entity.WorldScriptDes;
   import com.QQ.angel.world.script.autoexec.trigger.EnterRocoTriggerManager;
   import com.QQ.angel.world.script.autoexec.trigger.EnterRoomTriggerManager;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   
   public class AutoExecManager implements ITriggerListener
   {
      
      protected var sys:IAngelSysAPI;
      
      protected var wsDes:WorldScriptDes;
      
      protected var triggerManagers:Dictionary;
      
      public function AutoExecManager(sys:IAngelSysAPI)
      {
         super();
         this.sys = sys;
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_SYSTEM_ON_GLOBAL_INITED,AutoExecManager.onGlobalInited,this);
      }
      
      private static function onGlobalInited(evtId:int, args:Object, senderInfo:Object, registerObj:Object) : int
      {
         var _this:AutoExecManager = AutoExecManager(registerObj);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_SYSTEM_ON_GLOBAL_INITED,AutoExecManager.onGlobalInited,_this);
         _this.wsDes = new WorldScriptDes();
         _this.wsDes.event = AngelSysEvent.ON_RUN_SCRIPT;
         _this.wsDes.scripts = new Dictionary();
         _this.initTriggerManager();
         _this.initTriggers();
         _this.watchTrigger();
         return CallbackCenter.EVENT_OK;
      }
      
      private static function checkCondition(args:Object, condition:String) : Boolean
      {
         if(condition.indexOf("args") == 0)
         {
            condition = condition.substr(4);
            return checkConditionStep(args,condition);
         }
         trace("error condition \'" + condition + "\'");
         return false;
      }
      
      private static function onAutoExecCallBack(evtId:int, in_args:Object, senderInfo:Object, registerObj:Object) : int
      {
         var callbackName:String = null;
         var idx:int = 0;
         var out_args:Object = null;
         var condition:String = null;
         var argsString:String = null;
         var callbackXML:XML = registerObj as XML;
         trace("AutoExecCallBack " + callbackXML.toXMLString());
         if(callbackXML != null)
         {
            callbackName = String(callbackXML.@call);
            idx = int(CALLBACK[callbackName]);
            ASSERT(idx != 0,"error");
            out_args = null;
            if(Boolean(callbackXML.@args))
            {
               argsString = String(callbackXML.@args);
               out_args = stringToObeject(argsString);
            }
            if(Boolean(callbackXML.@condition))
            {
               condition = callbackXML.@condition;
            }
            if(Boolean(condition))
            {
               if(!checkCondition(in_args,condition))
               {
                  return CallbackCenter.EVENT_OK;
               }
            }
            if(Boolean(idx))
            {
               CallbackCenter.notifyEvent(idx,out_args);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      private static function stringToObeject(argsString:String) : Object
      {
         var argsArray:Array = null;
         var i:int = 0;
         argsString = argsString.replace(/^\s+/,"").replace(/\s+$/,"");
         if(argsString.charAt(0) == "[")
         {
            ASSERT(argsString.charAt(argsString.length - 1) == "]","error Array");
            argsString = argsString.substr(1,argsString.length - 2);
            argsArray = argsString.split(",");
            for(i = 0; i < argsArray.length; i++)
            {
               argsArray[i] = stringToObeject(String(argsArray[i]));
            }
            return argsArray;
         }
         if(argsString.charAt(0) == "\'")
         {
            ASSERT(argsString.charAt(argsString.length - 1) == "\'","error string");
            return argsString.substr(1,argsString.length - 2);
         }
         if(argsString.charAt(0) == "\"")
         {
            ASSERT(argsString.charAt(argsString.length - 1) == "\"","error string");
            return argsString.substr(1,argsString.length - 2);
         }
         if(argsString == "null")
         {
            return null;
         }
         if(argsString == "undefined")
         {
            return undefined;
         }
         if(argsString == "NaN")
         {
            return NaN;
         }
         return Number(argsString);
      }
      
      private static function checkPluginNode(event:*, condition:*, pluginNode:*) : void
      {
         var childNode:XML = null;
         var callbackTemp:XML = <CallBack></CallBack>;
         callbackTemp.@on = event;
         if(condition)
         {
            callbackTemp.@condition = condition;
         }
         if(int(pluginNode.@isCall) == 1)
         {
            callbackTemp.@call = "ANGEL_SYSTEM_APPLY_CALL_A_PLUGIN_ASYNC";
            callbackTemp.@args = "[\'" + pluginNode.@name + "\', null]";
         }
         else
         {
            callbackTemp.@call = "ANGEL_SYSTEM_APPLY_INSTALL_A_PLUGIN_ASYNC";
            callbackTemp.@args = "[\'" + pluginNode.@name + "\']";
         }
         CallbackCenter.registerCallBack(CALLBACK[String(callbackTemp.@on)],AutoExecManager.onAutoExecCallBack,callbackTemp);
         for each(childNode in pluginNode.PluginNode)
         {
            checkPluginNode("ANGEL_SYSTEM_ON_A_PLUGIN_INSTALLED","args[2]==\'" + pluginNode.@name + "\'",childNode);
         }
      }
      
      private static function checkConditionStep(args:Object, condition:String) : Boolean
      {
         var sArray:Array = null;
         var comp:String = null;
         var subString:String = null;
         var leftObject:Object = null;
         var _char:String = null;
         var subFieldArray:Array = [];
         if(condition.indexOf("==") != -1)
         {
            sArray = condition.split("==");
            comp = "==";
         }
         else if(condition.indexOf("!=") != -1)
         {
            sArray = condition.split("!=");
            comp = "!=";
         }
         else if(condition.indexOf(">=") != -1)
         {
            sArray = condition.split(">=");
            comp = ">=";
         }
         else if(condition.indexOf(">") != -1)
         {
            sArray = condition.split(">");
            comp = ">";
         }
         else if(condition.indexOf("<") != -1)
         {
            sArray = condition.split("<");
            comp = "<";
         }
         else if(condition.indexOf("<=") != -1)
         {
            sArray = condition.split("<=");
            comp = "<=";
         }
         else
         {
            ASSERT(false,"error");
         }
         var leftCmd:String = sArray[0];
         for(var s:int = 0; s < leftCmd.length; s++)
         {
            _char = leftCmd.charAt(s);
            if(_char == "[")
            {
               subString = "";
            }
            else if(_char == "]")
            {
               subFieldArray.push(stringToObeject(subString));
            }
            else
            {
               subString += _char;
            }
         }
         var argsP:Object = args;
         for(var _p:int = 0; _p < subFieldArray.length; _p++)
         {
            leftObject = argsP[subFieldArray[_p]];
            argsP = leftObject;
         }
         var rightObject:Object = stringToObeject(sArray[1]);
         switch(comp)
         {
            case "==":
               return leftObject == rightObject;
            case "!=":
               return leftObject != rightObject;
            case ">=":
               return leftObject >= rightObject;
            case ">":
               return leftObject > rightObject;
            case "<":
               return leftObject < rightObject;
            case "<=":
               return leftObject <= rightObject;
            default:
               return false;
         }
      }
      
      protected function initTriggerManager() : void
      {
         var cls:Class = null;
         var tm:ITriggerManager = null;
         var dispther:IEventDispatcher = sys.getGEventAPI().angelEventDispatcher;
         var gData:IGlobalDataAPI = sys.getGDataAPI();
         var triggerCls:Array = [EnterRoomTriggerManager,EnterRocoTriggerManager];
         triggerManagers = new Dictionary();
         for each(cls in triggerCls)
         {
            tm = new cls();
            tm.addListener(this);
            triggerManagers[tm.getType()] = tm;
         }
      }
      
      public function fireExec(script:XML) : void
      {
         if(script == null)
         {
            return;
         }
         wsDes.scripts["default"] = script;
         sys.getGEventAPI().cmdExecuted(AngelSysEvent.ON_RUN_SCRIPT,wsDes);
      }
      
      protected function watchTrigger() : void
      {
         var type:String = null;
         var tm:ITriggerManager = null;
         for(type in triggerManagers)
         {
            tm = triggerManagers[type];
            if(tm != null)
            {
               tm.watch();
            }
         }
      }
      
      protected function initTriggers() : void
      {
         var trigger:XML = null;
         var type:String = null;
         var tm:ITriggerManager = null;
         var confs:Object = sys.getGDataAPI().getGlobalVal(Constants.CONFS);
         var conf:Object = confs["AutoExec"];
         if(conf == null)
         {
            return;
         }
         var autoExecXML:XML = conf is XML ? conf as XML : new XML(conf.toString());
         var triggers:XMLList = autoExecXML.Trigger;
         for(var i:int = 0; i < triggers.length(); i++)
         {
            trigger = triggers[i];
            type = trigger.@type;
            tm = triggerManagers[type];
            if(tm != null)
            {
               tm.addTrigger(trigger);
            }
         }
         initCallBack(autoExecXML.CallBackInfo);
         initPluginDependence(autoExecXML.PluginDependence);
      }
      
      private function initCallBack(callbackInfoXml:XMLList) : void
      {
         var callback:XML = null;
         var idx:int = 0;
         for each(callback in callbackInfoXml.CallBack)
         {
            idx = int(CALLBACK[String(callback.@on)]);
            ASSERT(idx != 0,"error");
            if(Boolean(idx))
            {
               CallbackCenter.registerCallBack(idx,AutoExecManager.onAutoExecCallBack,callback);
            }
         }
      }
      
      private function initPluginDependence(pluginDependenceXML:XMLList) : void
      {
         var event:XML = null;
         var condition:String = null;
         var pluginNode:XML = null;
         for each(event in pluginDependenceXML.Event)
         {
            condition = null;
            if(event.@condition.length() > 0)
            {
               condition = String(event.@condition);
            }
            for each(pluginNode in event.PluginNode)
            {
               checkPluginNode(event.@on,condition,pluginNode);
            }
         }
      }
   }
}

