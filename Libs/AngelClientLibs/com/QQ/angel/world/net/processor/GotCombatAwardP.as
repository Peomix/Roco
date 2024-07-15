package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.IMulDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.data.entity.ItemDataDes;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import flash.utils.IDataInput;
   
   public class GotCombatAwardP implements IMulDataProcessor
   {
       
      
      protected var itemsProxy:IDataProxy;
      
      public function GotCombatAwardP(param1:IDataProxy)
      {
         super();
         this.itemsProxy = param1;
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc7_:Object = null;
         var _loc8_:uint = 0;
         var _loc9_:ItemDataDes = null;
         var _loc2_:IDataInput = param1.body as IDataInput;
         if(param1.head.cmdID == ADFCmdsType.T_SERVER_MSG)
         {
            return ProtocolHelper.ReadCode(_loc2_).message;
         }
         var _loc3_:Object = {
            "npcID":_loc2_.readUnsignedInt(),
            "emblemID":_loc2_.readUnsignedByte()
         };
         var _loc4_:int;
         if((_loc4_ = int(_loc2_.readUnsignedShort())) != 0)
         {
            _loc5_ = [];
            _loc6_ = 0;
            while(_loc6_ < _loc4_)
            {
               _loc7_ = {};
               _loc8_ = uint(_loc2_.readUnsignedInt());
               _loc7_.num = _loc2_.readUnsignedShort();
               _loc9_ = this.itemsProxy.select(_loc8_) as ItemDataDes;
               _loc7_.src = _loc9_.url;
               _loc7_.name = _loc7_.tooltip = _loc9_.name;
               _loc5_.push(_loc7_);
               _loc6_++;
            }
            _loc3_.items = _loc5_;
         }
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_COMBAT_AWARD;
      }
      
      public function getADFTypes() : Array
      {
         return [ADFCmdsType.T_COMBAT_AWARD,ADFCmdsType.T_SERVER_MSG];
      }
   }
}
