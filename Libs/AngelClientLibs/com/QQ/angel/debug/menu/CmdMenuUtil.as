package com.QQ.angel.debug.menu
{
   import com.QQ.angel.debug.CmdBase;
   
   public class CmdMenuUtil
   {
       
      
      public function CmdMenuUtil()
      {
         super();
      }
      
      public static function getCmdByParams(param1:String, param2:Array) : String
      {
         var _loc3_:String = param1;
         if(param2)
         {
            _loc3_ += "/" + param2.join("/");
         }
         return _loc3_;
      }
      
      public static function getItemDataListByCmd(param1:String) : Array
      {
         var _loc4_:Array = null;
         var _loc7_:CmdItemData = null;
         var _loc2_:Array = param1.split("/");
         var _loc3_:String = _loc2_.shift();
         var _loc5_:CmdBase;
         if(_loc5_ = CmdBase.getCmdBase(_loc3_))
         {
            _loc4_ = _loc5_.lstCmdItemData;
         }
         var _loc6_:int = 0;
         while(Boolean(_loc4_) && _loc6_ < _loc2_.length)
         {
            if(_loc7_ = getCmdItemDataByParam(_loc4_,_loc2_[_loc6_]))
            {
               _loc4_ = _loc7_.children;
            }
            _loc6_++;
         }
         return _loc4_;
      }
      
      public static function getCmdItemDataByParam(param1:Array, param2:String) : CmdItemData
      {
         var _loc3_:CmdItemData = null;
         if(param1)
         {
            for each(_loc3_ in param1)
            {
               if(_loc3_.param == param2)
               {
                  return _loc3_;
               }
            }
         }
         return null;
      }
   }
}
