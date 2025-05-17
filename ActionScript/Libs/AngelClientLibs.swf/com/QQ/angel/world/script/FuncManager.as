package com.QQ.angel.world.script
{
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.NPCCDConvert;
   import com.QQ.angel.logging.log;
   import com.QQ.angel.utils.AString;
   import com.QQ.angel.world.script.func.InvokeCGI;
   import com.QQ.angel.world.script.func.InvokeCombat;
   import com.QQ.angel.world.script.func.InvokeGame;
   import com.QQ.angel.world.script.func.InvokeHave;
   import com.QQ.angel.world.script.func.InvokeHeroData;
   import com.QQ.angel.world.script.func.InvokeNpcVal;
   import com.QQ.angel.world.script.func.InvokeProtoB;
   import com.QQ.angel.world.script.func.InvokeSceneVal;
   import com.QQ.angel.world.script.func.InvokeTaskIsComplete;
   import com.QQ.angel.world.utils.WorldHelper;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   
   public class FuncManager
   {
      
      private static var __instance:FuncManager;
      
      protected var funcClss:Dictionary;
      
      protected var funcObjs:Dictionary;
      
      public function FuncManager()
      {
         super();
         if(__instance != null)
         {
            throw new Error("单例类不允许创建多个!");
         }
         this.funcClss = new Dictionary();
         this.funcClss["have"] = InvokeHave;
         this.funcClss["combat"] = InvokeCombat;
         this.funcClss["game"] = InvokeGame;
         this.funcClss["npcVal"] = InvokeNpcVal;
         this.funcClss["sceneVal"] = InvokeSceneVal;
         this.funcClss["loadCGI"] = InvokeCGI;
         this.funcClss["taskIsComplete"] = InvokeTaskIsComplete;
         this.funcClss["heroData"] = InvokeHeroData;
         this.funcClss["protoBuf"] = InvokeProtoB;
         this.funcObjs = new Dictionary();
      }
      
      public static function getInstance() : FuncManager
      {
         if(__instance == null)
         {
            __instance = new FuncManager();
         }
         return __instance;
      }
      
      public function createFunc(param1:XML) : IInvokeFunc
      {
         var _loc4_:Class = null;
         var _loc2_:String = param1.@invoke;
         var _loc3_:IInvokeFunc = this.funcObjs[_loc2_];
         if(_loc3_ == null)
         {
            _loc4_ = this.funcClss[_loc2_];
            if(_loc4_ != null)
            {
               _loc3_ = new _loc4_() as IInvokeFunc;
            }
         }
         return _loc3_;
      }
      
      public function funcCallVoid(param1:XML, param2:NPCCDConvert, param3:Object = null, param4:String = "", param5:IScriptRunnable = null) : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = undefined;
         var _loc8_:NPCCDConvert = null;
         var _loc9_:XMLList = null;
         var _loc10_:* = undefined;
         var _loc11_:URLRequest = null;
         var _loc12_:Array = null;
         var _loc13_:int = 0;
         if(param4 == "")
         {
            param4 = param1.name().toString();
         }
         switch(param4)
         {
            case "Click":
               _loc8_ = this.createClick(param1,param2);
               __global.executeClick(_loc8_);
               break;
            case "Alert":
               _loc7_ = AString.TranArgs(param1.toString(),param3);
               __global.UI.alert(param1.@title,_loc7_);
               break;
            case "UpdateNpcVal":
               if(param1.@args == undefined)
               {
                  _loc6_ = int(param1.@id);
                  _loc7_ = param1.@value;
               }
               else
               {
                  _loc12_ = AString.TranArgs(param1.@args,param3).split("|");
                  _loc6_ = int(_loc12_[0]);
                  _loc7_ = _loc12_[1];
               }
               __global.DataAPI.updateNpcVal(_loc6_,_loc7_);
               break;
            case "DisplayAward":
               WorldHelper.displayAward();
               break;
            case "Batch":
               if(param1.Goto.length() >= 2)
               {
                  throw new Error("[FuncManager]Batch节点不能有两个Goto标签!!");
               }
               _loc9_ = param1.children();
               _loc13_ = 0;
               while(_loc13_ < _loc9_.length())
               {
                  this.funcCallVoid(_loc9_[_loc13_],param2,param3,"",param5);
                  _loc13_++;
               }
               break;
            case "Goto":
               if(param5 != null)
               {
                  param5.execute(param1);
               }
               break;
            case "Log":
               _loc10_ = param1.@cmd;
               log(int(param1.@id),_loc10_ == undefined ? 1 : int(_loc10_));
               break;
            case "Link":
               _loc11_ = new URLRequest(String(param1.@src));
               navigateToURL(_loc11_);
         }
      }
      
      protected function createClick(param1:XML, param2:NPCCDConvert) : NPCCDConvert
      {
         var _loc3_:String = param1.@event;
         var _loc4_:NPCCDConvert = __global.createNPCCD(_loc3_);
         _loc4_.event = _loc3_;
         if(param2 != null)
         {
            _loc4_.target = param2.target;
            _loc4_.npcname = param2.npcname;
            if(param1.@fireID == undefined)
            {
               _loc4_.npcID = param2.npcID;
            }
            else
            {
               _loc4_.npcID = int(param1.@fireID);
            }
            _loc4_.aimPos = param2.aimPos;
         }
         _loc4_.tranNPCClickDes(param1);
         return _loc4_;
      }
   }
}

