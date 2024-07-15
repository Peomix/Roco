package com.QQ.angel.data.entity
{
   import com.QQ.angel.utils.AString;
   import flash.geom.Point;
   
   public class NpcDes
   {
       
      
      public var type:int;
      
      public var typeCls:Class;
      
      public var id:String;
      
      public var npcID:int;
      
      public var name:String;
      
      public var hasBrand:Boolean = true;
      
      public var tooltip:String;
      
      public var tooltipType:int;
      
      public var tooltipPos:Point;
      
      public var direction:int;
      
      public var placeID:int;
      
      public var placeType:int;
      
      public var position:Point;
      
      public var aimPos:Point;
      
      public var leftGamePos:Point;
      
      public var npcViewDes:NpcViewDes;
      
      public var create:XML;
      
      public var click:XML;
      
      public var createDes:NpcCreateDes;
      
      public var clickDes:NPCCDConvert;
      
      public var tState:Object;
      
      public var world:int = 0;
      
      public function NpcDes(param1:XML = null)
      {
         super();
         this.analyse(param1);
      }
      
      public function analyse(param1:XML) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.type = int(param1.@type);
         this.id = param1.@id;
         this.name = param1.@name;
         this.hasBrand = param1.@hasBrand != "false";
         if(this.name == "")
         {
            this.hasBrand = false;
         }
         this.tooltip = param1.@tooltip;
         if(this.tooltip != "")
         {
            this.tooltipType = int(param1.@tooltipType);
            this.tooltipPos = AString.TranPoint(param1.@tooltipPos);
         }
         var _loc2_:Function = AString.TranPoint;
         this.direction = int(param1.@direction);
         this.placeID = int(param1.@placeID);
         this.placeType = int(param1.@placeType);
         this.leftGamePos = _loc2_(param1.@leftGamePos);
         this.position = _loc2_(param1.@position);
         this.aimPos = _loc2_(param1.@aimPos);
         this.world = int(param1.@world);
         this.npcID = int(param1.@npcID);
         this.create = param1.Create[0];
         this.click = param1.Click[0];
         if(this.create != null)
         {
            this.createDes = new NpcCreateDes(this.create,this.npcID,this.name);
         }
         this.clickDes = NpcFuncDes.ProcessClickXML(this.click,this.npcID,this.name);
         if(param1.View != undefined)
         {
            this.npcViewDes = new NpcViewDes(param1.View[0]);
         }
      }
   }
}
