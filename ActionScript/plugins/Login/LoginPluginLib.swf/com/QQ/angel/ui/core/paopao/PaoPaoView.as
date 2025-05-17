package com.QQ.angel.ui.core.paopao
{
   import com.QQ.angel.api.net.DEFINE;
   import com.QQ.angel.ui.core.namebg.BgLoader;
   import com.QQ.angel.ui.core.textfield.ImageTextField;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class PaoPaoView extends Sprite
   {
      
      private static const TEXT_MAX_WIDTH:int = 150;
      
      private static const TEXT_MAX_HEIGHT:int = 140;
      
      private var m_loader:BgLoader;
      
      private var m_paopaoAsset:MovieClip;
      
      private var m_chatStr:Object;
      
      private var m_bgView:MovieClip;
      
      private var m_minBgWidth:Number;
      
      private var m_chatTF:TextField;
      
      private var m_imageChatTF:ImageTextField;
      
      private var m_id:int;
      
      private var m_minchatTFWidth:Number;
      
      private var m_arrow_mc:MovieClip;
      
      private var m_ctView:MovieClip;
      
      private var m_ltView:MovieClip;
      
      private var m_rtView:MovieClip;
      
      private var m_lbView:MovieClip;
      
      private var m_rbView:MovieClip;
      
      private var m_minBgHeight:Number;
      
      private var m_chatTFBaseY:Number;
      
      private var m_minchatTFHeight:Number;
      
      private var m_ctBasePoint:Point;
      
      private var m_ltBasePoint:Point;
      
      private var m_rtBasePoint:Point;
      
      private var m_lbBasePoint:Point;
      
      private var m_rbBasePoint:Point;
      
      private var m_chatTFBaseX:Number;
      
      private var m_viewContainer:Sprite;
      
      private var m_isDazzle:Boolean;
      
      public function PaoPaoView(param1:int, param2:Boolean)
      {
         super();
         this.m_id = param1;
         this.m_isDazzle = param2;
         this.loadView();
      }
      
      private function loadView() : void
      {
         if(this.m_loader == null)
         {
            this.m_loader = new BgLoader();
            this.m_loader.addEventListener(Event.COMPLETE,this.__loadBgComplete);
            if(this.m_isDazzle)
            {
               this.m_loader.setPath(DEFINE.DAZZLE_DRESS_RES_ROOT + "28/" + this.m_id + ".swf");
            }
            else
            {
               this.m_loader.setPath(DEFINE.COMM_ROOT + "res/avatar/14/" + this.m_id + ".swf");
            }
         }
      }
      
      protected function __loadBgComplete(param1:Event) : void
      {
         this.m_paopaoAsset = this.m_loader.getLoaderInstance("OutAsset") as MovieClip;
         addChild(this.m_paopaoAsset);
         this.solveView();
         this.refreshView();
      }
      
      private function solveView() : void
      {
         this.m_bgView = this.m_paopaoAsset.background;
         this.m_chatTF = this.m_paopaoAsset.str_txt;
         this.m_chatTF.visible = false;
         this.m_arrow_mc = this.m_paopaoAsset.arrow_mc;
         this.m_ctView = this.m_paopaoAsset.ct_mc;
         this.m_ltView = this.m_paopaoAsset.lt_mc;
         this.m_rtView = this.m_paopaoAsset.rt_mc;
         this.m_lbView = this.m_paopaoAsset.lb_mc;
         this.m_rbView = this.m_paopaoAsset.rb_mc;
         this.m_minBgWidth = this.m_bgView.width;
         this.m_minBgHeight = this.m_bgView.height;
         this.m_minchatTFWidth = this.m_chatTF.width;
         this.m_minchatTFHeight = this.m_chatTF.height;
         this.m_chatTFBaseX = this.m_chatTF.x;
         this.m_chatTFBaseY = this.m_chatTF.y;
         this.m_chatTF.width = TEXT_MAX_WIDTH;
         this.m_chatTF.x = -this.m_chatTF.width / 2;
         this.m_imageChatTF = new ImageTextField();
         this.m_imageChatTF.width = TEXT_MAX_WIDTH;
         this.m_imageChatTF.maxHeight = TEXT_MAX_HEIGHT;
         this.m_imageChatTF.align = TextFieldAutoSize.CENTER;
         this.m_imageChatTF.x = this.m_chatTF.x;
         this.m_imageChatTF.filters = this.m_chatTF.filters;
         var _loc1_:Array = this.m_chatTF.htmlText.match(/#[\d\w]{6}/g);
         if(Boolean(_loc1_) && _loc1_.length > 0)
         {
            this.m_imageChatTF.color = parseInt(_loc1_[0].substr(1),16);
         }
         this.m_paopaoAsset.addChild(this.m_imageChatTF);
         if(this.m_ctView != null)
         {
            this.m_ctBasePoint = new Point(this.m_ctView.x,this.m_ctView.y);
         }
         if(this.m_ltView != null)
         {
            this.m_ltBasePoint = new Point(this.m_ltView.x,this.m_ltView.y);
         }
         if(this.m_rtView != null)
         {
            this.m_rtBasePoint = new Point(this.m_rtView.x,this.m_rtView.y);
         }
         if(this.m_lbView != null)
         {
            this.m_lbBasePoint = new Point(this.m_lbView.x,this.m_lbView.y);
         }
         if(this.m_rbView != null)
         {
            this.m_rbBasePoint = new Point(this.m_rbView.x,this.m_rbView.y);
         }
         this.m_viewContainer = new Sprite();
         this.m_paopaoAsset.addChild(this.m_viewContainer);
      }
      
      public function setChatStr(param1:Object, param2:Boolean = false) : void
      {
         this.m_chatStr = param1;
         this.refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:DisplayObject = null;
         if(this.m_paopaoAsset == null)
         {
            return;
         }
         while(this.m_viewContainer.numChildren > 0)
         {
            this.m_viewContainer.removeChildAt(0);
         }
         if(this.m_chatStr is String)
         {
            this.m_imageChatTF.visible = true;
            this.m_imageChatTF.htmlText = String(this.m_chatStr) || "";
            if(this.m_imageChatTF.height > TEXT_MAX_HEIGHT)
            {
               _loc3_ = TEXT_MAX_HEIGHT;
            }
            else
            {
               _loc3_ = this.m_imageChatTF.height;
            }
            _loc1_ = _loc3_ - this.m_minchatTFHeight;
            _loc2_ = this.m_imageChatTF.width - this.m_minchatTFWidth;
            this.m_imageChatTF.y = this.m_chatTFBaseY - _loc1_ + 8;
         }
         else
         {
            if(!(this.m_chatStr is DisplayObject))
            {
               return;
            }
            this.m_imageChatTF.htmlText = "";
            this.m_imageChatTF.visible = false;
            _loc4_ = DisplayObject(this.m_chatStr);
            this.m_viewContainer.addChild(_loc4_);
            _loc1_ = _loc4_.height - this.m_minchatTFHeight;
            _loc2_ = _loc4_.width - this.m_minchatTFWidth;
            _loc4_.x = -_loc4_.width / 2;
            _loc4_.y = this.m_chatTFBaseY + this.m_minchatTFHeight - _loc4_.height;
         }
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
         }
         this.m_bgView.width = this.m_minBgWidth + _loc2_;
         this.m_bgView.height = this.m_minBgHeight + _loc1_;
         if(this.m_ctView != null)
         {
            this.m_ctView.y = this.m_ctBasePoint.y - _loc1_;
         }
         if(this.m_ltView != null)
         {
            this.m_ltView.x = this.m_ltBasePoint.x - _loc2_ / 2;
            this.m_ltView.y = this.m_ltBasePoint.y - _loc1_;
         }
         if(this.m_rtView != null)
         {
            this.m_rtView.x = this.m_rtBasePoint.x + _loc2_ / 2;
            this.m_rtView.y = this.m_rtBasePoint.y - _loc1_;
         }
         if(this.m_lbView != null)
         {
            this.m_lbView.x = this.m_lbBasePoint.x - _loc2_ / 2;
         }
         if(this.m_rbView != null)
         {
            this.m_rbView.x = this.m_rbBasePoint.x + _loc2_ / 2;
         }
      }
   }
}

