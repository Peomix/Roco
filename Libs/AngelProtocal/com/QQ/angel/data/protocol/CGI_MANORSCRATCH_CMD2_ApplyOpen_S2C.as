package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.ByteArray;
   
   public class CGI_MANORSCRATCH_CMD2_ApplyOpen_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "manor_scratch?cmd=2";
       
      
      public var scratch:ByteArray;
      
      public var rewardArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public var item:uint;
      
      public function CGI_MANORSCRATCH_CMD2_ApplyOpen_S2C()
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
         var _loc4_:XML = null;
         var _loc5_:ItemInfoChanged32 = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            if(!scratch)
            {
               scratch = new ByteArray();
            }
            scratch.length = 0;
            _loc2_ = param1.scratch.elements();
            for each(_loc3_ in _loc2_)
            {
               scratch.writeByte(uint(_loc3_.text()));
            }
            item = uint(param1.item.text());
            if(!rewardArray)
            {
               rewardArray = new Array(0);
            }
            rewardArray.length = 0;
            for each(_loc4_ in param1.rewardArray.ItemInfoChanged32)
            {
               (_loc5_ = new ItemInfoChanged32()).decodeCGI(_loc4_);
               rewardArray.push(_loc5_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!rewardArray)
         {
            rewardArray = new Array();
         }
         return false;
      }
   }
}
