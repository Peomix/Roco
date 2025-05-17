package com.QQ.angel.data.entity
{
   public class FurnitureDes
   {
      
      public var id:uint;
      
      public var name:String;
      
      public var info:String;
      
      public var buildMaterialArray:Array;
      
      public var recycleMaterialArray:Array;
      
      public var buildEnergy:uint;
      
      public var rechargeMoneyPerDay:uint;
      
      public var settleType:uint;
      
      public var funcType:uint;
      
      public var settleLayer:uint;
      
      public var comfortable:uint;
      
      public var expireTime:uint;
      
      public var buildLevel:uint;
      
      public var sendExp:uint;
      
      public var productArray:Array;
      
      public function FurnitureDes()
      {
         super();
      }
      
      public function read(param1:XML) : void
      {
         var _loc2_:XML = null;
         var _loc3_:XML = null;
         var _loc5_:XML = null;
         var _loc6_:Object = null;
         var _loc7_:Object = null;
         this.id = uint(param1.id.text());
         this.name = String(param1.name.text());
         this.info = String(param1.info.text());
         if(!this.buildMaterialArray)
         {
            this.buildMaterialArray = new Array(0);
         }
         this.buildMaterialArray.length = 0;
         for each(_loc2_ in param1.buildMaterialArray.buildMaterial)
         {
            _loc6_ = {};
            _loc6_.id = uint(_loc2_.materialId.text());
            _loc6_.count = uint(_loc2_.materialNum.text());
            this.buildMaterialArray.push(_loc6_);
         }
         if(!this.recycleMaterialArray)
         {
            this.recycleMaterialArray = new Array(0);
         }
         this.recycleMaterialArray.length = 0;
         for each(_loc3_ in param1.recycleMaterialArray.recycleMaterial)
         {
            _loc7_ = {};
            _loc7_.id = uint(_loc3_.materialId.text());
            _loc7_.count = uint(_loc3_.materialNum.text());
            this.recycleMaterialArray.push(_loc7_);
         }
         this.buildEnergy = uint(param1.buildEnergy.text());
         this.rechargeMoneyPerDay = uint(param1.rechargeMoneyPerDay.text());
         this.settleType = uint(param1.settleType.text());
         this.funcType = uint(param1.funcType.text());
         this.settleLayer = uint(param1.settleLayer.text());
         this.comfortable = uint(param1.comfortable.text());
         this.expireTime = uint(param1.expireTime.text());
         this.buildLevel = uint(param1.buildLevel.text());
         this.sendExp = uint(param1.sendExp.text());
         if(!this.productArray)
         {
            this.productArray = new Array(0);
         }
         this.productArray.length = 0;
         var _loc4_:XMLList = param1.productArray.elements();
         for each(_loc5_ in _loc4_)
         {
            this.productArray.push(uint(_loc5_.text()));
         }
      }
   }
}

