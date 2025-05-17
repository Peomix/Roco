package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.combatsys.*;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SpiritSkillDesProxy implements IDataProxy
   {
      
      protected var db:Dictionary;
      
      public function SpiritSkillDesProxy(param1:Object)
      {
         super();
         this.db = new Dictionary();
         var _loc2_:int = getTimer();
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var xmllist:XMLList;
         var combatURL:String;
         var id:uint = 0;
         var i:int = 0;
         var psXML:XML = null;
         var pDes:PropertyDes = null;
         var tlXML:XML = null;
         var tlDes:TalentDes = null;
         var sdesXML:XML = null;
         var sDes:SpiritSkillDes = null;
         var xmlStr:Object = param1;
         var xml:XML = xmlStr is XML ? xmlStr as XML : new XML(xmlStr);
         DEFINE.SPIRIT_SKILL_VER = xml.@version;
         PropertyDes.BUFFS = [];
         xmllist = xml.PropertyDes;
         i = 0;
         while(i < xmllist.length())
         {
            psXML = xmllist[i];
            pDes = new PropertyDes();
            id = uint(pDes.id = int(psXML.@id));
            pDes.name = String(psXML.@name);
            PropertyDes.BUFFS[id] = pDes;
            i++;
         }
         xmllist = xml.talentDes;
         i = 0;
         while(i < xmllist.length())
         {
            tlXML = xmllist[i];
            tlDes = new TalentDes();
            id = uint(tlDes.id = int(tlXML.@id));
            tlDes.name = String(tlXML.@name);
            tlDes.description = String(tlXML.@des);
            TalentDes.SET[id] = tlDes;
            i++;
         }
         combatURL = DEFINE.COMM_ROOT + "res/combat/";
         xmllist = xml.SpiritSkillDes.(@id != "");
         i = 0;
         while(i < xmllist.length())
         {
            sdesXML = xmllist[i];
            sDes = new SpiritSkillDes();
            id = uint(sDes.id = int(sdesXML.@id));
            sDes.name = String(sdesXML.@name);
            sDes.description = String(sdesXML.@description);
            sDes.description2 = String(sdesXML.@description2);
            sDes.power = sdesXML.@power;
            sDes.ppMax = int(sdesXML.@ppMax);
            sDes.src = combatURL + "effects/" + String(sdesXML.@src) + "?" + DEFINE.SPIRIT_SKILL_VER;
            sDes.property = PropertyDes.FEATURES[int(sdesXML.@property)];
            sDes.attackType = int(sdesXML.@attackType);
            sDes.linkName = "Effect";
            sDes.speed = int(sdesXML.@speed);
            sDes.damageType = int(sdesXML.@damageType);
            sDes.catchRate = int(sdesXML.@catchRate);
            if(sDes.damageType == 4)
            {
               sDes.superSkillBgSrc = combatURL + "skillBg/" + id + ".jpg" + "?" + DEFINE.SPIRIT_SKILL_VER;
            }
            if(sdesXML.@superFormID != undefined)
            {
               sDes.superFormId = int(sdesXML.@superFormID);
            }
            if(sdesXML.@superFormSrc != undefined)
            {
               sDes.superFormSrc = combatURL + "spirits/" + String(sdesXML.@superFormSrc) + "?" + DEFINE.SPIRIT_VER;
            }
            this.db[id] = sDes;
            i++;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         return this.db[rest[0]];
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
         return Constants.SSKILL_DATA;
      }
   }
}

