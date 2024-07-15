package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.combatsys.*;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SpiritDesProxy implements IDataProxy
   {
       
      
      protected var db:Dictionary;
      
      protected var listdb:Array;
      
      public function SpiritDesProxy(param1:Object)
      {
         super();
         var _loc2_:int = getTimer();
         this.db = new Dictionary();
         this.listdb = [];
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var xmllist:XMLList;
         var len:int;
         var i:int;
         var combatURL:String;
         var avatarURL:String;
         var psXML:XML = null;
         var pDes:PropertyDes = null;
         var id:uint = 0;
         var ssXML:XML = null;
         var ssDes:SpiritSkinDes = null;
         var sdesXML:XML = null;
         var sDes:SpiritDes = null;
         var mSpeed:int = 0;
         var index:int = 0;
         var features:Array = null;
         var j:int = 0;
         var groups:Array = null;
         var evolutionArgs:Array = null;
         var evolutionObj:Object = null;
         var xmlStr:Object = param1;
         var xml:XML = xmlStr is XML ? xmlStr as XML : new XML(xmlStr);
         DEFINE.SPIRIT_VER = xml.@version;
         PropertyDes.FEATURES = [];
         xmllist = xml.PropertyDes;
         len = xmllist.length();
         i = 0;
         while(i < len)
         {
            psXML = xmllist[i];
            pDes = new PropertyDes();
            id = uint(pDes.id = int(psXML.@id));
            pDes.name = String(psXML.@name);
            PropertyDes.FEATURES[id] = pDes;
            i++;
         }
         PropertyDes.GroupTypes = [];
         xmllist = xml.groupTypeDes;
         len = xmllist.length();
         i = 0;
         while(i < len)
         {
            psXML = xmllist[i];
            pDes = new PropertyDes();
            id = uint(pDes.id = int(psXML.@id));
            pDes.name = String(psXML.@name);
            PropertyDes.GroupTypes[id] = pDes;
            i++;
         }
         SpiritSkinDes.SpiritSkinTypes = new Dictionary();
         xmllist = xml.spiritSkinDes;
         len = xmllist.length();
         i = 0;
         while(i < len)
         {
            ssXML = xmllist[i];
            ssDes = new SpiritSkinDes();
            ssDes.id = int(ssXML.@id);
            ssDes.name = String(ssXML.@name);
            ssDes.description = String(ssXML.@description);
            ssDes.getForm = String(ssXML.@getForm);
            ssDes.quality = int(ssXML.@quality);
            SpiritSkinDes.SpiritSkinTypes[ssDes.id] = ssDes;
            i++;
         }
         combatURL = DEFINE.COMM_ROOT + "res/combat/";
         avatarURL = DEFINE.COMM_ROOT + "res/spirit/";
         xmllist = xml.SpiritDes.(@id != "");
         len = xmllist.length() - 1;
         i = len;
         while(i >= 0)
         {
            sdesXML = xmllist[i];
            sDes = new SpiritDes();
            id = uint(sDes.id = int(sdesXML.@id));
            sDes.name = String(sdesXML.@name);
            sDes.src = combatURL + "spirits/" + String(sdesXML.@src) + "?" + DEFINE.SPIRIT_VER;
            sDes.iconSrc = combatURL + "icons/" + String(sdesXML.@iconSrc) + "?" + DEFINE.SPIRIT_VER;
            sDes.previewSrc = combatURL + "previews/" + String(sdesXML.@previewSrc) + "?" + DEFINE.SPIRIT_VER;
            sDes.linkName = "Spirit";
            sDes.description = String(sdesXML.@description);
            sDes.features = [];
            sDes.skinnum = int(sdesXML.@skinnum);
            if(sdesXML.@avatar != undefined)
            {
               sDes.avatar = avatarURL + String(sdesXML.@avatar) + "?" + DEFINE.SPIRIT_VER;
            }
            else
            {
               sDes.avatar = this.getAvatarURL(id,avatarURL) + "?" + DEFINE.SPIRIT_VER;
            }
            if(sdesXML.@evolution != undefined)
            {
               evolutionArgs = String(sdesXML.@evolution).split("|");
               sDes.evolutionLevel = int(evolutionArgs[0]);
               sDes.evolutionID = int(evolutionArgs[1]);
               evolutionObj = this.db[sDes.evolutionID];
               sDes.evolution = evolutionArgs[0] + " 级进化成 " + (evolutionObj != null ? evolutionObj.name : "未知");
            }
            sDes.mType = String(sdesXML.@mType) == "2" ? 2 : 0;
            mSpeed = int(sdesXML.@mSpeed);
            sDes.mSpeed = mSpeed == 0 ? 2 : mSpeed;
            sDes.height = sdesXML.@height;
            sDes.weight = sdesXML.@weight;
            sDes.color = sdesXML.@color;
            sDes.interest = sdesXML.@interest;
            sDes.habitat = sdesXML.@habitat;
            sDes.catchrate = sdesXML.@catchrate;
            sDes.bossPhyle = sdesXML.@bossPhyle;
            sDes.bossReward = sdesXML.@bossReward;
            if(sdesXML.@sceneId != undefined)
            {
               sDes.sceneId = int(sdesXML.@sceneId);
            }
            if(sdesXML.@condition != undefined)
            {
               sDes.condition = sdesXML.@condition;
            }
            if(sdesXML.@requireLevel != undefined)
            {
               sDes.requireLevel = sdesXML.@requireLevel;
            }
            features = String(sdesXML.@features).split(",");
            j = 0;
            while(j < features.length)
            {
               index = int(features[j]);
               if(index != 0)
               {
                  sDes.features.push(PropertyDes.FEATURES[index]);
               }
               j++;
            }
            groups = String(sdesXML.@group).split(",");
            j = 0;
            while(j < groups.length)
            {
               index = int(groups[j]);
               if(index != 0)
               {
                  sDes.group.push(PropertyDes.GroupTypes[index]);
               }
               j++;
            }
            if(sdesXML.@wg != undefined)
            {
               sDes.wg = int(sdesXML.@wg);
            }
            if(sdesXML.@mg != undefined)
            {
               sDes.mg = int(sdesXML.@mg);
            }
            if(sdesXML.@mk != undefined)
            {
               sDes.mk = int(sdesXML.@mk);
            }
            if(sdesXML.@sd != undefined)
            {
               sDes.sd = int(sdesXML.@sd);
            }
            if(sdesXML.@fy != undefined)
            {
               sDes.fy = int(sdesXML.@fy);
            }
            if(sdesXML.@wg != undefined)
            {
               sDes.sm = int(sdesXML.@sm);
            }
            if(sdesXML.@reward != undefined)
            {
               sDes.reward = uint(sdesXML.@reward);
            }
            if(sdesXML.@EvolutionFormID != undefined)
            {
               sDes.EvolutionFormID = int(sdesXML.@EvolutionFormID);
            }
            if(sdesXML.@EvolutiontoIDs != undefined)
            {
               sDes.EvolutiontoIDs = String(sdesXML.@EvolutiontoIDs).split("|");
            }
            if(sdesXML.@getForm != undefined)
            {
               sDes.getForm = String(sdesXML.@getForm);
            }
            if(sdesXML.@state != undefined)
            {
               sDes.state = int(sdesXML.@state);
            }
            if(sdesXML.@startTime != undefined)
            {
               sDes.startTime = String(sdesXML.@startTime);
            }
            if(sdesXML.@endTime != undefined)
            {
               sDes.endTime = String(sdesXML.@endTime);
            }
            if(sdesXML.@firstID != undefined)
            {
               sDes.firstID = int(sdesXML.@firstID);
            }
            if(sdesXML.@propoLevel != undefined)
            {
               sDes.propoLevel = int(sdesXML.@propoLevel);
            }
            if(sdesXML.@isInBook != undefined)
            {
               sDes.isInBook = sdesXML.@isInBook == 0;
            }
            sDes.expType = int(sdesXML.@expType);
            this.listdb.push(sDes);
            this.db[id] = sDes;
            i--;
         }
      }
      
      protected function getAvatarURL(param1:uint, param2:String) : String
      {
         var _loc3_:* = param1 + "";
         if(_loc3_.length == 1)
         {
            _loc3_ = "00" + _loc3_;
         }
         else if(_loc3_.length == 2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return param2 + _loc3_ + "-.swf";
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         if(rest[0] == "*")
         {
            return this.listdb;
         }
         return this.db[int(rest[0])];
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
         return Constants.SPIRIT_DATA;
      }
   }
}
