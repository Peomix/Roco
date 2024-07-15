package com.QQ.angel.world.net.protocol
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.protocol.IAngelDataInput;
   import com.QQ.angel.api.net.protocol.IAngelDataOutput;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class P_SubBC_Paths implements IAngelDataOutput, IAngelDataInput
   {
       
      
      public var uin:uint;
      
      public var sceneID:uint;
      
      public var bcType:int = 0;
      
      public var paths:Array;
      
      public function P_SubBC_Paths()
      {
         super();
      }
      
      public function write(param1:IDataOutput) : void
      {
         param1.writeShort(this.sceneID);
         param1.writeByte(this.bcType);
         var _loc2_:int = int(this.paths.length);
         param1.writeShort(_loc2_);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            DEFINE.WritePoint(param1,this.paths[_loc3_] as Point);
            _loc3_++;
         }
      }
      
      public function read(param1:IDataInput) : void
      {
         this.uin = param1.readUnsignedInt();
         this.sceneID = param1.readUnsignedShort();
         this.bcType = param1.readByte();
         var _loc2_:uint = uint(param1.readUnsignedShort());
         this.paths = [];
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.paths.push(DEFINE.ReadPoint(param1));
            _loc3_++;
         }
      }
      
      public function get length() : uint
      {
         return 2 + 1 + 2 + this.paths.length * 4;
      }
   }
}
