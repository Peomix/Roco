package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.NPCDialogData;
   import com.QQ.angel.newbieGuide.NewbieGuideModuleVo;
   import com.QQ.angel.newbieGuide.NewbieVo;
   import com.QQ.angel.newbieGuide.StepVo;
   import flash.utils.Dictionary;
   
   public class NewbieGuideDataProxy implements IDataProxy
   {
       
      
      private var xml:XML;
      
      private var dic:Dictionary;
      
      public function NewbieGuideDataProxy(param1:Object)
      {
         super();
         this.dic = new Dictionary();
         this.processXML(param1);
      }
      
      private function processXML(param1:Object) : void
      {
         var _loc2_:NewbieVo = null;
         var _loc3_:StepVo = null;
         var _loc4_:XMLList = null;
         var _loc5_:String = null;
         var _loc6_:NewbieGuideModuleVo = null;
         var _loc7_:NPCDialogData = null;
         var _loc8_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         this.xml = param1 is XML ? param1 as XML : new XML(param1);
         var _loc9_:int = 0;
         while(_loc9_ < this.xml.guide.length())
         {
            _loc2_ = new NewbieVo();
            _loc2_.triggerMode = int(this.xml.guide[_loc9_].@triggerMode);
            _loc2_.sceneId = int(this.xml.guide[_loc9_].@sceneId);
            _loc2_.stepId = int(this.xml.guide[_loc9_].@stepId);
            _loc10_ = 0;
            while(_loc10_ < this.xml.guide[_loc9_].step.length())
            {
               _loc3_ = new StepVo();
               _loc4_ = this.xml.guide[_loc9_].step[_loc10_].children();
               _loc11_ = 0;
               while(_loc11_ < _loc4_.length())
               {
                  _loc5_ = _loc4_[_loc11_].localName();
                  _loc6_ = new NewbieGuideModuleVo();
                  switch(_loc5_)
                  {
                     case "arrowGuide":
                        _loc6_.type = 1;
                        _loc6_.arrow = int(_loc4_[_loc11_].@arrow);
                        _loc6_.maskType = int(_loc4_[_loc11_].@maskType);
                        _loc6_.moduleName = String(_loc4_[_loc11_].@moduleName);
                        _loc6_.targetId = String(_loc4_[_loc11_].@targetId);
                        _loc6_.tooltip = String(_loc4_[_loc11_].@tooltip);
                        if(_loc4_[_loc11_].@interactiveRect != undefined)
                        {
                           _loc6_.interactiveRect = String(_loc4_[_loc11_].@interactiveRect);
                        }
                        if(_loc4_[_loc11_].@actionEnabled != undefined)
                        {
                           _loc6_.actionEnabled = Boolean(_loc4_[_loc11_].@actionEnabled == "true" ? true : false);
                        }
                        else
                        {
                           _loc6_.actionEnabled = true;
                        }
                        if(_loc4_[_loc11_].@hasBtn != undefined)
                        {
                           _loc6_.hasBtn = Boolean(_loc4_[_loc11_].@hasBtn == "true" ? true : false);
                        }
                        else
                        {
                           _loc6_.hasBtn = false;
                        }
                        if(_loc4_[_loc11_].@triggerNextStep != undefined)
                        {
                           _loc6_.triggerNextStep = Boolean(_loc4_[_loc11_].@triggerNextStep == "true" ? true : false);
                        }
                        else
                        {
                           _loc6_.triggerNextStep = true;
                        }
                        if(_loc4_[_loc11_].@autoRect != undefined)
                        {
                           _loc6_.autoRect = Boolean(_loc4_[_loc11_].@autoRect == "true" ? true : false);
                        }
                        break;
                     case "npcDialog":
                        _loc6_.type = 2;
                        (_loc7_ = new NPCDialogData()).dialogs = [{
                           "npcURL":DEFINE.COMM_ROOT + "/res/npc/" + String(_loc4_[_loc11_].@npcID) + "/preview.png",
                           "npcName":String(_loc4_[_loc11_].@npcName),
                           "text":String(_loc4_[_loc11_].@text)
                        }];
                        _loc7_.buttons = [{
                           "label":String(_loc4_[_loc11_].@label),
                           "handler":null,
                           "close":true
                        }];
                        _loc6_.npcdialogData = _loc7_;
                        break;
                     case "openWindow":
                        _loc6_.type = 3;
                        _loc6_.moduleName = String(_loc4_[_loc11_].@moduleName);
                        _loc6_.tabIndex = int(_loc4_[_loc11_].@tabIndex);
                        break;
                     case "app":
                        _loc6_.type = 4;
                        _loc6_.appUrl = String(_loc4_[_loc11_].@url);
                        if(_loc4_[_loc11_].@mute != undefined)
                        {
                           _loc6_.mute = String(_loc4_[_loc11_].@mute) == "true" ? true : false;
                        }
                        break;
                     case "customStep":
                        _loc6_.type = 5;
                        if(_loc4_[_loc11_].@doWhat != undefined)
                        {
                           _loc6_.doWhat = String(_loc4_[_loc11_].@doWhat);
                        }
                        else
                        {
                           _loc6_.doWhat = null;
                        }
                        break;
                     case "changeStepId":
                        _loc6_.type = 6;
                        if(_loc4_[_loc11_].@key != undefined)
                        {
                           _loc6_.remoteKey = int(_loc4_[_loc11_].@key);
                        }
                        else
                        {
                           _loc6_.remoteKey = 1;
                        }
                        _loc6_.changeStepId = int(_loc4_[_loc11_].@value);
                        break;
                     case "closeAllWindows":
                        _loc6_.type = 7;
                        break;
                     case "enterScene":
                        _loc6_.type = 8;
                        if((_loc8_ = String(_loc4_[_loc11_].@id).split(".")).length == 2)
                        {
                           _loc6_.sceneId = int(_loc8_[0]);
                           _loc6_.sceneVer = int(_loc8_[1]);
                        }
                        else if(_loc8_.length == 1)
                        {
                           _loc6_.sceneId = int(_loc8_[0]);
                        }
                        break;
                     case "music":
                        _loc6_.type = 9;
                        if(_loc4_[_loc11_].@mute != undefined)
                        {
                           _loc6_.mute = String(_loc4_[_loc11_].@mute) == "true" ? true : false;
                        }
                        break;
                     case "showIcon":
                        _loc6_.type = 10;
                        _loc6_.moduleName = String(_loc4_[_loc11_].@moduleName);
                        _loc6_.targetId = String(_loc4_[_loc11_].@targetId);
                        _loc6_.tooltip = String(_loc4_[_loc11_].@tooltip);
                        break;
                     case "combat":
                        _loc6_.type = 11;
                        _loc6_.combatId = int(_loc4_[_loc11_].@id);
                        _loc6_.combatName = String(_loc4_[_loc11_].@name);
                        break;
                  }
                  _loc3_.moduleVoArr[_loc3_.moduleVoArr.length] = _loc6_;
                  _loc11_++;
               }
               _loc2_.stepVoArr[_loc2_.stepVoArr.length] = _loc3_;
               _loc10_++;
            }
            switch(_loc2_.triggerMode)
            {
               case 1:
                  if(this.dic["changeSceneDic"] == undefined)
                  {
                     this.dic["changeSceneDic"] = new Dictionary();
                  }
                  if(this.dic["changeSceneDic"][_loc2_.sceneId] == undefined)
                  {
                     this.dic["changeSceneDic"][_loc2_.sceneId] = [];
                  }
                  this.dic["changeSceneDic"][_loc2_.sceneId][this.dic["changeSceneDic"][_loc2_.sceneId].length] = _loc2_;
                  break;
            }
            _loc9_++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(rest != null && rest.length == 0)
         {
            return this.dic;
         }
         if(rest != null && rest[0] is int)
         {
            return this.dic[rest[0]];
         }
         return null;
      }
      
      public function update(... rest) : Boolean
      {
         return false;
      }
      
      public function deleted(... rest) : Boolean
      {
         return false;
      }
      
      public function clear() : void
      {
      }
      
      public function getName() : String
      {
         return Constants.NEWBIE_GUIDE_DATA;
      }
   }
}
