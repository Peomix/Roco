package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.QQDetailInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x100002_QueryQQDetailInfo_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1048578;
       
      
      public var qqDetailInfoArrayLength:uint;
      
      public var qqDetailInfoArray:Array;
      
      public var retCode:P_ReturnCode;
      
      public function SKT_0x100002_QueryQQDetailInfo_S2C()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         retCode = ProtocolHelper.ReadCode(param1);
         if(retCode.code < 0)
         {
            return false;
         }
         qqDetailInfoArrayLength = param1.readUnsignedShort();
         if(!qqDetailInfoArray)
         {
            qqDetailInfoArray = new Array(qqDetailInfoArrayLength);
         }
         qqDetailInfoArray.length = qqDetailInfoArrayLength;
         var _loc2_:int = 0;
         while(_loc2_ < qqDetailInfoArrayLength)
         {
            qqDetailInfoArray[_loc2_] = new QQDetailInfo();
            qqDetailInfoArray[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
   }
}
