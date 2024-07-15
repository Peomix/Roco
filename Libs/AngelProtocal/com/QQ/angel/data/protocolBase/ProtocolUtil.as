package com.QQ.angel.data.protocolBase
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.ServerInfo;
   
   public class ProtocolUtil
   {
       
      
      public function ProtocolUtil()
      {
         super();
      }
      
      public static function getUnkownKey() : String
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc1_:ServerInfo = __global.SysAPI.getGDataAPI().getGlobalVal(Constants.CUR_SERVER_INFO) as ServerInfo;
         if(Boolean(_loc1_) && (Boolean(_loc1_.pskey) || Boolean(_loc1_.skey)))
         {
            _loc2_ = !!_loc1_.pskey ? _loc1_.pskey : _loc1_.skey;
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < _loc2_.length)
            {
               _loc3_ += "%" + _loc2_.charCodeAt(_loc4_).toString(16);
               _loc4_++;
            }
            return _loc3_;
         }
         return "";
      }
   }
}
