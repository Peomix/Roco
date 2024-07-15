package com.QQ.angel.data.entity
{
   public class DressUpItemDes
   {
       
      
      public var id:int;
      
      public var isVip:Boolean;
      
      public var isDefault:Boolean;
      
      public var defaultType:int;
      
      public var isNew:Boolean;
      
      public var charm:int;
      
      public var price:int;
      
      public var validDays:int;
      
      public var expireTime:int;
      
      public var unlockLevel:int;
      
      public var unlockPhrace:int;
      
      public var unlockFlower:int;
      
      public var name:String;
      
      public var sr_passTime:String;
      
      public function DressUpItemDes(param1:XML = null)
      {
         super();
         if(param1)
         {
            this.id = parseInt(param1..@id.toString());
            this.isVip = param1..@vip.toString() == "1";
            this.isDefault = param1.attribute("default").toString() != "0";
            this.defaultType = parseInt(param1.attribute("default").toString());
            this.isNew = param1.attribute("new").toString() == "1";
            this.charm = parseInt(param1..@charm.toString());
            this.price = parseInt(param1..@price.toString());
            this.validDays = parseInt(param1..@valid.toString());
            this.expireTime = parseInt(param1..@expire.toString());
            this.unlockLevel = parseInt(param1..@llevel.toString());
            this.unlockPhrace = parseInt(param1..@lphrace.toString());
            this.unlockFlower = parseInt(param1..@lflower.toString());
            this.name = param1.toString();
         }
      }
   }
}
