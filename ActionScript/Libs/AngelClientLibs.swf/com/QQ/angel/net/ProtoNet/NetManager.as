package com.QQ.angel.net.ProtoNet
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.protocol.ADFHead;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.net.protocol.P_FreeRequest;
   import com.tencent.protobuf.Message;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class NetManager
   {
      
      public static var dataProcessorDic:Dictionary;
      
      public static var BeKickedOff:Boolean = false;
      
      public function NetManager()
      {
         super();
      }
      
      public static function send(param1:int, param2:Message = null, param3:Class = null, param4:Function = null) : void
      {
         var _loc5_:NetProcessor = new NetProcessor(param1,param2,param3);
         _loc5_.onsuccess = param4;
         _loc5_.onerror = onerror;
         var _loc6_:P_FreeRequest = new P_FreeRequest(param1,_loc5_,_loc5_);
         _loc6_.send(true);
      }
      
      private static function onerror(param1:String) : void
      {
      }
      
      public static function addDataProcessor(param1:int, param2:Class, param3:Function, param4:Boolean = true) : void
      {
         if(dataProcessorDic == null)
         {
            dataProcessorDic = new Dictionary();
            CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_RAW_DATA,NetManager.onGetDecodedData,null);
         }
         if(param4)
         {
            dataProcessorDic[param1] = [{
               "cl":param2,
               "callback":param3
            }];
         }
         else if(dataProcessorDic[param1] != null)
         {
            (dataProcessorDic[param1] as Array).push({
               "cl":param2,
               "callback":param3
            });
         }
         else
         {
            dataProcessorDic[param1] = [{
               "cl":param2,
               "callback":param3
            }];
         }
      }
      
      public static function removeDataProcessor(param1:int, param2:Function = null) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(dataProcessorDic == null)
         {
            dataProcessorDic = new Dictionary();
            CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_RAW_DATA,NetManager.onGetDecodedData,null);
         }
         if(dataProcessorDic[param1] != null)
         {
            if(param2 == null)
            {
               dataProcessorDic[param1] = null;
               delete dataProcessorDic[param1];
            }
            else
            {
               _loc3_ = dataProcessorDic[param1];
               _loc4_ = [];
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(_loc3_[_loc5_].callback != param2)
                  {
                     _loc4_.push(_loc3_[_loc5_]);
                  }
                  _loc5_++;
               }
               if(_loc4_.length > 0)
               {
                  dataProcessorDic[param1] = _loc4_;
               }
               else
               {
                  dataProcessorDic[param1] = null;
                  delete dataProcessorDic[param1];
               }
            }
         }
      }
      
      private static function onGetDecodedData(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc9_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:ByteArray = null;
         var _loc12_:Class = null;
         var _loc13_:Message = null;
         var _loc5_:Array = param2 as Array;
         var _loc6_:ByteArray = ByteArray(_loc5_[0]);
         var _loc7_:ADFHead = ADFHead(_loc5_[1]);
         var _loc8_:int = int(_loc7_.cmdID);
         if(dataProcessorDic[_loc8_] != undefined || dataProcessorDic[_loc8_] != null)
         {
            _loc9_ = dataProcessorDic[_loc8_];
            _loc10_ = 0;
            while(_loc10_ < _loc9_.length)
            {
               _loc11_ = new ByteArray();
               _loc11_.writeBytes(_loc6_);
               _loc11_.position = 0;
               _loc12_ = _loc9_[_loc10_].cl;
               _loc13_ = new _loc12_();
               _loc13_.readExternal(_loc11_);
               if(_loc13_)
               {
                  _loc9_[_loc10_].callback && _loc9_[_loc10_].callback(_loc8_,_loc13_);
               }
               else
               {
                  onerror && onerror("系统繁忙，请稍后再试。");
               }
               _loc10_++;
            }
         }
         return CallbackCenter.EVENT_OK;
      }
   }
}

