package com.QQ.angel.plug
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.utils.Dictionary;
   
   public class PluginSettingManager
   {
       
      
      protected var pluginSettings:Dictionary;
      
      protected var stepSettings:Array;
      
      public function PluginSettingManager(param1:String = "")
      {
         super();
         if(param1 != "")
         {
            this.paseSetting(param1);
         }
      }
      
      public function paseSetting(param1:String) : void
      {
         var _loc5_:int = 0;
         var _loc6_:XML = null;
         var _loc7_:PluginSetting = null;
         var _loc8_:XML = null;
         var _loc9_:String = null;
         var _loc10_:Array = null;
         var _loc11_:XMLList = null;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         this.pluginSettings = new Dictionary();
         this.stepSettings = new Array();
         var _loc2_:XML = new XML(param1);
         var _loc3_:String = "";
         if(_loc2_.@src != undefined)
         {
            _loc3_ = _loc2_.@src;
         }
         DEFINE.PLUGIN_ROOT = DEFINE.addHttps(_loc3_);
         var _loc4_:XMLList = _loc2_.Plugin;
         if(int(_loc2_.@version) == 2)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc6_ = _loc4_[_loc5_];
               _loc7_ = new PluginSetting();
               _loc9_ = _loc6_.@name;
               _loc7_.plugName = "com.QQ.angel.plugs." + _loc9_ + "::" + _loc9_ + "Plugin";
               _loc7_.plugLabel = _loc6_.@label;
               _loc7_.plugSrc = _loc3_ + _loc9_ + "/" + _loc9_ + "PluginLib.swf";
               _loc7_.cmdType = "on" + _loc9_;
               _loc7_.name = _loc9_;
               _loc7_.domain = _loc6_.@domain == undefined ? null : _loc6_.@domain;
               _loc7_.version = _loc6_.@version == undefined ? null : _loc6_.@version;
               this.pluginSettings[_loc9_] = _loc7_;
               this.pluginSettings[_loc7_.cmdType] = _loc7_;
               this.pluginSettings[_loc7_.plugName] = _loc7_;
               _loc5_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < _loc4_.length())
            {
               _loc6_ = _loc4_[_loc5_];
               (_loc7_ = new PluginSetting()).plugName = _loc6_.@name;
               _loc7_.plugLabel = _loc6_.@label;
               _loc7_.plugSrc = _loc3_ + _loc6_.@src;
               _loc7_.cmdType = _loc6_.@cmdType;
               if((_loc8_ = _loc6_.Params[0]) != null)
               {
                  _loc7_.params = _loc8_.toString();
               }
               if(_loc6_.@loadType != undefined)
               {
                  _loc7_.loadType = int(_loc6_.@loadType);
               }
               _loc7_.step = -1;
               if(_loc6_.@step != undefined)
               {
                  _loc7_.step = int(_loc6_.@step);
                  if((_loc10_ = this.stepSettings[_loc7_.step]) == null)
                  {
                     this.stepSettings[_loc7_.step] = _loc10_ = [];
                  }
                  _loc10_.push(_loc7_);
               }
               if(_loc6_.Require != undefined)
               {
                  if((_loc12_ = (_loc11_ = _loc6_.Require[0].Import).length()) > 0)
                  {
                     _loc7_.require = [];
                     _loc13_ = 0;
                     while(_loc13_ < _loc12_)
                     {
                        _loc7_.require.push(String(_loc11_[_loc13_].@name));
                        _loc13_++;
                     }
                  }
               }
               if(_loc7_.cmdType != "")
               {
                  this.pluginSettings[_loc7_.cmdType] = _loc7_;
               }
               _loc7_.domain = String(_loc6_.@singleDomain) == "true" ? "single" : null;
               this.pluginSettings[_loc7_.plugName] = _loc7_;
               _loc5_++;
            }
         }
      }
      
      public function getSettingByCMDT(param1:String) : PluginSetting
      {
         return this.pluginSettings[param1] as PluginSetting;
      }
      
      public function getSettingByName(param1:String) : PluginSetting
      {
         return this.pluginSettings[param1];
      }
      
      public function getSettingByStep(param1:int) : Array
      {
         return this.stepSettings[param1];
      }
   }
}
