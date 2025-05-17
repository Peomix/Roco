package com.QQ.angel.data.protocol
{
   import com.QQ.angel.data.protocolBase.I_S2C_Socket;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.struct.ManorGroundInfo;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class SKT_0x120002_QueryManorGroundInfo_S2C extends ProtocolBase implements I_S2C_Socket
   {
      
      public static const PROTOCOL_ID:int = 1179650;
      
      public var scarecrowExp:uint;
      
      public var proficiencyAExpnext:uint;
      
      public var scarecrowNextExp:uint;
      
      public var proficiencyAExp:uint;
      
      public var proficiencyBExpPre:uint;
      
      public var scarecrowId:uint;
      
      public var qqUin:uint;
      
      public var manorExp:uint;
      
      public var goldMoneyNum:uint;
      
      public var scarecrowLevel:uint;
      
      public var scarecrowEverPlay:uint;
      
      public var retCode:P_ReturnCode;
      
      public var groundInfoArray:Array;
      
      public var proficiencItem:uint;
      
      public var billboardId:uint;
      
      public var beautifyId:uint;
      
      public var proficiencyCExpnext:uint;
      
      public var manorLevel:uint;
      
      public var proficiencyCExp:uint;
      
      public var proficiencyCExpPre:uint;
      
      public var guideType:uint;
      
      public var proficiencyAExpPre:uint;
      
      public var homeId:uint;
      
      public var scarecrowGiftGotten:uint;
      
      public var proficiencyBExpnext:uint;
      
      public var parasolId:uint;
      
      public var proficiencyA:uint;
      
      public var proficiencyB:uint;
      
      public var proficiencyC:uint;
      
      public var proficiencyBExp:uint;
      
      public var petStatus:uint;
      
      public var goldMassNum:uint;
      
      public function SKT_0x120002_QueryManorGroundInfo_S2C()
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
         qqUin = param1.readUnsignedInt();
         manorLevel = param1.readUnsignedShort();
         manorExp = param1.readUnsignedInt();
         goldMassNum = param1.readUnsignedShort();
         goldMoneyNum = param1.readUnsignedInt();
         guideType = param1.readUnsignedShort();
         petStatus = param1.readUnsignedByte();
         scarecrowExp = param1.readUnsignedInt();
         scarecrowLevel = param1.readUnsignedByte();
         scarecrowId = param1.readUnsignedInt();
         homeId = param1.readUnsignedInt();
         parasolId = param1.readUnsignedInt();
         beautifyId = param1.readUnsignedInt();
         billboardId = param1.readUnsignedInt();
         scarecrowEverPlay = param1.readUnsignedByte();
         scarecrowNextExp = param1.readUnsignedInt();
         scarecrowGiftGotten = param1.readUnsignedByte();
         proficiencyA = param1.readUnsignedByte();
         proficiencyAExp = param1.readUnsignedShort();
         proficiencyAExpPre = param1.readUnsignedShort();
         proficiencyAExpnext = param1.readUnsignedShort();
         proficiencyB = param1.readUnsignedByte();
         proficiencyBExp = param1.readUnsignedShort();
         proficiencyBExpPre = param1.readUnsignedShort();
         proficiencyBExpnext = param1.readUnsignedShort();
         proficiencyC = param1.readUnsignedByte();
         proficiencyCExp = param1.readUnsignedShort();
         proficiencyCExpPre = param1.readUnsignedShort();
         proficiencyCExpnext = param1.readUnsignedShort();
         proficiencItem = param1.readUnsignedInt();
         if(!groundInfoArray)
         {
            groundInfoArray = new Array(16);
         }
         groundInfoArray.length = 16;
         var _loc2_:int = 0;
         while(_loc2_ < 16)
         {
            groundInfoArray[_loc2_] = new ManorGroundInfo();
            groundInfoArray[_loc2_].readData(param1);
            _loc2_++;
         }
         return true;
      }
   }
}

