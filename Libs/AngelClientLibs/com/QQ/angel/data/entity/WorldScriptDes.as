package com.QQ.angel.data.entity
{
   import flash.utils.Dictionary;
   
   public class WorldScriptDes extends NPCCDConvert
   {
       
      
      public var scripts:Dictionary;
      
      public function WorldScriptDes()
      {
         super();
      }
      
      override public function tranNPCClickDes(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc5_:* = undefined;
         super.tranNPCClickDes(param1);
         this.scripts = new Dictionary();
         var _loc2_:XMLList = param1.children();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length())
         {
            if((_loc5_ = (_loc4_ = _loc2_[_loc3_]).@label) != undefined)
            {
               this.scripts[String(_loc5_)] = _loc4_;
            }
            else
            {
               this.scripts[_loc3_ + ""] = _loc4_;
            }
            _loc3_++;
         }
      }
   }
}
