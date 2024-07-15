package com.QQ.angel.data.struct
{
   import com.QQ.angel.data.protocolBase.*;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   
   public class ManorGroundInfo extends ProtocolBase implements I_C2S_CGI, I_S2C_CGI, I_C2S_Socket, I_S2C_Socket
   {
       
      
      public var totalTime:uint;
      
      public var groundId:uint;
      
      public var totalProduce:uint;
      
      public var leftProduce:uint;
      
      public var hasFruit:uint;
      
      public var groundStatus:uint;
      
      public var hasInsect:uint;
      
      public var season:uint;
      
      public var currentTime:uint;
      
      public var seed:uint;
      
      public var leftRowTimes:uint;
      
      public var hasGrass:uint;
      
      public var plantStatus:uint;
      
      public function ManorGroundInfo()
      {
         super();
      }
      
      override public function getProtocolId() : Object
      {
         return "STRUCT_" + "ManorGroundInfo";
      }
      
      public function encodeCGI() : String
      {
         return "" + "&groundId=" + groundId + "&groundStatus=" + groundStatus + "&seed=" + seed + "&plantStatus=" + plantStatus + "&currentTime=" + currentTime + "&totalTime=" + totalTime + "&totalProduce=" + totalProduce + "&leftProduce=" + leftProduce + "&hasGrass=" + hasGrass + "&hasInsect=" + hasInsect + "&hasFruit=" + hasFruit + "&season=" + season + "&leftRowTimes=" + leftRowTimes;
      }
      
      public function readData(param1:IDataInput) : Boolean
      {
         groundId = param1.readUnsignedByte();
         groundStatus = param1.readUnsignedByte();
         seed = param1.readUnsignedInt();
         plantStatus = param1.readUnsignedByte();
         currentTime = param1.readUnsignedInt();
         totalTime = param1.readUnsignedInt();
         totalProduce = param1.readUnsignedByte();
         leftProduce = param1.readUnsignedByte();
         hasGrass = param1.readUnsignedByte();
         hasInsect = param1.readUnsignedByte();
         hasFruit = param1.readUnsignedByte();
         season = param1.readUnsignedByte();
         leftRowTimes = param1.readUnsignedByte();
         return true;
      }
      
      public function writeData(param1:IDataOutput) : Boolean
      {
         param1.writeByte(groundId);
         param1.writeByte(groundStatus);
         param1.writeInt(seed);
         param1.writeByte(plantStatus);
         param1.writeInt(currentTime);
         param1.writeInt(totalTime);
         param1.writeByte(totalProduce);
         param1.writeByte(leftProduce);
         param1.writeByte(hasGrass);
         param1.writeByte(hasInsect);
         param1.writeByte(hasFruit);
         param1.writeByte(season);
         param1.writeByte(leftRowTimes);
         return true;
      }
      
      public function decodeCGI(param1:XML) : Boolean
      {
         if(int(param1.result.@value) == 0)
         {
            groundId = uint(param1.groundId.text());
            groundStatus = uint(param1.groundStatus.text());
            seed = uint(param1.seed.text());
            plantStatus = uint(param1.plantStatus.text());
            currentTime = uint(param1.currentTime.text());
            totalTime = uint(param1.totalTime.text());
            totalProduce = uint(param1.totalProduce.text());
            leftProduce = uint(param1.leftProduce.text());
            hasGrass = uint(param1.hasGrass.text());
            hasInsect = uint(param1.hasInsect.text());
            hasFruit = uint(param1.hasFruit.text());
            season = uint(param1.season.text());
            leftRowTimes = uint(param1.leftRowTimes.text());
            return true;
         }
         return false;
      }
   }
}
