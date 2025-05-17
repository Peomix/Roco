package BitmapFont.font
{
   public class LayoutInfo
   {
      
      public static const ALIGN_NULL:int = 0;
      
      public static const ALIGN_HCENTER:int = 1;
      
      public static const ALIGN_VCENTER:int = 2;
      
      public static const ALIGN_LEFT:int = 4;
      
      public static const ALIGN_RIGHT:int = 8;
      
      public static const ALIGN_TOP:int = 16;
      
      public static const ALIGN_BOTTOM:int = 32;
      
      public static const ALIGN_SYNC_WIDTH:int = 64;
      
      public static const ALIGN_SYNC_HEIGHR:int = 128;
      
      public static const ALIGN_HVCENTER:int = ALIGN_HCENTER | ALIGN_VCENTER;
      
      public static const ALIGN_LEFT_TOP:int = ALIGN_LEFT | ALIGN_TOP;
      
      public static const ALIGN_RIGHT_TOP:int = ALIGN_RIGHT | ALIGN_TOP;
      
      public static const ALIGN_LEFT_BOTTOM:int = ALIGN_LEFT | ALIGN_BOTTOM;
      
      public static const ALIGN_RIGHT_BOTTOM:int = ALIGN_RIGHT | ALIGN_BOTTOM;
      
      public static const ALIGN_LEFT_VCENTER:int = ALIGN_LEFT | ALIGN_VCENTER;
      
      public static const ALIGN_RIGHT_VCENTER:int = ALIGN_RIGHT | ALIGN_VCENTER;
      
      public static const ALIGN_HCENTER_TOP:int = ALIGN_HCENTER | ALIGN_TOP;
      
      public static const ALIGN_HCENTER_BOTTOM:int = ALIGN_HCENTER | ALIGN_BOTTOM;
      
      public function LayoutInfo()
      {
         super();
      }
   }
}

