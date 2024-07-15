package com.QQ.angel.data.entity.combatsys
{
   public class PropertyDes
   {
      
      public static var FEATURES:Array;
      
      public static var BUFFS:Array;
      
      public static var GroupTypes:Array;
      
      public static var TEMPERS:Array = ["孤僻","固执","调皮","勇敢","大胆","淘气","无虑","悠闲","保守","稳重","马虎","冷静","沉着","温顺","慎重","狂妄","胆小","急躁","开朗","天真","坦率","害羞","认真","实干","浮躁"];
      
      public static var TEMPER_DES:Array = [["物攻","物防"],["物攻","魔攻"],["物攻","魔防"],["物攻","速度"],["物防","物攻"],["物防","魔攻"],["物防","魔防"],["物防","速度"],["魔攻","物攻"],["魔攻","物防"],["魔攻","魔防"],["魔攻","速度"],["魔防","物攻"],["魔防","物防"],["魔防","魔攻"],["魔防","速度"],["速度","物攻"],["速度","物防"],["速度","魔攻"],["速度","魔防"],["属性不变"],["属性不变"],["属性不变"],["属性不变"],["属性不变"]];
      
      public static var EQUIPMENT_PROPETY:Array;
      
      public static var EQUIPMENT_TYPE:Array = ["武器","防具","饰品"];
       
      
      public var id:uint;
      
      public var name:String;
      
      public function PropertyDes()
      {
         super();
      }
      
      public static function getTemperStr(param1:int) : String
      {
         if(param1 > 0 && param1 <= PropertyDes.TEMPERS.length)
         {
            return PropertyDes.TEMPERS[param1 - 1];
         }
         return "未知";
      }
      
      public static function getTemperDesHtmlStr(param1:int) : String
      {
         var _loc3_:Array = null;
         var _loc2_:* = "";
         if(param1 > 0 && param1 <= PropertyDes.TEMPERS.length)
         {
            _loc3_ = TEMPER_DES[param1 - 1];
            _loc2_ += "(";
            if(_loc3_.length == 1)
            {
               _loc2_ += _loc3_[0];
            }
            else
            {
               _loc2_ += _loc3_[0] + "↑" + " " + _loc3_[1] + "↓";
            }
            _loc2_ += ")";
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         return this.name;
      }
   }
}
