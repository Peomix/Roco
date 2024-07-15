package com.QQ.angel.ui.core
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Pager extends Sprite
   {
       
      
      public var onPageChange:Function;
      
      public var btnPrevPage:SimpleButton;
      
      public var btnNextPage:SimpleButton;
      
      public var tfPage:TextField;
      
      protected var _currentPage:int;
      
      protected var _totalPages:int;
      
      public function Pager(param1:int = 1, param2:int = 1)
      {
         super();
         this.setPage(param1,param2);
         this.btnPrevPage.addEventListener(MouseEvent.CLICK,this._onPrevPage);
         this.btnNextPage.addEventListener(MouseEvent.CLICK,this._onNextPage);
      }
      
      public function dispose() : void
      {
         this.btnPrevPage.removeEventListener(MouseEvent.CLICK,this._onPrevPage);
         this.btnNextPage.removeEventListener(MouseEvent.CLICK,this._onNextPage);
      }
      
      public function setPage(param1:int, param2:int) : void
      {
         this._currentPage = param1 > 0 ? param1 : 1;
         this._totalPages = param2 > 0 ? param2 : 1;
         this._currentPage = this._currentPage <= this._totalPages ? this._currentPage : this._totalPages;
         this.refresh();
      }
      
      public function prev() : void
      {
         this.setPage(this._currentPage - 1,this._totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this._currentPage,this._totalPages);
         }
      }
      
      public function next() : void
      {
         this.setPage(this._currentPage + 1,this._totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this._currentPage,this._totalPages);
         }
      }
      
      public function jump(param1:int) : void
      {
         this.setPage(param1,this._totalPages);
         if(this.onPageChange != null)
         {
            this.onPageChange(this._currentPage,this._totalPages);
         }
      }
      
      public function get currentPage() : int
      {
         return this._currentPage;
      }
      
      public function get totalPages() : int
      {
         return this._totalPages;
      }
      
      protected function refresh() : void
      {
         this.btnPrevPage.visible = this._currentPage > 1;
         this.btnNextPage.visible = this._currentPage < this._totalPages;
         this.tfPage.text = this._currentPage + " / " + this._totalPages;
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
