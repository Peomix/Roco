package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_EGGNEWYEAR_CMD0_QueryStatsu_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "egg_new_year?cmd=0";
      
      public var egg:uint;
      
      public var time:uint;
      
      public var eggs:Array;
      
      public var status:uint;
      
      public var retCode:P_ReturnCode;
      
      public function CGI_EGGNEWYEAR_CMD0_QueryStatsu_S2C()
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
         if(int(param1.result.@value) == 0)
         {
            retCode = new P_ReturnCode();
            retCode.code = int(param1.result.@value);
            if(param1.result.msg != undefined)
            {
               retCode.message = param1.result.msg.text();
            }
            status = uint(param1.status.text());
            egg = uint(param1.egg.text());
            time = uint(param1.time.text());
            if(!eggs)
            {
               eggs = new Array(4);
            }
            eggs.length = 0;
            _loc2_ = param1.eggs.elements();
            for each(_loc3_ in _loc2_)
            {
               eggs.push(uint(_loc3_.text()));
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
   }
}

