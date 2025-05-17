package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x0E000C_QueryMagicGrowupInfo_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 917516;
      
      public var honorCount:uint;
      
      public var uiRet:uint;
      
      public var enerrgy:uint;
      
      public var progress:uint;
      
      public var honorTime:Array;
      
      public var ratingTitle:uint;
      
      public var spititLv:Array;
      
      public function SKT_0x0E000C_QueryMagicGrowupInfo_S2C()
      {
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         uiRet = param1.readUnsignedInt();
         ratingTitle = param1.readUnsignedInt();
         progress = param1.readUnsignedInt();
         enerrgy = param1.readUnsignedInt();
         spititLv = new Array();
         spititLv.length = 3;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
         {
            spititLv[_loc2_] = param1.readUnsignedInt();
            _loc2_++;
         }
         honorCount = param1.readUnsignedInt();
         honorTime = new Array();
         honorTime.length = honorCount;
         var _loc3_:int = 0;
         while(_loc3_ < honorCount)
         {
            honorTime[_loc3_] = param1.readUnsignedInt();
            _loc3_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}

