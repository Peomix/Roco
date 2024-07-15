package BitmapFont.font.v9
{
   import BitmapFont.IDispose;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.ColorTransform;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;
   
   public class TextFieldBitmap extends Shape implements IDispose
   {
       
      
      private var m_text:String;
      
      private var m_type:String;
      
      protected var m_textChanged:Boolean;
      
      internal var m_textFormat:TextFormatBitmap;
      
      public var background:Boolean;
      
      public var border:Boolean;
      
      public var backgroundColor:uint;
      
      public var borderColor:uint;
      
      internal var m_textHeight:int;
      
      internal var m_textHeightWithHide:int;
      
      internal var m_textWidth:int;
      
      internal var m_quickDrawData:ByteArray;
      
      internal var m_boundWidth:uint;
      
      internal var m_boundHeight:uint;
      
      internal var m_caretIndex:int;
      
      internal var m_maxScrollV:int;
      
      internal var m_scrollV:int;
      
      public function TextFieldBitmap()
      {
         super();
         this.m_quickDrawData = new ByteArray();
         this.m_textHeight = -1;
         this.m_textHeightWithHide = -1;
         this.m_textWidth = -1;
         this.m_caretIndex = 0;
         this.m_maxScrollV = 0;
         this.m_scrollV = 0;
         this.background = false;
         this.border = false;
         this.backgroundColor = 4294967295;
         this.borderColor = 4278190080;
      }
      
      public function dispose() : void
      {
         if(this.m_quickDrawData)
         {
            this.m_quickDrawData.length = 0;
            this.m_quickDrawData = null;
         }
         this.m_text = null;
         this.m_type = null;
         this.m_textFormat = null;
      }
      
      public function get text() : String
      {
         return this.m_text;
      }
      
      public function set text(param1:String) : void
      {
         this.m_text = param1;
         this.m_textChanged = true;
         this.render();
      }
      
      public function get textHeight() : int
      {
         if(this.m_textHeight == -1 || this.m_textChanged)
         {
            this.computeLayout();
         }
         ASSERT(this.m_textHeight >= 0 && this.m_textHeight <= this.m_boundHeight,"error");
         return this.m_textHeight;
      }
      
      public function get textWidth() : int
      {
         if(this.m_textWidth == -1 || this.m_textChanged)
         {
            this.computeLayout();
         }
         ASSERT(this.m_textWidth >= 0 && this.m_textWidth <= this.m_boundWidth,"error");
         return this.m_textWidth;
      }
      
      override public function get width() : Number
      {
         return this.m_boundWidth;
      }
      
      override public function get height() : Number
      {
         return this.m_boundHeight;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this.m_boundWidth != param1)
         {
            this.m_textChanged = true;
            this.m_boundWidth = param1;
            this.m_textWidth = -1;
            this.m_textHeight = -1;
            this.m_textHeightWithHide = -1;
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(this.m_boundHeight != param1)
         {
            this.m_textChanged = true;
            this.m_boundHeight = param1;
            this.m_quickDrawData.length = 0;
            this.m_quickDrawData.position = 0;
            this.m_textWidth = -1;
            this.m_textHeight = -1;
            this.m_textHeightWithHide = -1;
         }
      }
      
      public function set defaultTextFormat(param1:TextFormat) : void
      {
         this.m_textFormat = TextFormatBitmap(param1);
         this.m_textChanged = true;
         var _loc2_:ColorTransform = new ColorTransform();
         var _loc3_:int = int(param1.color);
         _loc2_.redMultiplier = (_loc3_ >> 16 & 255) / 255;
         _loc2_.greenMultiplier = (_loc3_ >> 8 & 255) / 255;
         _loc2_.blueMultiplier = (_loc3_ & 255) / 255;
         this.transform.colorTransform = _loc2_;
         this.render();
      }
      
      public function get defaultTextFormat() : TextFormat
      {
         return this.m_textFormat;
      }
      
      private function computeLayout() : void
      {
         var _loc1_:Array = null;
         if(this.m_textChanged)
         {
            this.m_textWidth = -1;
            this.m_textChanged = false;
            this.m_quickDrawData.length = 0;
            this.m_quickDrawData.position = 0;
            if(Boolean(this.m_text) && Boolean(this.m_textFormat))
            {
               if(this.m_textFormat.fontBase)
               {
                  this.m_textFormat.fontBase.prepareText(this.m_textFormat,this.m_text);
                  _loc1_ = this.m_textFormat.fontBase.formatText(this,this.m_textFormat);
               }
            }
            else
            {
               this.m_maxScrollV = this.m_caretIndex = this.m_scrollV = 0;
            }
         }
      }
      
      public function render() : void
      {
         this.computeLayout();
         var _loc1_:Graphics = graphics;
         _loc1_.clear();
         if(this.background)
         {
            _loc1_.beginFill(this.backgroundColor & 16777215,(this.backgroundColor >> 24 & 255) / 255);
         }
         if(this.border)
         {
            _loc1_.lineStyle(0,this.borderColor & 16777215,(this.borderColor >> 24 & 255) / 255);
         }
         if(this.background || this.border)
         {
            _loc1_.drawRect(0,0,this.width,this.height);
            _loc1_.endFill();
         }
         if(this.border)
         {
            _loc1_.lineStyle(NaN);
         }
         if(this.text)
         {
            this.m_textFormat.render(this);
         }
      }
   }
}
