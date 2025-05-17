package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.*;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_PIGDREAM_CMD1_ApplyFeed_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "pigdream?cmd=1";
      
      public var earth:int;
      
      public var hungry:int;
      
      public var retCode:P_ReturnCode;
      
      public var activity:int;
      
      public var awardItem:Array;
      
      public var dirty:int;
      
      public function CGI_PIGDREAM_CMD1_ApplyFeed_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         var _loc2_:XML = null;
         var _loc3_:ItemInfoChanged = null;
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            activity = int(param1.activity.text());
            dirty = int(param1.dirty.text());
            earth = int(param1.earth.text());
            hungry = int(param1.hungry.text());
            if(!awardItem)
            {
               awardItem = new Array(0);
            }
            awardItem.length = 0;
            for each(_loc2_ in param1.awardItem.ItemInfoChanged)
            {
               _loc3_ = new ItemInfoChanged();
               _loc3_.decodeCGI(_loc2_);
               awardItem.push(_loc3_);
            }
            return true;
         }
         retCode = new P_ReturnCode();
         retCode.code = int(param1.result.@value);
         if(param1.result.msg != undefined)
         {
            retCode.message = param1.result.msg.text();
         }
         if(!awardItem)
         {
            awardItem = new Array();
         }
         return false;
      }
   }
}

