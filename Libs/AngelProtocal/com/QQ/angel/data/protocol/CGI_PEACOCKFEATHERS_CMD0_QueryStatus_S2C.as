package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   
   public class CGI_PEACOCKFEATHERS_CMD0_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "peacock_feathers?cmd=0";
       
      
      public var feather:ByteArray;
      
      public var scene:Array;
      
      public var retCode:P_ReturnCode;
      
      public var reward:uint;
      
      public function CGI_PEACOCKFEATHERS_CMD0_QueryStatus_S2C()
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
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!feather)
            {
               feather = new ByteArray();
            }
            feather.length = 0;
            _loc2_ = param1.feather.elements();
            for each(_loc3_ in _loc2_)
            {
               feather.writeByte(uint(_loc3_.text()));
            }
            if(!scene)
            {
               scene = new Array(0);
            }
            scene.length = 0;
            _loc4_ = param1.scene.elements();
            for each(_loc5_ in _loc4_)
            {
               scene.push(uint(_loc5_.text()));
            }
            reward = uint(param1.reward.text());
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         return false;
      }
   }
}
