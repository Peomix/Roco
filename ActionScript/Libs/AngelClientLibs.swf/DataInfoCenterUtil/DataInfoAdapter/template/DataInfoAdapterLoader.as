package DataInfoCenterUtil.DataInfoAdapter.template
{
   import DataInfoCenterUtil.DataInfoCenter;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class DataInfoAdapterLoader extends DataInfoAdapterBase
   {
      
      protected var m_url:String;
      
      private var m_loader:Loader;
      
      public function DataInfoAdapterLoader()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(this.m_loader)
         {
            try
            {
               this.removeListenserLoader(this.m_loader.loaderInfo);
               this.m_loader.close();
            }
            catch(e:Error)
            {
            }
            this.m_loader = null;
         }
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
         this.m_loader = new Loader();
         this.m_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandlerLoader);
         this.m_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.completeHandlerLoader);
         this.m_loader.load(new URLRequest(this.m_url));
         m_isLoading = true;
         updateStartLoadingTimer();
      }
      
      protected function completeHandlerLoader(param1:Event) : void
      {
         this.removeListenserLoader(LoaderInfo(param1.currentTarget));
         this.m_loader = null;
         m_isLoading = false;
      }
      
      private function removeListenserLoader(param1:LoaderInfo) : void
      {
         if(Boolean(param1) && param1.hasEventListener(IOErrorEvent.IO_ERROR))
         {
            param1.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandlerLoader);
            param1.removeEventListener(Event.COMPLETE,this.completeHandlerLoader);
         }
      }
      
      private function errorHandlerLoader(param1:IOErrorEvent) : void
      {
         this.removeListenserLoader(LoaderInfo(param1.currentTarget));
         this.m_loader = null;
         DataInfoCenter.getInstance().addErrorUrl(this.m_url);
         this.m_url = null;
         m_isLoading = false;
         this.dispose();
      }
   }
}

