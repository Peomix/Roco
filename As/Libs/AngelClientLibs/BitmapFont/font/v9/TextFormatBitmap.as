package BitmapFont.font.v9
{
   import BitmapFont.font.LayoutInfo;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class TextFormatBitmap extends TextFormat
   {
       
      
      private var m_fontBase:FontBase;
      
      public var spaceSize:uint;
      
      public var alignInfo:int;
      
      public function TextFormatBitmap()
      {
         super();
      }
      
      override public function get align() : String
      {
         if(this.alignInfo & LayoutInfo.ALIGN_HCENTER)
         {
            return TextFormatAlign.CENTER;
         }
         if(this.alignInfo & LayoutInfo.ALIGN_RIGHT)
         {
            return TextFormatAlign.RIGHT;
         }
         return TextFormatAlign.LEFT;
      }
      
      override public function set align(param1:String) : void
      {
         if(param1 == TextFormatAlign.CENTER)
         {
            this.alignInfo = LayoutInfo.ALIGN_HCENTER;
         }
         else if(param1 == TextFormatAlign.RIGHT)
         {
            this.alignInfo = LayoutInfo.ALIGN_RIGHT;
         }
         else
         {
            this.alignInfo = LayoutInfo.ALIGN_LEFT;
         }
      }
      
      override public function set font(param1:String) : void
      {
         super.font = param1;
         this.fontBase = FontCenter.getRegedFont(param1);
      }
      
      public function get fontBase() : FontBase
      {
         return this.m_fontBase;
      }
      
      public function set fontBase(param1:FontBase) : void
      {
         this.m_fontBase = param1;
         if(this.m_fontBase)
         {
            this.spaceSize = this.m_fontBase.m_defaultSpaceSize;
            size = this.m_fontBase.getDefaultFontSize();
         }
      }
      
      internal function render(param1:TextFieldBitmap) : void
      {
         if(this.m_fontBase)
         {
            this.m_fontBase.render(param1,this);
         }
      }
   }
}
