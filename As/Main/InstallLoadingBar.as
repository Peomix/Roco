package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="InstallLoadingBar")]
   public dynamic class InstallLoadingBar extends Sprite
   {
       
      
      public var msg_txt:TextField;
      
      public var bar:MovieClip;
      
      public function InstallLoadingBar()
      {
         super();
      }
   }
}
