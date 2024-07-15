package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.api.utils.ByteBuffer;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.RoleInfoData;
   
   public class SOneInfoChangeP implements IDataProcessor
   {
       
      
      public function SOneInfoChangeP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc2_:ByteBuffer = param1.body as ByteBuffer;
         var _loc3_:RoleInfoData = new RoleInfoData();
         _loc3_.uin = _loc2_.readUnsignedInt();
         _loc3_.nickName = DEFINE.ReadChars(_loc2_,DEFINE.L_NICKNAME);
         _loc3_.level = _loc2_.readUnsignedShort();
         _loc3_.avatarVer = _loc2_.readUnsignedShort();
         _loc3_.trainerLevel = _loc2_.readUnsignedByte();
         _loc3_.achieveId = _loc2_.readUnsignedByte();
         _loc3_.titleLevel = _loc2_.readUnsignedByte();
         _loc3_.avatarTransformID = _loc2_.readUnsignedInt();
         _loc3_.avatarEffectID = _loc2_.readUnsignedInt();
         _loc3_.footprintID = _loc2_.readUnsignedInt();
         _loc3_.namebgId = _loc2_.readUnsignedInt();
         _loc3_.paopaoId = _loc2_.readUnsignedInt();
         if(_loc2_.bytesAvailable)
         {
            _loc3_.dazzleAvatar = _loc2_.readUnsignedByte() == 1;
            _loc3_.daMagic = _loc2_.readUnsignedInt();
            _loc3_.daRing = _loc2_.readUnsignedInt();
            _loc3_.daMount = _loc2_.readUnsignedInt();
            _loc3_.daEnvironment = _loc2_.readUnsignedInt();
            _loc3_.daBackground = _loc2_.readUnsignedInt();
            _loc3_.daFrame = _loc2_.readUnsignedInt();
            _loc3_.daDoll = _loc2_.readUnsignedInt();
            _loc3_.daStamp = _loc2_.readUnsignedInt();
            _loc3_.daFootprint = _loc2_.readUnsignedInt();
            _loc3_.daNamebg = _loc2_.readUnsignedInt();
            _loc3_.daPopup = _loc2_.readUnsignedInt();
         }
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SOneInfoChange;
      }
   }
}
