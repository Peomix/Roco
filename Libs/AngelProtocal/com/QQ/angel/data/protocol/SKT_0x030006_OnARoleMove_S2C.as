package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataInput;
   
   public class SKT_0x030006_OnARoleMove_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 196614;
       
      
      public var qqUin:uint;
      
      public var pathArray:Array;
      
      public var sceneId:uint;
      
      public var moveType:uint;
      
      public var pathArrayLength:uint;
      
      public function SKT_0x030006_OnARoleMove_S2C()
      {
         pathArray = new Array(pathArrayLength);
         super();
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         qqUin = param1.readUnsignedInt();
         sceneId = param1.readUnsignedShort();
         moveType = param1.readUnsignedByte();
         pathArrayLength = param1.readUnsignedShort();
         var _loc2_:int = 0;
         while(_loc2_ < pathArrayLength)
         {
            pathArray[_loc2_] = DEFINE.ReadPoint(param1);
            _loc2_++;
         }
         return true;
      }
      
      override public function getProtocolId() : Object
      {
         return PROTOCOL_ID;
      }
   }
}
