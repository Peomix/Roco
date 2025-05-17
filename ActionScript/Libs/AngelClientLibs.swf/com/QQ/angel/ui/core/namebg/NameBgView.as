package com.QQ.angel.ui.core.namebg
{
   import com.QQ.angel.api.net.DEFINE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class NameBgView extends Sprite
   {
      
      private var m_loader:BgLoader;
      
      private var m_nameAsset:MovieClip;
      
      private var m_nameStr:String;
      
      private var m_minBgWidth:Number;
      
      private var m_nameTF:TextField;
      
      private var m_id:int;
      
      private var m_completeCallBack:Function;
      
      private var m_textColor:uint;
      
      private var m_isDazzle:Boolean = false;
      
      public function NameBgView(param1:int = 0)
      {
         super();
         this.setNameBgId(param1);
      }
      
      public function setNameBgId(param1:int, param2:Boolean = false) : void
      {
         if(this.m_id != param1 || param2 != this.m_isDazzle)
         {
            this.m_id = param1;
            this.m_isDazzle = param2;
            this.loadView();
         }
      }
      
      public function setNameLoadCompleteFun(param1:Function) : void
      {
         this.m_completeCallBack = param1;
      }
      
      private function loadView() : void
      {
         this.resetView();
         if(this.m_id != 0)
         {
            this.m_loader = new BgLoader();
            this.m_loader.addEventListener(Event.COMPLETE,this.__loadBgComplete);
            if(!this.m_isDazzle)
            {
               this.m_loader.setPath(DEFINE.COMM_ROOT + "res/avatar/13/" + this.m_id + ".swf");
            }
            else
            {
               this.m_loader.setPath(DEFINE.DAZZLE_DRESS_RES_ROOT + "27/" + this.m_id + ".swf");
            }
         }
      }
      
      private function resetView() : void
      {
         if(this.m_loader != null)
         {
            this.m_loader.unload();
            this.m_loader.removeEventListener(Event.COMPLETE,this.__loadBgComplete);
         }
         if(this.m_nameAsset != null)
         {
            removeChild(this.m_nameAsset);
            this.m_nameAsset = null;
         }
      }
      
      protected function __loadBgComplete(param1:Event) : void
      {
         this.m_nameAsset = this.m_loader.getLoaderInstance("OutAsset") as MovieClip;
         this.m_loader = null;
         addChild(this.m_nameAsset);
         this.m_nameTF = this.m_nameAsset.txtName;
         this.m_nameTF.autoSize = TextFieldAutoSize.CENTER;
         this.refreshView();
         if(this.m_completeCallBack != null)
         {
            if(this.m_completeCallBack.length == 1)
            {
               this.m_completeCallBack(this);
            }
            else
            {
               this.m_completeCallBack();
            }
         }
      }
      
      public function setName(param1:String) : void
      {
         this.m_nameStr = param1;
         this.refreshView();
      }
      
      public function setTextColor(param1:uint) : void
      {
         this.m_textColor = param1;
         this.refreshView();
      }
      
      private function refreshView() : void
      {
         if(this.m_nameAsset == null)
         {
            return;
         }
         this.m_nameTF.textColor = this.m_textColor;
         this.m_nameAsset.txtName.text = this.m_nameStr || "";
      }
      
      public function getTextField() : TextField
      {
         return this.m_nameTF;
      }
   }
}

