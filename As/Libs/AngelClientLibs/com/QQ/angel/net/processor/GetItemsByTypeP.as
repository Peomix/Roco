package com.QQ.angel.net.processor
{
   import com.QQ.angel.api.data.IDataProxy;
   import com.QQ.angel.api.net.IDataProcessor;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.data.entity.ItemDataDes;
   import com.QQ.angel.data.entity.UserItem;
   import com.QQ.angel.net.ADFCmdsType;
   import com.QQ.angel.net.ProtocolHelper;
   import com.QQ.angel.net.protocol.P_ReturnCode;
   import flash.utils.IDataInput;
   
   public class GetItemsByTypeP implements IDataProcessor
   {
       
      
      public var itemDataProxy:IDataProxy;
      
      public function GetItemsByTypeP()
      {
         super();
      }
      
      public function decode(param1:ADF) : Object
      {
         var _loc7_:UserItem = null;
         var _loc8_:uint = 0;
         var _loc2_:IDataInput = param1.body as IDataInput;
         var _loc3_:P_ReturnCode = ProtocolHelper.ReadCode(_loc2_);
         if(_loc3_.isError())
         {
            return _loc3_;
         }
         var _loc4_:int = int(_loc2_.readUnsignedShort());
         var _loc5_:Array = [];
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc8_ = uint((_loc7_ = new UserItem()).id = _loc2_.readUnsignedInt());
            _loc7_.count = _loc2_.readUnsignedShort();
            if(this.itemDataProxy != null)
            {
               _loc7_.itemDes = this.itemDataProxy.select(_loc8_) as ItemDataDes;
            }
            _loc5_.push(_loc7_);
            _loc6_++;
         }
         return _loc5_;
      }
      
      public function encode(param1:Object, param2:int = -1) : ADF
      {
         var _loc3_:ADF = ProtocolHelper.CreateADF(param2);
         _loc3_.body = param1;
         return _loc3_;
      }
      
      public function getADFType() : int
      {
         return ADFCmdsType.T_GETITEMSBYTYPE;
      }
   }
}
