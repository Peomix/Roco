package com.QQ.angel.ui.core
{
   import flash.display.InteractiveObject;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   
   public class PagerProxy extends EventDispatcher
   {
       
      
      public var onPageChange:Function;
      
      protected var btnPrevPage:InteractiveObject;
      
      protected var btnNextPage:InteractiveObject;
      
      protected var tfPage:Object;
      
      private var __currentPage:int;
      
      private var __totalPages:int;
      
      protected var isTxtTotal:Boolean = true;
      
      public function PagerProxy(param1:InteractiveObject, param2:InteractiveObject, param3:Object)
      {
         super();
         this.btnNextPage = param2;
         this.btnPrevPage = param1;
         this.tfPage = param3;
         this.btnPrevPage.addEventListener(MouseEvent.CLICK,this._onPrevPage);
         this.btnNextPage.addEventListener(MouseEvent.CLICK,this._onNextPage);
      }
      
      public function dispose() : void
      {
         this.btnPrevPage.removeEventListener(MouseEvent.CLICK,this._onPrevPage);
         this.btnNextPage.removeEventListener(MouseEvent.CLICK,this._onNextPage);
      }
      
      public function setTxtTotal(param1:Boolean) : void
      {
         this.isTxtTotal = param1;
      }
      
      public function setPage(param1:int, param2:int) : void
      {
         this.__currentPage = param1 > 0 ? param1 : 1;
         this.__totalPages = param2 > 0 ? param2 : 1;
         this.__currentPage = this.__currentPage <= this.__totalPages ? this.__currentPage : this.__totalPages;
         this.refresh();
      }
      
      public function prev() : void
      {
         this.setPage(this.__currentPage - 1,this.__totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this.__currentPage,this.__totalPages);
         }
      }
      
      public function next() : void
      {
         this.setPage(this.__currentPage + 1,this.__totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this.__currentPage,this.__totalPages);
         }
      }
      
      public function jump(param1:int) : void
      {
         this.setPage(param1,this.__totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this.__currentPage,this.__totalPages);
         }
      }
      
      public function get currentPage() : int
      {
         return this.__currentPage;
      }
      
      public function get totalPages() : int
      {
         return this.__totalPages;
      }
      
      public function setVisible(param1:Boolean) : void
      {
         if(this.btnPrevPage != null)
         {
            this.btnPrevPage.visible = param1;
            this.btnNextPage.visible = param1;
            this.tfPage.visible = param1;
         }
      }
      
      protected function refresh() : void
      {
         BTNHelp.setBTNEnabled(this.btnPrevPage,this.__currentPage > 1);
         BTNHelp.setBTNEnabled(this.btnNextPage,this.__currentPage < this.__totalPages);
         this.tfPage.text = this.__currentPage + (this.isTxtTotal ? " / " + this.__totalPages : "");
      }
      
      private function _onPrevPage(param1:MouseEvent) : void
      {
         this.prev();
      }
      
      private function _onNextPage(param1:MouseEvent) : void
      {
         this.next();
      }
   }
}
