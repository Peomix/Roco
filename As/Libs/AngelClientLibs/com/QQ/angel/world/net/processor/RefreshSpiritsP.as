package com.QQ.angel.world.net.processor
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.data.entity.combatsys.SpiritDes;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.world.vo.RefreshSpiritList;
   import com.QQ.angel.world.vo.RefreshSpiritVo;
   import flash.utils.IDataInput;
   
   public class RefreshSpiritsP implements IDataProcessor
   {
       
      
      protected var spiritDesProxy:IDataProxy;
      
      public function RefreshSpiritsP(param1:IDataProxy)
      {
         super();
         this.spiritDesProxy = param1;
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc7_:RefreshSpiritVo = null;
         var _loc2_:IDataInput = param1.body as IDataInput;
         var _loc3_:RefreshSpiritList = new RefreshSpiritList();
         _loc3_.sceneID = _loc2_.readUnsignedShort();
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         var _loc5_:Array = _loc3_.arr = [];
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            (_loc7_ = new RefreshSpiritVo()).id = _loc2_.readUnsignedInt();
            _loc7_.num = _loc2_.readUnsignedByte();
            _loc7_.areaIndex = _loc2_.readUnsignedByte();
            _loc7_.isRare = _loc2_.readUnsignedByte();
            if(_loc7_.id > 100000)
            {
               _loc7_.isNPCBoss = true;
            }
            else
            {
               if(_loc7_.id > 10000)
               {
                  _loc7_.id -= 10000;
                  _loc7_.isBoss = true;
               }
               _loc7_.spiritDes = this.spiritDesProxy.select(_loc7_.id) as SpiritDes;
            }
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         return _loc3_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         return null;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_SPIRIT_REFLASH;
      }
   }
}
