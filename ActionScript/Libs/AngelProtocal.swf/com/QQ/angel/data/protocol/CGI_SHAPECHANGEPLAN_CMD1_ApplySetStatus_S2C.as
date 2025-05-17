package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ItemInfoChanged32;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_SHAPECHANGEPLAN_CMD1_ApplySetStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "shape_change_plan?cmd=1";
      
      public var rewardItem:ItemInfoChanged32;
      
      public var status:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_SHAPECHANGEPLAN_CMD1_ApplySetStatus_S2C()
      {
         super();
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            status = uint(param1.status.text());
            rewardItem = new ItemInfoChanged32();
            rewardItem.decodeCGI(XML(param1.rewardItem));
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

