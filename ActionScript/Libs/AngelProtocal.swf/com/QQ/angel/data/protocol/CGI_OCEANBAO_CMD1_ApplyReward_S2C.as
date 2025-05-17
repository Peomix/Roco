package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_OCEANBAO_CMD1_ApplyReward_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "ocean_bao?cmd=1";
      
      public var remain:uint;
      
      public var retCode:P_ReturnCode;
      
      public var fish1:Array;
      
      public var fish2:Array;
      
      public var rewardInfo:Array;
      
      public var fish0:Array;
      
      public function CGI_OCEANBAO_CMD1_ApplyReward_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         var _loc9_:ItemInfoChanged32 = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            remain = uint(param1.remain.text());
            if(!fish0)
            {
               fish0 = new Array(0);
            }
            fish0.length = 0;
            _loc2_ = param1.fish0.elements();
            for each(_loc3_ in _loc2_)
            {
               fish0.push(uint(_loc3_.text()));
            }
            if(!fish1)
            {
               fish1 = new Array(0);
            }
            fish1.length = 0;
            _loc4_ = param1.fish1.elements();
            for each(_loc5_ in _loc4_)
            {
               fish1.push(uint(_loc5_.text()));
            }
            if(!fish2)
            {
               fish2 = new Array(0);
            }
            fish2.length = 0;
            _loc6_ = param1.fish2.elements();
            for each(_loc7_ in _loc6_)
            {
               fish2.push(uint(_loc7_.text()));
            }
            if(!rewardInfo)
            {
               rewardInfo = new Array(0);
            }
            rewardInfo.length = 0;
            for each(_loc8_ in param1.rewardInfo.ItemInfoChanged32)
            {
               _loc9_ = new ItemInfoChanged32();
               _loc9_.decodeCGI(_loc8_);
               rewardInfo.push(_loc9_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!rewardInfo)
         {
            rewardInfo = new Array();
         }
         return false;
      }
   }
}

