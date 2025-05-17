package DataInfoCenterUtil
{
   import flash.utils.getTimer;
   
   public class DataInfoPair
   {
      
      public var hash:Object;
      
      public var dataInfo:Object;
      
      private var referece:int;
      
      private var m_timeStamp:int;
      
      public function DataInfoPair(param1:Object = null, param2:Object = null)
      {
         super();
         this.hash = param2;
         this.dataInfo = param1;
      }
      
      public function updateTimeStamp() : void
      {
         this.m_timeStamp = getTimer();
      }
      
      public function get timeStamp() : int
      {
         return this.m_timeStamp;
      }
      
      public function grab(param1:Object) : void
      {
         ++this.referece;
      }
      
      public function drop(param1:Object) : void
      {
         if(this.referece)
         {
            --this.referece;
         }
         if(this.referece == 0)
         {
            this.dispose();
         }
      }
      
      private function dispose() : void
      {
         this.hash = null;
         if(this.dataInfo && this.dataInfo.hasOwnProperty("dispose") && this.dataInfo["dispose"] is Function)
         {
            this.dataInfo["dispose"]();
         }
         this.dataInfo = null;
      }
   }
}

