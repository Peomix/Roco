package com.QQ.angel.data.impl
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.entity.combatsys.*;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SpiritEqDesProxy implements IDataProxy
   {
      
      protected var db:Dictionary;
      
      public function SpiritEqDesProxy(param1:Object)
      {
         super();
         var _loc2_:int = getTimer();
         this.db = new Dictionary();
         this.processXML(param1);
      }
      
      protected function processXML(param1:Object) : void
      {
         var xmllist:XMLList;
         var len:int;
         var i:int;
         var equipmentURL:String;
         var psXML:XML = null;
         var pDes:PropertyDes = null;
         var id:uint = 0;
         var sdesXML:XML = null;
         var sDes:SpiritEquipmentDes = null;
         var xmlStr:Object = param1;
         var xml:XML = xmlStr is XML ? xmlStr as XML : new XML(xmlStr);
         PropertyDes.EQUIPMENT_PROPETY = [];
         xmllist = xml.PropertyDes;
         len = int(xmllist.length());
         i = 0;
         while(i < len)
         {
            psXML = xmllist[i];
            pDes = new PropertyDes();
            id = uint(pDes.id = int(psXML.@id));
            pDes.name = String(psXML.@name);
            PropertyDes.EQUIPMENT_PROPETY[id] = pDes;
            i++;
         }
         equipmentURL = DEFINE.COMM_ROOT + "res/combat/equipments/";
         xmllist = xml.EquipmentDes.(@id != "");
         len = xmllist.length() - 1;
         i = len;
         while(i >= 0)
         {
            sdesXML = xmllist[i];
            sDes = new SpiritEquipmentDes();
            sDes.id = int(sdesXML.@id);
            sDes.type = int(sdesXML.@type);
            sDes.level = int(sdesXML.@level);
            sDes.cdtLevel = int(sdesXML.@cdtLevel);
            sDes.name = String(sdesXML.@name);
            sDes.getFrom = String(sdesXML.@getFrom);
            sDes.src = equipmentURL + String(sdesXML.@type) + "_" + String(sdesXML.@id) + ".png";
            sDes.price.push(int(sdesXML.@price1));
            sDes.price.push(int(sdesXML.@price2));
            sDes.price.push(int(sdesXML.@price3));
            sDes.price.push(int(sdesXML.@price4));
            this.db[sDes.type + "_" + sDes.id] = sDes;
            i--;
         }
      }
      
      public function insert(... rest) : Boolean
      {
         return false;
      }
      
      public function select(... rest) : Object
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         if(rest.length == 1)
         {
            _loc2_ = uint(rest[0]);
            _loc3_ = SpiritEquipmentInfo.getIdByServerId(_loc2_);
            _loc4_ = SpiritEquipmentInfo.getTypeByServerId(_loc2_);
            return this.db[_loc4_.toString() + "_" + _loc3_.toString()];
         }
         if(rest.length == 2)
         {
            return this.db[rest[0] + "_" + rest[1]];
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
         return Constants.SEQUIP_DES_DATA;
      }
   }
}

