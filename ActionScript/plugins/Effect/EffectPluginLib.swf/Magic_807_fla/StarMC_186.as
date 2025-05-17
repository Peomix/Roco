package Magic_807_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol23")]
   public dynamic class StarMC_186 extends MovieClip
   {
      
      public function StarMC_186()
      {
         super();
         addFrameScript(10,frame11);
      }
      
      internal function frame11() : *
      {
         this.dispatchEvent(new Event("onMVEnd"));
      }
   }
}

