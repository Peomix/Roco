package com.QQ.angel.net.center
{
   import CallbackUtil.CallbackCenter;
   import com.QQ.angel.api.net.protocol.ADFHead;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.protocolBase.*;
   import com.QQ.angel.net.protocol.P_FreeRequest2;
   import com.tencent.protobuf.Message;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class NetProtocalCenter
   {
      
      private static var s_s2cDict:Dictionary;
      
      private static var s_c2sDict:Dictionary;
       
      
      public function NetProtocalCenter()
      {
         super();
      }
      
      public static function initClassArray(param1:Array) : void
      {
         var _loc2_:Class = null;
         var _loc3_:ProtocolBase = null;
         s_s2cDict = new Dictionary();
         s_c2sDict = new Dictionary();
         for each(_loc2_ in param1)
         {
            _loc3_ = new _loc2_() as ProtocolBase;
            if(_loc3_)
            {
               if(_loc3_ is I_C2S_Socket || _loc3_ is I_C2S_CGI || _loc3_ is I_C2S_ProtoBuf)
               {
                  s_c2sDict[_loc3_.getProtocolId()] = _loc2_;
                  if(_loc3_ is I_C2S_ProtoBuf)
                  {
                     FreePBRequestProxy.addCmd(_loc3_.getProtocolId() as int);
                  }
               }
               else if(_loc3_ is I_S2C_Socket || _loc3_ is I_S2C_CGI || _loc3_ is I_S2C_ProtoBuf)
               {
                  s_s2cDict[_loc3_.getProtocolId()] = _loc2_;
                  if(_loc3_ is I_S2C_ProtoBuf)
                  {
                     FreePBRequestProxy.addCmd(_loc3_.getProtocolId() as int);
                  }
               }
               _loc3_ = null;
            }
         }
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_GET_A_CGI_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOBUF_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_CGI_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL,NetProtocalCenter.onApplySendDataTrans);
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL_BY_ID,NetProtocalCenter.onApplySendDataTransById);
      }
      
      public static function dispose() : void
      {
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_GET_A_CGI_RAW_DATA,NetProtocalCenter.onGetRawData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOBUF_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_CGI_PROTOCAL,NetProtocalCenter.onApplySendData);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL,NetProtocalCenter.onApplySendDataTrans);
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL_BY_ID,NetProtocalCenter.onApplySendDataTransById);
         s_s2cDict = null;
         s_c2sDict = null;
      }
      
      private static function onApplySendDataTransById(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc6_:Class = null;
         var _loc7_:Object = null;
         var _loc8_:Object = null;
         var _loc9_:String = null;
         var _loc5_:Array;
         if((Boolean(_loc5_ = param2 as Array)) && Boolean(_loc5_[0]))
         {
            _loc7_ = new (_loc6_ = getC2SProtocalClassByHash(_loc5_[0]))();
            if(_loc5_.length >= 3)
            {
               if(_loc8_ = _loc5_[2])
               {
                  for(_loc9_ in _loc8_)
                  {
                     _loc7_[_loc9_] = _loc8_[_loc9_];
                  }
               }
            }
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOCAL,[_loc7_,_loc5_[1] as Function]);
         }
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onApplySendDataTrans(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc5_:Array;
         if((Boolean(_loc5_ = param2 as Array)) && Boolean(_loc5_[0]))
         {
            if(_loc5_[0] is I_C2S_Socket)
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,param2);
            }
            else if(_loc5_[0] is I_C2S_ProtoBuf)
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_PROTOBUF_PROTOCAL,param2);
            }
            else if(_loc5_[0] is I_C2S_CGI)
            {
               CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_CGI_PROTOCAL,param2);
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      private static function onApplySendData(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc6_:P_FreeRequest2 = null;
         var _loc7_:FreeRequestProxy = null;
         var _loc8_:FreePBRequestProxy = null;
         var _loc9_:FreeCGIRequestProxy = null;
         var _loc5_:Array;
         if((Boolean(_loc5_ = param2 as Array)) && Boolean(_loc5_[0]))
         {
            if(_loc5_[0] is I_C2S_Socket)
            {
               _loc7_ = new FreeRequestProxy(I_C2S_Socket(param2[0]),param2[0].getProtocolId(),param2[1] as Function);
               (_loc6_ = new P_FreeRequest2(_loc7_.protocolHash,_loc7_,_loc7_,FreeRequestProxy.onReqReply)).send(true);
               _loc6_ = null;
               _loc7_ = null;
            }
            else if(_loc5_[0] is I_C2S_ProtoBuf)
            {
               _loc8_ = new FreePBRequestProxy(I_C2S_ProtoBuf(param2[0]),param2[0].getProtocolId(),param2[1] as Function);
               (_loc6_ = new P_FreeRequest2(_loc8_.protocolHash,_loc8_,_loc8_,FreePBRequestProxy.onReqReply)).send(true);
               _loc6_ = null;
               _loc8_ = null;
            }
            else if(_loc5_[0] is I_C2S_CGI)
            {
               (_loc9_ = new FreeCGIRequestProxy(I_C2S_CGI(param2[0]),param2[0].getProtocolId(),param2[1] as Function)).send();
               _loc9_ = null;
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public static function tryDecodeSocketData(param1:ByteArray, param2:ADFHead) : ProtocolBase
      {
         var _loc3_:Class = null;
         var _loc4_:ProtocolBase = null;
         var _loc5_:Boolean = false;
         var _loc6_:Message = null;
         if(Boolean(param1) && Boolean(param2))
         {
            _loc3_ = NetProtocalCenter.getS2CProtocalClassByHash(param2.cmdID,false);
            if(_loc3_ != null)
            {
               if((_loc4_ = new _loc3_() as ProtocolBase) is I_S2C_Socket)
               {
                  _loc5_ = Boolean(I_S2C_Socket(_loc4_).readData(param1));
                  return _loc4_;
               }
               if(_loc4_ is I_S2C_ProtoBuf)
               {
                  (_loc6_ = I_S2C_ProtoBuf(_loc4_).getS2CMessage()).readExternal(param1);
                  I_S2C_ProtoBuf(_loc4_).readProtoBuf(_loc6_);
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      public static function tryDecodeCgiData(param1:XML, param2:String) : ProtocolBase
      {
         var _loc3_:Class = null;
         var _loc4_:ProtocolBase = null;
         if(param1 != null && Boolean(param2))
         {
            _loc3_ = NetProtocalCenter.getS2CProtocalClassByHash(param2,true);
            if(_loc3_ != null)
            {
               if((_loc4_ = new _loc3_() as ProtocolBase) is I_S2C_CGI)
               {
                  I_S2C_CGI(_loc4_).decodeCGI(param1);
                  return _loc4_;
               }
            }
         }
         return null;
      }
      
      private static function onGetRawData(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc6_:ByteArray = null;
         var _loc7_:XML = null;
         var _loc8_:ADFHead = null;
         var _loc9_:String = null;
         var _loc10_:Class = null;
         var _loc11_:ProtocolBase = null;
         var _loc12_:Boolean = false;
         var _loc13_:Message = null;
         var _loc5_:Array;
         if((Boolean(_loc5_ = param2 as Array)) && Boolean(_loc5_[0]))
         {
            _loc8_ = _loc5_[1] as ADFHead;
            _loc9_ = _loc5_[1] as String;
            if(_loc8_)
            {
               _loc10_ = NetProtocalCenter.getS2CProtocalClassByHash(_loc8_.cmdID,false);
            }
            else
            {
               _loc10_ = NetProtocalCenter.getS2CProtocalClassByHash(_loc9_,true);
            }
            if(_loc10_ != null)
            {
               if((_loc11_ = new _loc10_() as ProtocolBase) is I_S2C_Socket)
               {
                  (_loc6_ = _loc5_[0] as ByteArray).position = 0;
                  if(!(_loc12_ = Boolean(I_S2C_Socket(_loc11_).readData(_loc6_))))
                  {
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_DECODED_DATA_ERROR,[_loc11_,_loc8_]);
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA_ERROR,[_loc11_,_loc8_]);
                  }
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_SOCKET_DECODED_DATA,[_loc11_,_loc8_]);
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA,[_loc11_,_loc8_]);
               }
               else if(_loc11_ is I_S2C_ProtoBuf)
               {
                  (_loc6_ = _loc5_[0] as ByteArray).position = 0;
                  (_loc13_ = I_S2C_ProtoBuf(_loc11_).getS2CMessage()).readExternal(_loc6_);
                  if(!(_loc12_ = Boolean(I_S2C_ProtoBuf(_loc11_).readProtoBuf(_loc13_))))
                  {
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_DECODED_DATA_ERROR,[_loc11_,_loc8_]);
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA_ERROR,[_loc11_,_loc8_]);
                  }
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_PROTOBUF_DECODED_DATA,[_loc11_,_loc8_]);
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA,[_loc11_,_loc8_]);
               }
               else if(_loc11_ is I_S2C_CGI)
               {
                  _loc7_ = _loc5_[0] as XML;
                  if(!(_loc12_ = Boolean(I_S2C_CGI(_loc11_).decodeCGI(_loc7_))))
                  {
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_CGI_DECODED_DATA_ERROR,[_loc11_,_loc9_]);
                     CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA_ERROR,[_loc11_,_loc9_]);
                  }
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_CGI_DECODED_DATA,[_loc11_,_loc9_]);
                  CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_ON_GET_A_DECODED_DATA,[_loc11_,_loc9_]);
               }
            }
         }
         return CallbackCenter.EVENT_OK;
      }
      
      public static function getS2CProtocalClassByHash(param1:Object, param2:Boolean = true) : Class
      {
         if(param1)
         {
            if(s_s2cDict[param1])
            {
               return s_s2cDict[param1] as Class;
            }
         }
         return null;
      }
      
      public static function getC2SProtocalClassByHash(param1:Object, param2:Boolean = true) : Class
      {
         if(param1)
         {
            if(s_c2sDict[param1])
            {
               return s_c2sDict[param1] as Class;
            }
         }
         return null;
      }
      
      public static function getS2CProtocalClass(param1:ProtocolBase) : Class
      {
         if(param1)
         {
            return getS2CProtocalClassByHash(param1.getProtocolId());
         }
         return null;
      }
      
      public static function getC2SProtocalClass(param1:ProtocolBase) : Class
      {
         if(param1)
         {
            return getC2SProtocalClassByHash(param1.getProtocolId());
         }
         return null;
      }
   }
}
