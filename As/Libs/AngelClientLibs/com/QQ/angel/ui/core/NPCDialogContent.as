package com.QQ.angel.ui.core
{
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class NPCDialogContent extends Sprite implements IWindowContent
   {
      
      public static const HIDE_CHILDREN:String = "hideChildren";
      
      public static const SHOW_CHILDREN:String = "showChildren";
       
      
      private var _content:Sprite;
      
      private var _cache:DefaultImgCache;
      
      private var _head:Object;
      
      private var _dialogues:Array;
      
      private var _dialogueIndex:int;
      
      public function NPCDialogContent()
      {
         super();
         this._content = new NPCDialogContentUI();
         addChild(this._content);
         var _loc1_:Number = this._dialogue.width;
         this._dialogue.autoSize = "left";
         this._dialogue.width = _loc1_;
         this._dialogue.mouseEnabled = false;
         this._dialogue.mouseWheelEnabled = false;
         this._cache = new DefaultImgCache();
         this._head = new AImage(0,0,true);
         this._head.setImageCache(this._cache);
         this._content["npc"].addChild(this._head);
         this._btnNext.addEventListener(MouseEvent.CLICK,this._nextClick);
         if(this._btnNext.parent)
         {
            this._btnNext.parent.removeChild(this._btnNext);
         }
         this.clear();
      }
      
      public function clear() : void
      {
         this._npcname.htmlText = "";
         try
         {
            this._head.unload();
         }
         catch(err:Error)
         {
         }
         this._dialogue.text = "";
         if(this._btnNext.parent)
         {
            this._btnNext.parent.removeChild(this._btnNext);
         }
      }
      
      public function dispose() : void
      {
         this._btnNext.removeEventListener(MouseEvent.CLICK,this._nextClick);
         if(this._btnNext.parent)
         {
            this._content.removeChild(this._btnNext);
         }
         this._cache.disposeAll();
         this._cache = null;
         try
         {
            this._head.unload();
         }
         catch(err:Error)
         {
         }
         this._head.parent.removeChild(this._head);
         this._head = null;
         removeChild(this._content);
         this._content = null;
      }
      
      private function _nextClick(param1:MouseEvent) : void
      {
         this._nextDialogue();
      }
      
      public function fill(param1:Array) : void
      {
         this._dialogues = param1 || [];
         if(this._dialogues.length < 1)
         {
            this._dialogues.push({
               "text":"Neil//没有任何对话内容或协议解析错误!",
               "npcURL":"",
               "npcName":""
            });
         }
         this._dialogueIndex = -1;
         this._nextDialogue();
      }
      
      private function _nextDialogue(param1:int = -1) : void
      {
         this._dialogueIndex = param1 < 0 ? this._dialogueIndex + 1 : param1;
         this._dialogueIndex = Math.max(0,Math.min(this._dialogues.length - 1,this._dialogueIndex));
         this._dialogue.htmlText = this._removeWrap(this._dialogues[this._dialogueIndex].text || "");
         if(this._dialogues[this._dialogueIndex].npcName)
         {
            this._npcname.htmlText = "<b>" + (this._dialogues[this._dialogueIndex].npcName || "") + "：</b>";
         }
         if(this._dialogues[this._dialogueIndex].npcURL)
         {
            this._head.setPath(this._dialogues[this._dialogueIndex].npcURL);
         }
         if(this._dialogueIndex < this._dialogues.length - 1)
         {
            this._content.addChild(this._btnNext);
            dispatchEvent(new Event(HIDE_CHILDREN));
         }
         else
         {
            if(this._btnNext.parent)
            {
               this._btnNext.parent.removeChild(this._btnNext);
            }
            dispatchEvent(new Event(SHOW_CHILDREN));
         }
      }
      
      private function _removeWrap(param1:String) : String
      {
         param1 ||= "";
         param1 = param1.replace(/\r/g,"");
         return param1.replace(/\n+/g,"\n");
      }
      
      private function get _btnNext() : SimpleButton
      {
         return this._content["next"];
      }
      
      private function get _npcname() : TextField
      {
         return this._content["npcname"];
      }
      
      private function get _dialogue() : TextField
      {
         return this._content["dialogue"];
      }
   }
}
