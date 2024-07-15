package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_CGI;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   
   public class CGI_SCARECROWDREAM_CMD2_QueryStatus_S2C extends ProtocolBase implements I_S2C_CGI
   {
      
      public static const CGI_NAME:String = "scarecrow_dream?cmd=2";
       
      
      public var bFlashFinished:uint;
      
      public var ushFilmCount:uint;
      
      public var ubTodayTakePictureCount:uint;
      
      public var retCode:P_ReturnCode;
      
      public var ushPictureCount:uint;
      
      public function CGI_SCARECROWDREAM_CMD2_QueryStatus_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return CGI_NAME;
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
            bFlashFinished = uint(param1.bFlashFinished.text());
            ushFilmCount = uint(param1.ushFilmCount.text());
            ushPictureCount = uint(param1.ushPictureCount.text());
            ubTodayTakePictureCount = uint(param1.ubTodayTakePictureCount.text());
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
