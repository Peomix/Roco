package com.QQ.angel.data.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.data.protocolBase.I_C2S_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import flash.utils.IDataOutput;
   
   public class SKT_0x030005_ApplyMainRoleMove_C2S extends ProtocolBase implements I_C2S_Socket
   {
      
      public static const PROTOCOL_ID:int = 196613;
       
      
      public var sceneId:uint;
      
      public var moveType:uint;
      
      public var pathLength:uint;
      
      public var pathArray:Array;
      
      public function SKT_0x030005_ApplyMainRoleMove_C2S()
      {
         pathArray = new Array(pathLength);
         super();
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeShort(sceneId);
         param1.writeByte(moveType);
         param1.writeShort(pathLength);
         var _loc2_:int = 0;
         while(_loc2_ < pathLength)
         {
            DEFINE.WritePoint(param1,pathArray[_loc2_]);
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
