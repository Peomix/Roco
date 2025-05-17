package com.QQ.angel.ui.core
{
   import BitmapFont.font.v9.TextFieldBitmap;
   import BitmapFont.font.v9.TextFormatBitmap;
   import BitmapFont.util.TextFieldToBitmap;
   import com.QQ.angel.api.utils.CFunction;
   import com.QQ.angel.data.entity.NumericData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol157")]
   public class NumericPanel extends Window implements IManagedWin
   {
      
      public var bg:Sprite;
      
      public var closeBtn:SimpleButton;
      
      public var title_0:Sprite;
      
      public var title_1:Sprite;
      
      public var label_0:TextField;
      
      public var label_1:TextField;
      
      public var label_2:TextField;
      
      private var tfb_0:TextFieldBitmap;
      
      private var tfb_1:TextFieldBitmap;
      
      private var tfb_2:TextFieldBitmap;
      
      public var icon_0:MovieClip;
      
      public var icon_1:MovieClip;
      
      public var icon_2:MovieClip;
      
      public var add_0:Sprite;
      
      public var add_1:Sprite;
      
      public var add_2:Sprite;
      
      public var nums_0:DefaultNumberMC;
      
      public var nums_1:DefaultNumberMC;
      
      public var nums_2:DefaultNumberMC;
      
      public var nums_3:DefaultNumberMC;
      
      public var knowBtn:SimpleButton;
      
      public var double_money:SimpleButton;
      
      protected var data:NumericData;
      
      protected var props:Array = ["expVal","money","honor","power","charm","intellect"];
      
      protected var propsName:Array = ["学 分","洛克贝","声 望","体 能","魅 力","智 慧"];
      
      protected var currIndex:int = 0;
      
      protected var handler:CFunction;
      
      public function NumericPanel(param1:DisplayObjectContainer, param2:Boolean = false)
      {
         super();
         this.initUIS();
         initialize(param1,this.bg,this.closeBtn,null,param2);
      }
      
      public function setData(param1:Object) : void
      {
         if(!(param1 is NumericData))
         {
            return;
         }
         this.data = param1 as NumericData;
         this.title_1.visible = this.data.type == 0;
         this.title_0.visible = !this.title_1.visible;
         this.nums_3.visible = !this.title_1.visible;
         if(this.data.score != -1)
         {
            this.nums_3.setValue(this.data.score);
         }
         this.double_money.visible = false;
         this.currIndex = 0;
         this.setNumericData();
      }
      
      public function bindHandler(param1:CFunction) : void
      {
         this.handler = param1;
      }
      
      protected function setNumericData() : Boolean
      {
         var _loc3_:String = null;
         var _loc4_:int = 0;
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         while(_loc2_ < 3 && this.currIndex < this.props.length)
         {
            _loc3_ = this.props[this.currIndex];
            _loc4_ = this.data == null ? -1 : int(this.data[_loc3_]);
            if(_loc4_ != -1)
            {
               if(this.data.is_double_money > 0 && _loc3_ == "money")
               {
                  this.double_money.visible = true;
                  this.double_money.y = this["icon_" + _loc2_].y;
               }
               this["icon_" + _loc2_].visible = true;
               this["nums_" + _loc2_].visible = true;
               this["tfb_" + _loc2_].visible = true;
               this["add_" + _loc2_].visible = true;
               this["icon_" + _loc2_].gotoAndStop(this.currIndex + 1);
               (this["nums_" + _loc2_] as DefaultNumberMC).setValue(_loc4_,true);
               this["tfb_" + _loc2_].text = this.propsName[this.currIndex] + ":";
               _loc1_ = true;
               _loc2_++;
            }
            ++this.currIndex;
         }
         while(_loc2_ < 3)
         {
            this["icon_" + _loc2_].visible = false;
            this["nums_" + _loc2_].visible = false;
            this["tfb_" + _loc2_].visible = false;
            this["add_" + _loc2_].visible = false;
            _loc2_++;
         }
         return _loc1_;
      }
      
      protected function onKnowClick(param1:MouseEvent) : void
      {
         this.close();
      }
      
      protected function initUIS() : void
      {
         this.title_0.mouseEnabled = false;
         this.title_0.visible = false;
         this.title_1.mouseEnabled = false;
         this.label_0.mouseEnabled = false;
         this.label_1.mouseEnabled = false;
         this.label_2.mouseEnabled = false;
         this.tfb_0 = TextFieldToBitmap.replace(this.label_0,true);
         this.tfb_1 = TextFieldToBitmap.replace(this.label_1,true);
         this.tfb_2 = TextFieldToBitmap.replace(this.label_2,true);
         var _loc1_:TextFormatBitmap = new TextFormatBitmap();
         _loc1_.font = "DFPHaiBaoW12.MDF";
         _loc1_.size = 20;
         _loc1_.align = TextFormatAlign.RIGHT;
         _loc1_.color = 3032262;
         _loc1_.letterSpacing = 2;
         this.tfb_0.defaultTextFormat = _loc1_;
         this.tfb_1.defaultTextFormat = _loc1_;
         this.tfb_2.defaultTextFormat = _loc1_;
         this.icon_0.mouseEnabled = false;
         this.icon_0.stop();
         this.icon_1.mouseEnabled = false;
         this.icon_1.stop();
         this.icon_2.mouseEnabled = false;
         this.icon_2.stop();
         this.nums_3 = new DefaultNumberMC();
         this.nums_3.x = 152;
         this.nums_3.y = 38;
         addChild(this.nums_3);
         this.nums_0 = new DefaultNumberMC();
         this.nums_0.x = 204;
         this.nums_0.y = 96;
         addChild(this.nums_0);
         this.nums_1 = new DefaultNumberMC();
         this.nums_1.x = 204;
         this.nums_1.y = 136;
         addChild(this.nums_1);
         this.nums_2 = new DefaultNumberMC();
         this.nums_2.x = 204;
         this.nums_2.y = 177;
         addChild(this.nums_2);
         this.knowBtn.addEventListener(MouseEvent.CLICK,this.onKnowClick);
      }
      
      override public function show() : void
      {
         super.show();
         center();
      }
      
      override public function close() : void
      {
         if(this.setNumericData())
         {
            return;
         }
         super.close();
         var _loc1_:CFunction = this.handler;
         this.handler = null;
         if(_loc1_ != null)
         {
            _loc1_.invoke();
         }
         this.handler = null;
      }
   }
}

