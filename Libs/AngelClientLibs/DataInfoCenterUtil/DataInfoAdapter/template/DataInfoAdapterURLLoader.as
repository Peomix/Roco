package DataInfoCenterUtil.DataInfoAdapter.template
{
   import DataInfoCenterUtil.DataInfoCenter;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public class DataInfoAdapterURLLoader extends DataInfoAdapterBase
   {
       
      
      protected var m_url:String;
      
      private var m_urlLoader:URLLoader;
      
      protected var m_dataFormat:String;
      
      public function DataInfoAdapterURLLoader()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(this.m_urlLoader)
         {
            try
            {
               this.removeListenserURLLoader(this.m_urlLoader);
               this.m_urlLoader.close();
            }
            catch(e:Error)
            {
            }
            this.m_urlLoader = null;
         }
         this.m_dataFormat = null;
         super.dispose();
      }
      
      override public function load() : void
      {
         if(!this.m_url)
         {
            this.m_url = String(m_hash);
         }
         if(DataInfoCenter.getInstance().isErrorUrl(this.m_url))
         {
            this.dispose();
            return;
         }
         this.m_urlLoader = new URLLoader();
         this.m_urlLoader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandlerURLLoader);
         this.m_urlLoader.addEventListener(Event.COMPLETE,this.completeHandlerURLLoader);
         if(this.m_dataFormat != null)
         {
            this.m_urlLoader.dataFormat = this.m_dataFormat;
         }
         this.m_urlLoader.load(new URLRequest(this.m_url));
         m_isLoading = true;
         updateStartLoadingTimer();
      }
      
      protected function completeHandlerURLLoader(param1:Event) : void
      {
         this.removeListenserURLLoader(URLLoader(param1.currentTarget));
         m_isLoading = false;
      }
      
      private function removeListenserURLLoader(param1:URLLoader) : void
      {
         if(Boolean(param1) && param1.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            param1.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandlerURLLoader);
            param1.removeEventListener(Event.COMPLETE,this.completeHandlerURLLoader);
         }
      }
      
      private function errorHandlerURLLoader(param1:IOErrorEvent) : void
      {
         this.removeListenserURLLoader(URLLoader(param1.currentTarget));
         DataInfoCenter.getInstance().addErrorUrl(String(this.m_url));
         this.m_url = null;
         m_isLoading = false;
         this.dispose();
      }
   }
}
