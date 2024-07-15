package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   [Embed(source="/_assets/assets.swf", symbol="GiftPacksIconBar")]
   public dynamic class GiftPacksIconBar extends MovieClip
   {
       
      
      public var container:MovieClip;
      
      public var expandBtn:SimpleButton;
      
      public var closeBtn:SimpleButton;
      
      public var bgOpen:MovieClip;
      
      public var bgClose:MovieClip;
      
      public function GiftPacksIconBar()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
