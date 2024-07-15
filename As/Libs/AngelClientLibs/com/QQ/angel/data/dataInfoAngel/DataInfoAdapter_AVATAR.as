package com.QQ.angel.data.dataInfoAngel
{
   import CallbackUtil.CallbackCenter;
   import DataInfoCenterUtil.DataInfoCenter;
   import DataInfoCenterUtil.DataInfoPair;
   import com.QQ.angel.api.net.protocol.ADF;
   import com.QQ.angel.common.__global;
   import com.QQ.angel.data.CALLBACK;
   import com.QQ.angel.data.DataInfoType;
   import com.QQ.angel.data.protocol.SKT_0x030015_QueryUserDetailInfo_C2S;
   import com.QQ.angel.data.protocol.SKT_0x030015_QueryUserDetailInfo_S2C;
   import com.QQ.angel.data.protocolBase.ProtocolBase;
   import com.QQ.angel.data.templateAngel.DataInfoAdapterSocketMonitor;
   import flash.utils.ByteArray;
   
   public class DataInfoAdapter_AVATAR extends DataInfoAdapterSocketMonitor
   {
       
      
      private var m_sendingAvatarArray:Array;
      
      public function DataInfoAdapter_AVATAR()
      {
         this.m_sendingAvatarArray = new Array(9);
         super();
         m_netCmdArray = [196629,196619,196649];
         CallbackCenter.registerCallBack(CALLBACK.ANGEL_NET_ON_SEND_A_SOCKET_RAW_DATA,DataInfoAdapter_AVATAR.onSendRawData,this);
      }
      
      private static function onSendRawData(param1:int, param2:Object, param3:Object, param4:Object) : int
      {
         var _loc9_:ByteArray = null;
         var _loc10_:ADF = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc5_:String = new String();
         var _loc6_:Array = new Array();
         var _loc7_:DataInfoAdapter_AVATAR = DataInfoAdapter_AVATAR(param4);
         var _loc8_:Array;
         if((_loc8_ = param2 as Array)[0] is ByteArray)
         {
            _loc9_ = ByteArray(_loc8_[0]);
            _loc10_ = ADF(_loc8_[1]);
            _loc11_ = int(_loc9_.position);
            _loc9_.position = 20;
            if(_loc10_.head.cmdID == 196619)
            {
               _loc12_ = 0;
               while(_loc12_ < 9)
               {
                  _loc7_.m_sendingAvatarArray[_loc12_] = _loc9_.readUnsignedInt();
                  _loc12_++;
               }
            }
            else if(_loc10_.head.cmdID == 196649)
            {
               _loc12_ = 0;
               while(_loc12_ < 9)
               {
                  _loc7_.m_sendingAvatarArray[_loc12_] = 0;
                  _loc12_++;
               }
               _loc13_ = int(_loc9_.readUnsignedByte());
               _loc7_.m_sendingAvatarArray[_loc13_ - 1] = _loc9_.readUnsignedInt();
            }
            _loc9_.position = _loc11_;
         }
         return CallbackCenter.EVENT_OK;
      }
      
      override public function onDataGetted(param1:ProtocolBase) : void
      {
         var _loc2_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         if(param1["retCode"].code != 0)
         {
            return;
         }
         switch(param1.getProtocolId())
         {
            case 196629:
               _loc2_ = SKT_0x030015_QueryUserDetailInfo_S2C(param1).avatar.slice();
               break;
            case 196619:
            case 196649:
               break;
            default:
               return;
         }
         if(m_hash == null)
         {
            m_hash = __global.MainRoleData.uin;
         }
         var _loc3_:DataInfoPair = DataInfoCenter.getInstance().getDataInfoPair(DataInfoType.DATAINFO_TYPE_AVATAR,m_hash);
         var _loc4_:Boolean = false;
         if(!_loc3_)
         {
            if(!_loc2_)
            {
               return;
            }
            _loc3_ = new DataInfoPair(_loc2_,m_hash);
            DataInfoCenter.getInstance().addDataInfoPair(DataInfoType.DATAINFO_TYPE_AVATAR,_loc3_);
            _loc4_ = true;
         }
         else
         {
            _loc5_ = _loc3_.dataInfo as Array;
            if(_loc2_ == null)
            {
               _loc2_ = this.m_sendingAvatarArray.slice();
            }
            _loc6_ = 0;
            while(_loc6_ < 9)
            {
               if(_loc2_[_loc6_] != 0)
               {
                  if(_loc5_[_loc6_] != _loc2_[_loc6_])
                  {
                     _loc4_ = true;
                     _loc5_[_loc6_] = _loc2_[_loc6_];
                  }
               }
               _loc6_++;
            }
            _loc3_.updateTimeStamp();
         }
         if(_loc4_)
         {
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_DATAINFO_AVATAR_LOADED,_loc3_);
         }
      }
      
      override public function canDealDataInfoType(param1:int) : Boolean
      {
         return param1 == DataInfoType.DATAINFO_TYPE_AVATAR;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.m_sendingAvatarArray = null;
         CallbackCenter.unregisterCallBack(CALLBACK.ANGEL_NET_ON_SEND_A_SOCKET_RAW_DATA,DataInfoAdapter_AVATAR.onSendRawData,this);
      }
      
      private function removeRef(param1:ProtocolBase) : void
      {
         m_isLoading = false;
         DataInfoCenter.getInstance().removeAdapterQueue(this);
      }
      
      override public function load() : void
      {
         var _loc2_:SKT_0x030015_QueryUserDetailInfo_C2S = null;
         var _loc1_:uint = uint(m_hash);
         if(_loc1_ == __global.MainRoleData.uin)
         {
            _loc2_ = new SKT_0x030015_QueryUserDetailInfo_C2S();
            _loc2_.qqUin = _loc1_;
            CallbackCenter.notifyEvent(CALLBACK.ANGEL_NET_APPLY_SEND_A_SOCKET_PROTOCAL,[_loc2_,this.removeRef]);
         }
         m_isLoading = true;
         updateStartLoadingTimer();
      }
   }
}
