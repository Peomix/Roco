package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_DANGERFIRECRACKER_CMD1_ApplyEnd_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "danger_firecracker?cmd=1";
       
      
      public var retCode:P_ReturnCode;
      
      public var scenes:Array;
      
      public function CGI_DANGERFIRECRACKER_CMD1_ApplyEnd_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XMLList = null;
         var _loc3_:XML = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!scenes)
            {
               scenes = new Array(5);
            }
            scenes.length = 0;
            _loc2_ = param1.scenes.elements();
            for each(_loc3_ in _loc2_)
            {
               scenes.push(uint(_loc3_.text()));
            }
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
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
   }
}
