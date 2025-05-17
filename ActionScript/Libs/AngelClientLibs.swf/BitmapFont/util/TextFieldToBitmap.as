package BitmapFont.util
{
   import BitmapFont.font.v9.TextFieldBitmap;
   import BitmapFont.font.v9.TextFormatBitmap;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TextFieldToBitmap
   {
      
      public function TextFieldToBitmap()
      {
         super();
      }
      
      public static function replace(param1:TextField, param2:Boolean = false, param3:String = "DFPHaiBaoW12.MDF") : TextFieldBitmap
      {
         var _loc7_:int = 0;
         var _loc4_:TextFieldBitmap = new TextFieldBitmap();
         _loc4_.x = param1.x;
         _loc4_.y = param1.y;
         _loc4_.width = param1.width;
         _loc4_.height = param1.height;
         _loc4_.border = param1.border;
         _loc4_.borderColor = param1.borderColor;
         _loc4_.background = param1.background;
         _loc4_.backgroundColor = param1.backgroundColor;
         _loc4_.filters = param1.filters;
         var _loc5_:TextFormat = param1.getTextFormat();
         var _loc6_:TextFormatBitmap = new TextFormatBitmap();
         _loc6_.font = param3;
         _loc6_.size = _loc5_.size;
         _loc6_.color = _loc5_.color;
         _loc6_.align = _loc5_.align;
         _loc6_.letterSpacing = _loc5_.letterSpacing;
         _loc6_.leading = _loc5_.leading;
         _loc4_.defaultTextFormat = _loc6_;
         _loc4_.text = param1.text;
         if(param2)
         {
            if(param1.parent)
            {
               _loc7_ = param1.parent.getChildIndex(param1);
               param1.parent.addChildAt(_loc4_,_loc7_);
               param1.parent.removeChild(param1);
            }
            param1 = null;
         }
         return _loc4_;
      }
   }
}

