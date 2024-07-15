package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.Constants;
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.entity.RoleDetailData;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import com.QQ.angel.net.protocol.P_UInt;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class RoleDetailProcessor extends EventDispatcher implements IDataProcessor
   {
       
      
      public function RoleDetailProcessor(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:P_ReturnCode = ProtocolHelper.ReadCode(_loc2_);
         if(_loc3_.isError())
         {
            return {
               "serNum":param1.head.uiSerialNum,
               "msg":_loc3_.message
            };
         }
         var _loc4_:RoleDetailData;
         (_loc4_ = new RoleDetailData()).id = _loc2_.readUnsignedInt();
         _loc4_.serNum = param1.head.uiSerialNum;
         _loc4_.nickname = DEFINE.ReadChars(_loc2_,DEFINE.L_NICKNAME);
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         _loc4_.birthDate = new Date(_loc5_ * 1000);
         _loc4_.level = _loc2_.readUnsignedShort();
         _loc4_.exp = _loc2_.readUnsignedInt();
         _loc4_.maxExp = _loc2_.readUnsignedInt();
         _loc4_.honor = _loc2_.readUnsignedInt();
         _loc4_.atkp = _loc2_.readUnsignedInt();
         _loc4_.intp = _loc2_.readUnsignedInt();
         _loc4_.chmp = _loc2_.readUnsignedInt();
         _loc4_.coin = _loc2_.readUnsignedInt();
         _loc4_.avatarVersion = _loc2_.readUnsignedShort();
         _loc4_.avatar = [];
         var _loc6_:int = 0;
         while(_loc6_ < RoleDetailData.AVATAR_NUM)
         {
            _loc4_.avatar.push(_loc2_.readUnsignedInt());
            _loc6_++;
         }
         var _loc7_:int = int(_loc2_.readUnsignedByte());
         _loc4_.emblemsObtained = [];
         _loc6_ = 0;
         while(_loc6_ < RoleDetailData.EMBLEMS_NUM)
         {
            _loc4_.emblemsObtained.push((_loc7_ >> _loc6_ & 1) == 1);
            _loc6_++;
         }
         _loc4_.isVip = _loc2_.readBoolean();
         _loc4_.vipLevel = _loc2_.readUnsignedByte();
         _loc4_.magicValue = _loc2_.readUnsignedInt();
         _loc4_.vipExpireDate = new Date(_loc2_.readUnsignedInt() * 1000);
         _loc4_.vipExpiringDays = _loc2_.readUnsignedInt();
         _loc4_.pvpJWin = _loc2_.readUnsignedInt();
         _loc4_.pvpJLost = _loc2_.readUnsignedInt();
         _loc4_.pvpJEscape = _loc2_.readUnsignedInt();
         _loc4_.pvpZWin = _loc2_.readUnsignedInt();
         _loc4_.pvpZLost = _loc2_.readUnsignedInt();
         _loc4_.pvpZEscape = _loc2_.readUnsignedInt();
         _loc4_.pvpZConfig = _loc2_.readUnsignedByte();
         _loc4_.bossInfoBraveMode = _loc2_.readUnsignedByte();
         _loc4_.skyTowerMaxFloorNum = _loc2_.readByte();
         _loc4_.trainerLevel = _loc2_.readUnsignedByte();
         _loc4_.trainerExp = _loc2_.readUnsignedInt();
         _loc4_.achieveId = _loc2_.readUnsignedByte();
         _loc4_.titleLevel = _loc2_.readUnsignedByte();
         _loc4_.avatarTransformID = _loc2_.readUnsignedInt();
         _loc4_.avatarEffectID = _loc2_.readUnsignedInt();
         _loc4_.diamondNum = _loc2_.readUnsignedInt();
         _loc4_.guardianPetID = _loc2_.readUnsignedInt();
         _loc4_.guardianPetLevel = _loc2_.readUnsignedInt();
         _loc4_.honourPoint = _loc2_.readUnsignedInt();
         _loc4_.fakeMedal1 = _loc2_.readUnsignedInt();
         _loc4_.fakeMedal2 = _loc2_.readUnsignedInt();
         _loc4_.qualifyEmblem = _loc2_.readUnsignedByte();
         _loc4_.newAdventureLastPoint = _loc2_.readUnsignedByte();
         _loc4_.selectedMedal = _loc2_.readUnsignedByte();
         _loc4_.footprintID = _loc2_.readUnsignedInt();
         _loc4_.ladderMatchLevel = _loc2_.readUnsignedByte();
         if(_loc2_.bytesAvailable)
         {
            _loc4_.namebgId = _loc2_.readUnsignedInt();
            _loc4_.paopaoId = _loc2_.readUnsignedInt();
         }
         if(_loc2_.bytesAvailable)
         {
            _loc4_.dazzleAvatar = _loc2_.readUnsignedByte() == 1;
            _loc4_.daAvatar = [];
            _loc6_ = 0;
            while(_loc6_ < RoleDetailData.DAZZLE_NUM)
            {
               _loc4_.daAvatar.push(_loc2_.readUnsignedInt());
               _loc6_++;
            }
         }
         _loc6_ = 30;
         while(_loc6_ <= 31)
         {
            _loc4_.emblemsObtained.push((_loc4_.fakeMedal1 >> _loc6_ & 1) == 1);
            _loc6_++;
         }
         var _loc8_:Object;
         if(_loc8_ = __global.SysAPI.getGDataAPI().getDataProxy(Constants.ACHIEVE_LIST_DATA).select(_loc4_.achieveId,_loc4_.titleLevel))
         {
            _loc4_.title = _loc8_.label;
         }
         else
         {
            _loc4_.title = "";
         }
         return _loc4_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         var _loc4_:P_UInt;
         (_loc4_ = new P_UInt()).num = param1 as uint;
         _loc3_.body = _loc4_;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_GET_USER_DETAIL;
      }
   }
}
