package com.QQ.angel.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class P_AnyData implements IExternalizable
   {
      
      public static const TEXT:int = 0;
      
      public static const BINARY:int = 1;
      
      public static const LT_CHAT_SMILEY:int = 1000;
       
      
      public var sceneID:int;
      
      public var uin:uint;
      
      public var logicType:int;
      
      public var type:int;
      
      public var data:*;
      
      public function P_AnyData()
      {
         super();
      }
      
      public function writeExternal(param1:IDataOutput) : void
      {
         var _loc2_:ByteArray = null;
         param1.writeShort(this.logicType);
         param1.writeByte(this.type);
         if(this.type == TEXT)
         {
            DEFINE.WriteString(param1,this.data as String);
         }
         else
         {
            _loc2_ = this.data as ByteArray;
            param1.writeShort(_loc2_.bytesAvailable);
            param1.writeBytes(_loc2_);
         }
      }
      
      public function readExternal(param1:IDataInput) : void
      {
         var _loc2_:int = 0;
         this.logicType = param1.readUnsignedShort();
         this.type = param1.readByte();
         if(this.type == TEXT)
         {
            this.data = DEFINE.ReadString(param1);
         }
         else
         {
            _loc2_ = int(param1.readUnsignedShort());
            this.data = new ByteArray();
            param1.readBytes(this.data,0,_loc2_);
         }
      }
   }
}
