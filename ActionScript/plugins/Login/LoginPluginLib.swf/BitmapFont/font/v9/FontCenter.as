package BitmapFont.font.v9
{
   import flash.utils.Dictionary;
   
   public class FontCenter
   {
      
      private static var s_dict:Dictionary = new Dictionary();
      
      public function FontCenter()
      {
         super();
      }
      
      public static function regFont(param1:FontBase, param2:String) : void
      {
         if(!s_dict[param2])
         {
            s_dict[param2] = param1;
         }
      }
      
      public static function getRegedFont(param1:String) : FontBase
      {
         return s_dict[param1] as FontBase;
      }
   }
}

