package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.RoleStateData;
   
   public class RoleSDataChangeP implements IDataProcessor
   {
       
      
      public function RoleSDataChangeP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:RoleStateData = new RoleStateData();
         _loc3_.uin = _loc2_.readUnsignedInt();
         _loc3_.stateType = _loc2_.readUnsignedByte();
         _loc3_.isFlying = _loc2_.readUnsignedByte();
         _loc3_.flyItem = _loc2_.readUnsignedInt();
         _loc3_.isSwiming = _loc2_.readUnsignedByte();
         _loc3_.swimItem = _loc2_.readUnsignedInt();
         _loc3_.cursedType = _loc2_.readUnsignedShort();
         _loc3_.flashType = _loc2_.readUnsignedShort();
         _loc3_.summonType = _loc2_.readUnsignedShort();
         _loc3_.rideType = _loc2_.readUnsignedShort();
         _loc3_.spiritID = _loc2_.readUnsignedInt();
         _loc3_.isVip = _loc2_.readBoolean();
         _loc3_.vipLevel = _loc2_.readUnsignedByte();
         _loc3_.vipLulu = _loc2_.readUnsignedByte();
         _loc3_.vipExpiringDays = _loc2_.readUnsignedInt();
         _loc3_.isMagicOffset = _loc2_.readUnsignedByte();
         _loc3_.pkState = _loc2_.readUnsignedByte();
         _loc3_.guardianPetID = _loc2_.readUnsignedInt();
         _loc3_.guardianPetLv = _loc2_.readUnsignedInt();
         _loc3_.fishingState = _loc2_.readUnsignedByte();
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_StateDataChange;
      }
   }
}
