package com.tencent.fge.foundation.sdt.Common
{
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SDTBase
   {
      
      protected static const version:String = "1.0.0";
      
      protected static const author:String = "slicoltang,slicol@qq.com";
      
      protected static const copyright:String = "腾讯计算机系统有限公司";
       
      
      private var m_data:SDData = null;
      
      private var m_dataChk:SDData = null;
      
      private var m_listener:SDListenerInterface = null;
      
      private var m_safeTimer:Timer;
      
      public function SDTBase(param1:Boolean = false, param2:uint = 0, param3:SDListenerInterface = null)
      {
         var _loc4_:int = 0;
         super();
         if(param1)
         {
            this.m_dataChk = new SDData();
         }
         if(param2 > 0)
         {
            _loc4_ = (_loc4_ = 60000 / param2) < 200 ? 200 : _loc4_;
            this.m_safeTimer = new Timer(_loc4_);
            this.m_safeTimer.addEventListener(TimerEvent.TIMER,this.onSafeTimer);
            this.m_safeTimer.start();
         }
      }
      
      protected function onSafeTimer(param1:Event) : void
      {
         if(this.m_data)
         {
            if(!this.m_data.refresh())
            {
               this.warn("数据刷新错误!");
            }
         }
      }
      
      public function dispose() : void
      {
         if(this.m_data)
         {
            this.m_data.dispose();
            this.m_data = null;
         }
         if(this.m_dataChk)
         {
            this.m_dataChk.dispose();
            this.m_dataChk = null;
         }
      }
      
      protected function setValue(param1:Object) : void
      {
         if(this.m_data)
         {
            this.m_data.dispose();
         }
         this.m_data = SDData.createByBytes(param1,this.m_listener);
         if(this.m_dataChk)
         {
            this.m_dataChk.dispose();
            this.m_dataChk = SDData.createByBytes(param1,null);
         }
      }
      
      protected function getValue() : Object
      {
         var _loc1_:Object = null;
         var _loc2_:Object = null;
         if(this.m_data)
         {
            _loc1_ = this.m_data.readStringBytes();
         }
         if(this.m_dataChk)
         {
            _loc2_ = this.m_dataChk.readStringBytes();
            if(!SDCore.compareBytes(_loc1_,_loc2_))
            {
               SDCore.freeBytes(_loc2_);
               this.error("数据较验错误!");
               return null;
            }
            SDCore.freeBytes(_loc2_);
         }
         return _loc1_;
      }
      
      public function serialize() : String
      {
         return this.m_data.serialize();
      }
      
      public function deserialize(param1:String) : void
      {
         this.m_data = SDData.createBySerialize(param1,this.m_listener);
      }
      
      private function error(param1:String) : void
      {
         if(this.m_listener)
         {
            this.m_listener.onError(param1);
         }
      }
      
      private function warn(param1:String) : void
      {
         if(this.m_listener)
         {
            this.m_listener.onWarn(param1);
         }
      }
   }
}
